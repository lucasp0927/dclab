module recorder (/*AUTOARG*/
		 // Outputs
		 addr_o, ce, oe, we, ub, lb, dacdat, i2c_clk, i2c_dat,clk,
		 //Outputs of 7-segment displays
		 a1,a0,b,c3,c2,c1,c0,
		 // Inouts
		 io,
		 // Inputs
		 play_dirty, record_dirty, reset_dirty, clkfast, bclk, adclrc,
		 adcdat, daclrc,   number0_dirty,number1_dirty,number2_dirty,number3_dirty,
		 speed_dirty,slowmethod_dirty,inverse_dirty
		 );

   input play_dirty, record_dirty, reset_dirty, inverse_dirty;
   input number0_dirty,number1_dirty,number2_dirty,number3_dirty;
   input speed_dirty,slowmethod_dirty;
   input clkfast;
   //io of sram
   output [17:0] addr_o;
   output 	 ce, oe, we, ub, lb, clk;
   inout [15:0]  io;
   // io  of adc
   input 	 bclk, adclrc, adcdat;
   // io of dac	 
   output 	 dacdat;
   input 	 daclrc;
   // io of i2c
   output 	 i2c_clk;
   output 	 i2c_dat;

   output [6:0]  a1,a0;
   output [6:0]  b;
   output [6:0]  c3,c2,c1,c0;

   //7-segment display
   reg [6:0] 	 a1,a0,b,c3,c2,c1,c0;
   reg [6:0] 	 fast_buffer,slow_buffer;
   reg [3:0] 	 a1_tmp,a0_tmp;
   
   reg [17:0] 	 addr;
   reg 		 play, record, reset, inverse;
   wire 	 clk;
   reg [3:0] 	 slow,fast;
   reg 		 slowmethod;

   reg [4:0] 	 number;
   
   always @ (*) begin	  
      a0_tmp = (addr/8192 )% 10;
      a1_tmp = (addr/8192 )/ 10;    
   end 
   //   reg [10:0] clkslow;
   //   always @(posedge clk) begin
   //      clkslow <= clkslow + 1;
   //   end
/*
   always @(*) begin
      slow = 8;
      fast = 1;
   end
*/

   always @ (*) begin        
      if (speed == 1) begin
	 slow = 1;
	 fast = number;
      end else begin
	 fast = 1;
	 slow = number;
      end
   end // always @ (*)


   seg_decode s0 (/*AUTOINST*/
		  // Outputs
		  .seg			(fast_buffer[6:0]),
		  // Inputs
		  .hex			(fast[3:0]));
   
   seg_decode s1 (/*AUTOINST*/
		  // Outputs
		  .seg			(slow_buffer[6:0]),
		  // Inputs
		  .hex			(slow[3:0]));
   
   seg_decode s2 (/*AUTOINST*/
		  // Outputs
		  .seg			(a1[6:0]),
		  // Inputs
		  .hex			(a1_tmp[3:0]));

   seg_decode s3 (/*AUTOINST*/
		  // Outputs
		  .seg			(a0[6:0]),
		  // Inputs
		  .hex			(a0_tmp[3:0]));
   
   always @ (*) begin

       //play mode
       if(reset==0 && record==0 && play==0 && stop==0 && fast <= 8 && slow<=8 )begin
       if(fast == 4'd1 && slow == 4'd1 ) begin
       //display norl 
       c3 = 7'b0101011;
       c2 = 7'b0100011;
       c1 = 7'b0101111;
       c0 = 7'b1111001;
      end else begin 
       if (speed==1)begin
       //display fas+times
       c3 = 7'b0001110;
       c2 = 7'b0001000;
       c1 = 7'b0010010;
       c0 = fast_buffer;
        end else begin
       //display slo+times
       c3 = 7'b0010010;
       c2 = 7'b1111001;
       c1 = 7'b1000000;
       c0 = slow_buffer;
        end
      end        
    end else begin
       if (reset==0 && record==1 && play==0 && stop==0)begin       
       //display rec 
       c3 = 7'b1001110;
       c2 = 7'b0000100;
       c1 = 7'b1000110;
       c0 = 7'b1111111; 
      end else begin
       if (reset==1 && record==0 && play==0 && stop==0)begin    
       //display res
       c3 = 7'b1001110;
       c2 = 7'b0000100;
       c1 = 7'b0010010;
       c0 = 7'b1111111; 
         end else begin
       if (reset==0 && record==0 && play==0 && stop==1)begin
       //display sop 
       c3 = 7'b0010010;
       c2 = 7'b1000000;
       c1 = 7'b0001100;
       c0 = 7'b1111111; 
           end else begin
       if (reset==0 && record==0 && play==1 && stop==0)begin
       //display play
       c3 = 7'b0001100;
       c2 = 7'b1111001;
       c1 = 7'b0001000;
       c0 = 7'b0011001;
             end else begin
       //display eorr
       c3 = 7'b0000100;
       c2 = 7'b1000000;
       c1 = 7'b1001110;
       c0 = 7'b1001110;
             end                                     
           end
         end
      end
    end
   end

      //7-segment of slow_order

      always @(*) begin
	 if(slowmethod==0) begin
	    b=7'b1000000;
	 end else begin
	    b=7'b1111001;
	 end
      end

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]		data;			// From adc1 of adc.v
   wire			read;			// From dac1 of dac.v
   wire			write;			// From adc1 of adc.v
   // End of automatics
   /*AUTOREG*/

   /*
    * phase lock loop, change 50Mhz to 12Mhz
    */
   pll pll1 ( , clkfast,clk, );

   /*
    * i2c protocol
    */
   i2c i2c1 (/*AUTOINST*/
	     // Outputs
	     .i2c_clk			(i2c_clk),
	     .i2c_dat			(i2c_dat),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset));
   
   sram sram1 (/*AUTOINST*/
	       // Outputs
	       .addr_o			(addr_o[17:0]),
	       .ce			(ce),
	       .oe			(oe),
	       .we			(we),
	       .ub			(ub),
	       .lb			(lb),
	       // Inouts
	       .io			(io[15:0]),
	       .data			(data[15:0]),
	       // Inputs
	       .addr			(addr[17:0]),
	       .read			(read),
	       .write			(write),
	       .play			(play),
	       .record			(record));
   
   adc adc1 (/*AUTOINST*/
	     // Outputs
	     .addr			(addr[17:0]),
	     .data			(data[15:0]),
	     .write			(write),
	     // Inputs
	     .bclk			(bclk),
	     .adclrc			(adclrc),
	     .adcdat			(adcdat),
	     .reset                     (reset),
	     .record			(record));
   
   dac dac1 (/*AUTOINST*/
	     // Outputs
	     .read			(read),
	     .dacdat			(dacdat),
	     .addr			(addr[17:0]),
	     // Inputs
	     .slow                      (slow[3:0]),  //make it play slower 2= 1/2, 3=1/3  etc..
	     .slowmethod                (slowmethod), // 0  for zero order, 1 for first order
	     .fast                      (fast[3:0]),
	     .play			(play),
	     .bclk			(bclk),
	     .daclrc			(daclrc),
	     .reset                     (reset),
	     .inverse                   (inverse),
	     .data			(data[15:0]));
   
   debounce debounce1 (
		       // Outputs
		       .clean		(reset),
		       // Inputs
		       .clks		(clk),
		       .noisy		(reset_dirty));
   debounce debounce2 (
		       // Outputs
		       .clean		(play),
		       // Inputs
		       .clks		(clk),
		       .noisy		(play_dirty));
   debounce debounce3 (
		       // Outputs
		       .clean		(record),
		       // Inputs
		       .clks		(clk),
		       .noisy		(record_dirty));
   debounce debounce4 (
		       // Outputs
		       .clean		(number[1]),
		       // Inputs
		       .clks		(clk),
		       .noisy		(number1_dirty));

   debounce debounce5 (
		       // Outputs
		       .clean		(number[2]),
		       // Inputs
		       .clks		(clk),
		       .noisy		(number2_dirty));
   
   debounce debounce6 (
		       // Outputs
		       .clean		(number[3]),
		       // Inputs
		       .clks		(clk),
		       .noisy		(number3_dirty));

   debounce debounce7 (
		       // Outputs
		       .clean		(slowmethod),
		       // Inputs
		       .clks		(clk),
		       .noisy		(slowmethod_dirty));

   debounce debounce8 (
		       // Outputs
		       .clean		(speed),
		       // Inputs
		       .clks		(clk),
		       .noisy		(speed_dirty));	
   
   debounce debounce9 (
		       // Outputs
		       .clean		(stop),
		       // Inputs
		       .clks		(clk),
		       .noisy		(stop_dirty));	
   
   debounce debounce10 (
			// Outputs
			.clean		(number[0]),
			// Inputs
			.clks		(clk),
			.noisy		(number0_dirty));
   debounce debounce11 (
			// Outputs
			.clean		(inverse),
			// Inputs
			.clks		(clk),
			.noisy		(inverse_dirty));		       

endmodule
