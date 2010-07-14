module dac (play, bclk, daclrc, dacdat, addr, read ,data);
   input play;	
   input bclk;
   input daclrc;
   input [15:0] data;

   output 	read;
   output 	dacdat;
   output [17:0] addr ;

   reg [4:0] 	 counter;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			dacdat;
   reg			read;
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 		addr_buffer;
   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   
   always @(posedge bclk) begin
      if(play == 0)
	read <= 0;
      else begin
	 read <= 1;
	 if (daclrc == 0 && counter != 4'd16) begin
	    counter <= counter+1;
	    dacdat <= data[counter];
	 end else
	   dacdat <= 0;
	 if (counter == 4'd16) begin
	    counter <= 0;
	    addr_buffer <= addr_buffer+1;
	 end
      end
   end
endmodule			
