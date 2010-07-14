module i2c (/*AUTOARG*/
   // Outputs
   i2c_clk, i2c_dat, send_o, reset_tmp_o, reset_counter_o,
   reset_state_o,
   // Inputs
   clk, reset
   );
   input clk,reset;
   //   input bclk;
   output i2c_clk, i2c_dat;
   // output dac_on, adc_on;


   /*
    * debug
    */

   output send_o;
   always @(*) begin
      send_o = send;
   end
   output [1:0] reset_tmp_o;
   always @(*) begin
      reset_tmp_o = reset_tmp;
   end
   output [6:0] reset_counter_o;
   always @(*) begin
      reset_counter_o = reset_counter;
   end
   output [3:0] reset_state_o;
   always @(*) begin
      reset_state_o = reset_state;
   end

   
   reg [0:26] i2c_pass;
   reg [0:26] i2c_reset[0:11];
   reg [4:0] 	  clk_slow;
   integer 	  i2c_counter;
   reg 		  send;  //1 when package not send.

   reg 		  start_ready, send_ready;
   reg [1:0] 	  play_tmp, record_tmp, reset_tmp;
   reg [2:0] 	  send_counter;
   integer 	  count_1;
   reg [3:0] 	  reset_state;
   reg [6:0] 	  reset_counter;
   reg 		  ready_1,ready_2;	  
   /*AUTOWIRE*/
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			i2c_clk;
   reg			i2c_dat;
   reg [6:0]		reset_counter_o;
   reg [3:0]		reset_state_o;
   reg [1:0]		reset_tmp_o;
   reg			send_o;
   // End of automatics

   initial begin
      send = 0;
      start_ready =0;
      send_ready =0;
      send_counter=0;
      count_1 = 0;
      reset_state = 0;
      reset_counter = 0;
      ready_1 = 0;
      ready_2 = 0;
   end
   
   always @(*) begin
      i2c_clk = clk_slow[4];
   end
   
   always @(negedge clk) begin
      clk_slow <= clk_slow + 4'b1;
   end
////////////////////////////////////////////////////////////////////////////////////////////////////
// control send
////////////////////////////////////////////////////////////////////////////////////////////////////   
   always @(posedge clk_slow[3]) begin
      if ((reset_tmp == 2'b01) || (reset_state != 0)) begin
	 if (reset_state == 0) begin
	    reset_state <= 1;
	 end 

	 if (reset_counter == 60) begin
	    if (reset_state == 11) begin
	       reset_state <= 0;
	    end else begin
	       reset_state <= reset_state + 1;
	    end
	    reset_counter <= 0;
	 end else begin
	    reset_counter <= reset_counter + 1;
	 end
      end else begin // if ((reset_tmp = 2'b01) || (reset_state != 0))
	 reset_counter <= 0;
	 reset_state <= 0;
      end
      //make send stay 1 for two clock
      /*
      if ((play_tmp == 2'b01) || (record_tmp == 2'b01)) begin
	 send_counter <= 2;
      end else begin
	 if (send_counter == 0) begin
	    send_counter <= 0;
	 end else begin
	    send_counter <= send_counter - 1;
	 end
      end
      play_tmp[1] <= play_tmp[0];
      play_tmp[0] <= play;
      record_tmp[1] <= record_tmp[0];
      record_tmp[0] <= record;
       */
      reset_tmp[1] <= reset_tmp[0];
      reset_tmp[0] <= reset;
   end

   always @(*) begin
      if ((reset_counter == 1) || (reset_counter == 2)) begin
	 send = 1;
      end else begin
	 send = 0;
      end
   end

////////////////////////////////////////////////////////////////////////////////////////////////////
//    control i2c signals
////////////////////////////////////////////////////////////////////////////////////////////////////   
   always @ (posedge clk_slow[3]) begin
      if ( (send==1 && clk_slow[4]==1)&& ready_1==0 ) begin
	 ///////////first thing start/////////
	 i2c_dat <= 0;
	 start_ready <= 1;
	 //////////first thing stop ////////
	 ready_1 <= 1;
      end else begin
	 if(count_1 != 0 || ready_1 == 1) begin
	    ready_1 <= 0;
	    ////////second thing start////////
	    i2c_dat <= i2c_reset[reset_state][i2c_counter];
	    if (clk_slow[4] == 1) begin
	       if (i2c_counter == 26) begin
		  i2c_counter <= 0;
	       end else begin
		  i2c_counter <= i2c_counter + 1;
	       end
	    end
	    ////////second thing stop/////////
	    count_1 <=count_1 + 1;
	    
	    if(count_1 == 53) begin
	       count_1 <= 0;
	       ready_2 <= 1;
	    end 
	 end else begin  // if (count_1 != 0 || ready_1 ==1)
	    if (ready_2 == 1) begin
	       ///////////third thing start/////////
	       i2c_dat <= 0;
	       ready_2 <= 0;
	       /////////third thing stop////////
	    end else begin
	       i2c_dat <= 1;  ///normal/////
	    end
	 end
      end
   end
 /*   
   always @(posedge clk_slow[3]) begin
      if ((send == 1) && (clk_slow[4] == 0)) begin
	 i2c_dat <= 0;
	 start_ready <= 1;
      end else begin
	 i2c_dat <= 1;
      end

      
      i2c_dat <= i2c_pass[i2c_counter];
      if (clk_slow[4] == 1) begin
	 if (i2c_counter == 26) begin
	    i2c_counter <= 0;
	 end else begin
	    i2c_counter <= i2c_counter + 1;
	 end
      end
   end
*/
   
   always @(*) begin
//      i2c_pass = 27'b00110100_0_00001110_0_01000010_0;
      i2c_reset[1] = 27'b00110100_0_00011110_0_00000000_0; //reset
      i2c_reset[2] = 27'b00110100_0_00001000_0_00000001_0; //mic
      i2c_reset[3] = 27'b00110100_0_00000100_0_01111001_0; //headphone amp left
      i2c_reset[4] = 27'b00110100_0_00000110_0_01111001_0; //headphone amp right
      i2c_reset[5] = 27'b00110100_0_00001110_0_01_0_10010_0; //digital interface
      i2c_reset[6] = 27'b00110100_0_00010000_0_00001101_0; //sampling control
      i2c_reset[7] = 27'b00110100_0_00001000_0_11110101_0; //analogue audio path control
      i2c_reset[8] = 27'b00110100_0_00001010_0_00010011_0; //digital audio path control
   //   i2c_reset[9] = 27'b00110100_0_00010000_0_00000001_0;  //  trytrykan
//      i2c_reset[10] =27'b00110100_0_00010000_0_00000101_0;  //  trytrykan
      i2c_reset[11] = 27'b00110100_0_00001100_0_01100000_0;  //  Power Down Control
   end

endmodule
