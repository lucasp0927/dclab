module dac (slowmethod, slow, fast, play, bclk, daclrc, dacdat, addr, read ,data);
   input play;	
   input bclk;
   input daclrc;
   input [15:0] data;
   input [3:0]fast;

   output 	read;
   output 	dacdat;
   output [17:0] addr ;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [4:0]		counter;
   reg [4:0]		daccounter;
   reg			dacdat;
   reg			read;
   reg [3:0]		counter2
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 		addr_buffer;
   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
     
   always @(posedge bclk) begin
      if(play == 0)
	read <= 0;
      else begin
	 read <= 1;
	 if (slowmethod == 0) begin
	 	if (daclrc == 0 && counter != 5'd16) begin
	    	dacdat <= data[counter];
	    	counter2 <= counter2 + 1;
	    	if(counter2 == slow-1)begin
			counter2 <= 0;
			counter <= counter+1;
	    	end
	 end   
	 end else
	   dacdat <= 0;
	 if (counter == 5'd16 && daclrc == 1) begin
	    counter <= 0;
	    addr_buffer <= addr_buffer+fast;
	 end

	 
      end
   end
endmodule			
