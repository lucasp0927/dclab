module dac (/*AUTOARG*/
   // Outputs
   dacdat,
   // Inputs
   play, bclk, daclrc, reset, data
   );
   reg read;
   
   input play;	
   input bclk;
   input daclrc;
   input reset;
   //   input inverse;
   input signed [15:0] data;
   output 	       dacdat;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			dacdat;
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 	       addr_buffer;
   reg [4:0] 	       counter;
   
//   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   
   always @(posedge bclk) begin
      if (reset == 1) begin
//	 addr_buffer <= 0;
	 counter <= 16;
      end else begin
	 
	 if(play == 0)
	   read <= 0;
	 else begin
	    read <= 1;
	    if(play == 0)
	      read <= 0;
	    else begin
	       read <= 1;
	       if (daclrc == 0 && counter != 5'd0) begin
		  counter <= counter-1;
		  dacdat <= data[counter-1];
	       end else
		 dacdat <= 0;
	       if (counter == 5'd0 && daclrc == 1) begin
		  counter <= 16;
//		     addr_buffer <= addr_buffer + 1;
	       end
	    end
	 end
      end

   end // always @ (posedge bclk)
   
endmodule			
