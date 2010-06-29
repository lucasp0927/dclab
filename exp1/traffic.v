module traffic (/*AUTOARG*/
		// Outputs
		db, buttonlight, stoplight, seg0, seg1, seg2, seg3,
		// Inputs
		clk, button, stop_button, plus_button, minus_button
		);

   parameter countersize = 6;
   // Local Variables:
   // verilog-auto-inst-param-value:t
   // End:
   
   input clk;
   input button;
   input stop_button;
   input plus_button;
   input minus_button;
   
   
   output [9:0] db;
   output 	buttonlight;
   output 	stoplight;
   output [6:0] seg0, seg1, seg2, seg3;
   
   reg [countersize-1:0] counter; // every mode can have duration at most 32 secs
   reg [24:0] 		 clks;
   reg [14:0] 		 msclks;
   reg [21:0] 		 clkfast; //1/8seconds
   reg [3:0] 		 mode;
   reg [countersize-1:0] sec[9:0];
   reg 			 next;
   reg [9:0] 		 buttoncount;
   reg [3:0] 		 hex0, hex1, hex2, hex3;
   reg 			 plus, tmp_plus;
   reg 			 minus, tmp_minus;
   integer               thousandcount;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire 		 stop;			// From stop_oneshot1 of stop_oneshot.v
   // End of automatics
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg 			 buttonlight;
   reg [9:0] 		 db;
   reg 			 stoplight;
   // End of automatics
   
   initial
     begin
	thousandcount = 1024;
	sec[0] = {{{countersize-4{1'b0}},4'd15}};
	sec[1] = {{{countersize-4{1'b0}},4'd4}};
	sec[2] = {{{countersize-4{1'b0}},4'd2}};
	sec[3] = {{{countersize-4{1'b0}},4'd1}};
	sec[4] = {{{countersize-4{1'b0}},4'd1}};
	sec[5] = {{{countersize-4{1'b0}},4'd15}};
	sec[6] = {{{countersize-5{1'b0}},5'd4}};
	sec[7] = {{{countersize-4{1'b0}},4'd2}};
	sec[8] = {{{countersize-4{1'b0}},4'd1}};
	sec[9] = {{{countersize-4{1'b0}},4'd1}};
     end // initial begin

   
   wire clksrc1_1; // phase lock loop
   clksrc clksrc1 ( , clk, clksrc1_1, );

   
   /* plusminus_oneshot AUTO_TEMPLATE (
    .clk (msclks[14]),
    );*/
   plusminus_oneshot plusminus_oneshot1 (/*AUTOINST*/
					 // Outputs
					 .plus			(plus),
					 .minus			(minus),
					 // Inputs
					 .clk			(msclks[14]),	 // Templated
					 .plus_button		(plus_button),
					 .minus_button		(minus_button));
   always @(posedge msclks[14]) begin
      if(plus != tmp_plus)
	sec[mode] <= sec[mode]+1'd1;
      tmp_plus <= plus;
      if(minus != tmp_minus)
	sec[mode] <= sec[mode]-1'd1;
      tmp_minus <= minus;
   end

   
   /* stop_oneshot AUTO_TEMPLATE (
    .clk (msclks[14]),
    );*/
   stop_oneshot stop_oneshot1 (/*AUTOINST*/
			       // Outputs
			       .stop		(stop),
			       // Inputs
			       .clk		(msclks[14]),	 // Templated
			       .stop_button	(stop_button));

   
   
   always @(*) begin // stoplight show whether the traffic light is paused.
      stoplight = stop;
   end

   always @ (posedge clksrc1_1) begin
      clks <= clks + 1'b1; 
      clkfast <= clkfast + 1'b1;
      msclks <= msclks + 1'b1;
   end
   
   always @(posedge msclks[14]) begin // 1/1000 sec
      if (counter > sec[mode]) begin
	 counter = sec[mode];
      end
      if (thousandcount == 0) begin           //every 1000 times, ie: every 1 sec.
	 if (stop == 1'b0) begin              //not stop
	    if ((counter != 0) && (next  == 0) ) begin
	       counter <= counter - 1'b1;
	    end else begin
	       if (mode == 4'd9) begin
		  mode <= 4'd0;
	       end else begin
		  mode <= mode + 1'b1;   
	       end
	       counter <= sec[mode+1];
	    end // always @ (posedge clks[24])
	 end else begin // if (stop == 1'b0)  //stop
	    if (next == 1) begin
	       if (mode == 4'd9) begin
		  mode <= 4'd0;
	       end else begin
		  mode <= mode + 1'b1;   
	       end
	       counter <= sec[mode+1];
	    end 
	 end // else: !if(stop == 1'b0)
	 thousandcount <= 1024;
      end else begin
	 thousandcount <= thousandcount - 1;
      end
   end

   always @(posedge clkfast[21]) begin 
      case(mode)
	4'd0 : db <= 10'b0010110010;
	4'd1 :
	  if (db == 10'b0010110010) begin
	     db <= 10'b0010010010;
	  end else begin
	     db <= 10'b0010110010;
	  end
	4'd2: db = 10'b0011010010;
	4'd3: db = 10'b0101010010;
	4'd4: db = 10'b1001010010;
	4'd5: db = 10'b1001000101;
	4'd6 :
	  if (db == 10'b1001000101) begin
	     db <= 10'b1001000100;
	  end else begin
	     db <= 10'b1001000101;
	  end
	4'd7: db = 10'b1001000110;
	4'd8: db = 10'b1001001010;
	4'd9: db = 10'b1001010010;     
      endcase 
   end

   always @(posedge msclks[14]) begin
      if (button == 0) begin
	 buttoncount <= 10'd1000;
	 next <= 1'b1;
      end else begin
	 if (buttoncount != 10'd0) begin
	    buttoncount <= buttoncount - 10'd1;
	 end else begin
	    buttoncount <= 10'd0;
	 end
      end
      if (buttoncount == 10'd0) begin
	 next <= 1'b0;
      end else begin
	 next <= 1'b1;
      end
   end
   always @(/*AS*/next) begin
      buttonlight = next;
   end // always @ begin

   /* seg_decode AUTO_TEMPLATE (
    .seg (seg@[]),
    .hex (hex@[]));
    */

   seg_decode s0 (/*AUTOINST*/
		  // Outputs
		  .seg			(seg0[6:0]),		 // Templated
		  // Inputs
		  .hex			(hex0[3:0]));		 // Templated
   seg_decode s1 (/*AUTOINST*/
		  // Outputs
		  .seg			(seg1[6:0]),		 // Templated
		  // Inputs
		  .hex			(hex1[3:0]));		 // Templated
   seg_decode s2 (/*AUTOINST*/
		  // Outputs
		  .seg			(seg2[6:0]),		 // Templated
		  // Inputs
		  .hex			(hex2[3:0]));		 // Templated
   seg_decode s3 (/*AUTOINST*/
		  // Outputs
		  .seg			(seg3[6:0]),		 // Templated
		  // Inputs
		  .hex			(hex3[3:0]));		 // Templated
   
   always @(/*AS*/ /*memory or*/ counter or mode) begin
      hex0 = counter / 10;
      hex1 = counter % 10;
      hex2 = sec[mode] /10;
      hex3 = sec[mode] % 10;
   end
   
endmodule // traffic
