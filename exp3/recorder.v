module recorder (/*AUTOARG*/
   // Outputs
   addr_o, ce, oe, we, ub, lb, dacdat, i2c_clk, i2c_dat, sclk, sdat,
   reset_out, send_o, reset_tmp_o, reset_counter_o, reset_state_o,
   // Inouts
   io,
   // Inputs
   play_dirty, record_dirty, reset_dirty, clkfast, bclk, adclrc,
   adcdat, daclrc
   );
   input play_dirty, record_dirty, reset_dirty;
   input clkfast;
   //io of sram
   output [17:0] addr_o;
   output 	 ce, oe, we, ub, lb;
   inout [15:0]  io;
   // io  of adc
   input 	 bclk, adclrc, adcdat;
   // io of dac	 
   output 	 dacdat;
   input 	 daclrc;
   // io of i2c
   output 	 i2c_clk;
   output 	 i2c_dat;

   //debug
   output 	 sclk, sdat, reset_out,send_o;
   output [1:0]  reset_tmp_o;
   output [6:0]  reset_counter_o;
   output [3:0]  reset_state_o;
   
   always @(*) begin
      reset_out = reset;
      sdat = i2c_dat;
      sclk = i2c_clk;
   end

   
   reg [17:0] 	 addr;
      
   reg 	 play, record, reset;
   wire  clk;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]		data;			// From adc1 of adc.v
   wire			read;			// From dac1 of dac.v
   wire			write;			// From adc1 of adc.v
   // End of automatics
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			reset_out;
   reg			sclk;
   reg			sdat;
   // End of automatics

   pll pll1 ( , clkfast,clk, );

   i2c i2c1 (/*AUTOINST*/
	     // Outputs
	     .i2c_clk			(i2c_clk),
	     .i2c_dat			(i2c_dat),
	     .send_o			(send_o),
	     .reset_tmp_o		(reset_tmp_o[1:0]),
	     .reset_counter_o		(reset_counter_o[6:0]),
	     .reset_state_o		(reset_state_o[3:0]),
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
	     .record			(record));
   dac dac1 (/*AUTOINST*/
	     // Outputs
	     .read			(read),
	     .dacdat			(dacdat),
	     .addr			(addr[17:0]),
	     // Inputs
	     .play			(play),
	     .bclk			(bclk),
	     .daclrc			(daclrc),
	     .data			(data[15:0]));
   
   debounce debounce1 (
		       // Outputs
		       .clean		(reset),
		       // Inputs
		       .clks		(clkfast),
		       .noisy		(reset_dirty));
   debounce debounce2 (
		       // Outputs
		       .clean		(play),
		       // Inputs
		       .clks		(clkfast),
		       .noisy		(play_dirty));
   debounce debounce3 (
		       // Outputs
		       .clean		(record),
		       // Inputs
		       .clks		(clkfast),
		       .noisy		(record_dirty));

endmodule
