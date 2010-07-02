module traffic (/*AUTOARG*/
   // Outputs
   buttonlight, db, stoplight, seg0, seg1, seg2, seg3, seg4, seg5,
   hori, vert,
   // Inputs
   clk, button, stop_button, plus_button, minus_button, reset_button,
   noisy
   );
   
   input clk;
   input button; //next need to be renamed?
   input stop_button, plus_button, minus_button, reset_button;
   input [12:0] noisy;
   
   output 	buttonlight; //next light need to be renamed
   output [9:0] db;
   output 	stoplight;
   output [6:0] seg0, seg1, seg2, seg3, seg4, seg5;
   output [7:0] hori, vert;

   //clocks
   reg [24:0] 	clks;
   reg [14:0] 	msclks;
   reg [21:0] 	clkfast; //1/8seconds need to be remaned
   
   //variables deal with edit
   reg [12:0] 	clean;
   reg [10:0] 	clean_tmp;

   reg [5:0] 	counter; // every mode can have duration at most 32 secs
   integer 	mode, modelimit;
   reg [26:0] 	modedata[15:0]; // sec, lights, lights, plan to add greenman light.

   reg 		next;
   reg [9:0] 	buttoncount; //make next last for one second, need to be renamed
   reg [3:0] 	hex0, hex1, hex2, hex3, hex4, hex5; //represent numbers sent to segdecode

   //variables dealt with plus and minus seconds.
   reg 		plus, tmp_plus, minus, tmp_minus, reset, tmp_reset;

   integer 	thousandcount;// count a second in a 1/1000 seconds always
   reg 		greenmanon;
   reg [1:0] 	edit_mode;
   reg [1:0] 	delete_mode;
   reg [1:0] 	edit_state[9:0];//dark light flicker
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			stop;			// From stop_oneshot1 of stop_oneshot.v
   // End of automatics
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			buttonlight;
   reg [9:0]		db;
   reg			stoplight;
   // End of automatics
   integer 	i,j,k; //for for-loop

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    phase lock loop
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   wire 	clksrc1_1; // phase lock loop
   clksrc clksrc1 ( , clk, clksrc1_1, );

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //   frequency devide
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   always @ (posedge clksrc1_1) begin
      clks <= clks + 1'b1; 
      clkfast <= clkfast + 1'b1;
      msclks <= msclks + 1'b1;
   end

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //     control mode
   ////////////////////////////////////////////////////////////////////////////////////////////////////   
   always @(posedge msclks[14]) begin // 1/1000 sec
      if (counter > modedata[mode][25:20]) 
	 counter <= modedata[mode][25:20];
      if (mode > modelimit) 
	 mode <= modelimit;
      if (thousandcount == 0) begin           //every 1000 times, ie: every 1 sec.
	 if (stop == 1'b0) begin              //not stop
	    if ((counter != 0) && (next  == 0) ) 
	       counter <= counter - 1'b1;
	    else begin
	       if (mode == modelimit) begin
		  mode <= 4'd0;
		  counter <= modedata[0][25:20];
	       end else begin
		  mode <= mode + 1'b1; 
		  counter <= modedata[mode+1][25:20];
	       end
	    end // always @ (posedge clks[24])
	 end else begin // if (stop == 1'b0)  //stop
	    if (next == 1) begin
	       if (mode == modelimit)
		  mode <= 4'd0;
	       else begin
		  mode <= mode + 1'b1;   
	       end
	       counter <= modedata[mode+1][25:20];
	    end 
	 end // else: !if(stop == 1'b0)
	 thousandcount <= 1024;
      end else 
	 thousandcount <= thousandcount - 1;
   end

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    control lights
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   always @(posedge clkfast[21]) begin  // connet lights tp data
      if (db == modedata[mode][9:0]) 
	 db <= modedata[mode][19:10];
      else 
	 db <= modedata[mode][9:0];
   end
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    make next last 1 second
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   
   always @(posedge msclks[14]) begin //next button
      if (button == 0) begin
	 buttoncount <= 10'd1000;
	 next <= 1'b1;
      end else begin
	 if (buttoncount != 10'd0) 
	    buttoncount <= buttoncount - 10'd1;
	  else 
	    buttoncount <= 10'd0;
      end
      if (buttoncount == 10'd0) 
	 next <= 1'b0;
       else 
	 next <= 1'b1;
   end // always @ (posedge msclks[14])
   
   always @(/*AS*/next) begin
      buttonlight = next;
   end // always @ begin
   
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   // one shot for plus minus and reset, need to be renamed.
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   
   /* plusminus_oneshot AUTO_TEMPLATE (
    .clk (msclks[14]),
    );*/
   plusminus_oneshot plusminus_oneshot1 (/*AUTOINST*/
					 // Outputs
					 .plus			(plus),
					 .minus			(minus),
					 .reset			(reset),
					 // Inputs
					 .clk			(msclks[14]),	 // Templated
					 .plus_button		(plus_button),
					 .minus_button		(minus_button),
					 .reset_button		(reset_button));

   ////////////////////////////////////////////////////////////////////////////////////////////////////
     //    plus, minus second. reset modedata, and edit modedata.
   ////////////////////////////////////////////////////////////////////////////////////////////////////   
   always @(posedge msclks[14]) begin
      if ((edit_mode[1] == 0)&&(delete_mode[1] == 0)) begin
	 if(plus != tmp_plus)
	   modedata[mode][25:20] <= modedata[mode][25:20]+1'd1;
	 tmp_plus <= plus;
	 if(minus != tmp_minus)
	   modedata[mode][25:20] <= modedata[mode][25:20]-1'd1;
	 tmp_minus <= minus;
	 
	 if (reset != tmp_reset) begin
	    //	       	greenmanon = 0;
	    modelimit <= 9; //10-1
      	    modedata[0] <= {{1'b1},{6'd15},{10'b0010110010},{10'b0010110010}};
	    modedata[1] <= {{1'b0},{6'd4,{10'b0010110010},{10'b0010010010}}};
	    modedata[2] <= {{1'b0},{6'd2},{10'b0011010010},{10'b0011010010}};
	    modedata[3] <= {{1'b0},{6'd1},{10'b0101010010},{10'b0101010010}};
	    modedata[4] <= {{1'b0},{6'd1},{10'b1001010010},{10'b1001010010}};
	    modedata[5] <= {{1'b1},{6'd15},{10'b1001000101},{10'b1001000101}};
	    modedata[6] <= {{1'b0},{6'd4},{10'b1001000101},{10'b1001000100}};
	    modedata[7] <= {{1'b0},{6'd2},{10'b1001000110},{10'b1001000110}};
	    modedata[8] <= {{1'b0},{6'd1},{10'b1001001010},{10'b1001001010}};
	    modedata[9] <= {{1'b0},{6'd1},{10'b1001010010},{10'b1001010010}};
	    //remember to write for loop
	 end
	 tmp_reset <= reset;
      end else begin // if ((edit_mode[1] == 0)&&(delete_mode[1] == 0))
	 if (delete_mode[0]!= delete_mode[1]) begin
	    ////////////////////////////////////////////////////////////////////////////////////////////////////
	    // delete mode
	    ////////////////////////////////////////////////////////////////////////////////////////////////////
	       modelimit <= modelimit - 1;
	       for (i = 0; i < 16; i = i +1) begin
   		  if (((mode-1)<i) && (i<(modelimit+1))&&(1<i)&&(i<15)) begin
		     modedata[i] <= modedata[i+1];
		  end 
   	       end
	 end else begin
	    ////////////////////////////////////////////////////////////////////////////////////////////////////
	    //  edit mode
	    ////////////////////////////////////////////////////////////////////////////////////////////////////
	    if(plus != tmp_plus)
	      modedata[mode][25:20] <= modedata[mode][25:20]+1'd1;
	    tmp_plus <= plus;
	    if(minus != tmp_minus)
	      modedata[mode][25:20] <= modedata[mode][25:20]-1'd1;
	    tmp_minus <= minus;
	    
	    if (edit_mode[0] != edit_mode[1]) begin
	       //////////////////////////////////////////////////
	       //clean current mode
	       //////////////////////////////////////////////////
	       modelimit <= modelimit + 1;
	       for (i = 0; i < 16; i = i +1) begin
   		  if ((mode<i) && (i<(modelimit+2))&&(1<i)&&(i<16)) begin
		     modedata[i] <= modedata[i-1];
		  end 
   	       end
	       modedata[mode] <= 26'b0;
	    end else begin
	       //////////////////////////////////////////////////
	       // edit
	       //////////////////////////////////////////////////
	       for (j=0; j<10; j = j+1) begin
		  //////////////////////////////////////////////////
		  // 	       use edit state to determine light
		  //////////////////////////////////////////////////
		  case (edit_state[j])
		    2'b00://dark
		      begin
			 modedata[mode][j]<=0;
			 modedata[mode][j+10]<=0;
		      end
		    2'b01://light
		      begin
			 modedata[mode][j]<=1;
			 modedata[mode][j+10]<=1;
		      end
		    2'b10://flicker
		      begin
			 modedata[mode][j]<=1;
			 modedata[mode][j+10]<=0;
		      end
		    default
		      begin
			 modedata[j][j]<=0;
			 modedata[j][j+10]<=0;
		      end
		  endcase
	       end // for (j=0; j<10; j = j+1)
	       if (clean[12]==1 )  //greenman
		 modedata[mode][26] <= 1;
	       else
		 modedata[mode][26] <= 0;
	    end
	 end // else: !if(edit_mode[1] == 0)
      end
      edit_mode[0]<=edit_mode[1];
      delete_mode[0]<=delete_mode[1];
   end // always @ (posedge msclks[14])

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    use toggle switch to switch between light state
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   always @(posedge msclks[14]) begin
      for (k=0; k<10; k = k+1)begin
	 if ((clean_tmp[k]==0) && (clean[k]==1)) begin
	    case (edit_state[k])
	      2'b00://dark
		edit_state[k] <= 2'b01;
	      2'b01://light
		edit_state[k] <= 2'b10;
	      2'b10://flicker
		edit_state[k] <= 2'b00;
	      default
		edit_state[k] <= 2'b00;
	    endcase
	 end
	 clean_tmp[k] <= clean[k];
      end
   end

   always @(*) begin
      edit_mode[1] =  clean[10];
      delete_mode[1]=clean[11];
   end


   ////////////////////////////////////////////////////////////////////////////////////////////////////
		//    one shot for stop
   ////////////////////////////////////////////////////////////////////////////////////////////////////   
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



   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    segment display
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   
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
   seg_decode s4(/*AUTOINST*/
		 // Outputs
		 .seg			(seg4[6:0]),		 // Templated
		 // Inputs
		 .hex			(hex4[3:0]));		 // Templated
   seg_decode s5 (/*AUTOINST*/
		  // Outputs
		  .seg			(seg5[6:0]),		 // Templated
		  // Inputs
		  .hex			(hex5[3:0]));		 // Templated
   
   
   always @(/*AS*/ /*memory or*/ counter or mode) begin
      hex0 = counter / 10;
      hex1 = counter % 10;
      hex2 = modedata[mode][25:20] /10;
      hex3 = modedata[mode][25:20] % 10;
      hex4 = (mode+1) / 10;
      hex5 = (mode+1) % 10;
   end

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    greenman
   ////////////////////////////////////////////////////////////////////////////////////////////////////
   /* greenman AUTO_TEMPLATE (
    .clk (clksrc1_1),
    );*/
   greenman greenman1 (/*AUTOINST*/
		       // Outputs
		       .vert		(vert[7:0]),
		       .hori		(hori[7:0]),
		       // Inputs
		       .clk		(clksrc1_1),		 // Templated
		       .greenmanon	(greenmanon));

   always @(*) begin
      assign greenmanon = (modedata[mode][26] == 1)?1:0;
   end

   /////////////////////////////////////
     // start debounce swith
   ////////////////////////////////////

   /* debounce AUTO_TEMPLATE (
    .noisy (noisy[@]),
    .clean (clean[@]));
    */
   
   debounce d0 (/*AUTOINST*/
		// Outputs
		.clean			(clean[0]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[0]));		 // Templated
   debounce d1 (/*AUTOINST*/
		// Outputs
		.clean			(clean[1]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[1]));		 // Templated
   debounce d2 (/*AUTOINST*/
		// Outputs
		.clean			(clean[2]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[2]));		 // Templated
   debounce d3 (/*AUTOINST*/
		// Outputs
		.clean			(clean[3]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[3]));		 // Templated
   debounce d4 (/*AUTOINST*/
		// Outputs
		.clean			(clean[4]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[4]));		 // Templated
   debounce d5 (/*AUTOINST*/
		// Outputs
		.clean			(clean[5]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[5]));		 // Templated
   debounce d6 (/*AUTOINST*/
		// Outputs
		.clean			(clean[6]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[6]));		 // Templated
   debounce d7 (/*AUTOINST*/
		// Outputs
		.clean			(clean[7]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[7]));		 // Templated
   debounce d8 (/*AUTOINST*/
		// Outputs
		.clean			(clean[8]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[8]));		 // Templated
   debounce d9 (/*AUTOINST*/
		// Outputs
		.clean			(clean[9]),		 // Templated
		// Inputs
		.clks			(clks),
		.noisy			(noisy[9]));		 // Templated
   debounce d10 (/*AUTOINST*/
		 // Outputs
		 .clean			(clean[10]),		 // Templated
		 // Inputs
		 .clks			(clks),
		 .noisy			(noisy[10]));		 // Templated
   debounce d11 (/*AUTOINST*/
		 // Outputs
		 .clean			(clean[11]),		 // Templated
		 // Inputs
		 .clks			(clks),
		 .noisy			(noisy[11]));		 // Templated
   debounce d12 (/*AUTOINST*/
		 // Outputs
		 .clean			(clean[12]),		 // Templated
		 // Inputs
		 .clks			(clks),
		 .noisy			(noisy[12]));		 // Templated
endmodule 

