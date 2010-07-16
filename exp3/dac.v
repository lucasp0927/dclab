module dac (slowmethod, slow, fast, play, bclk, daclrc, dacdat, addr, read ,data);
   input play;	
   input bclk;
   input daclrc;
   input [15:0] data;
   input [3:0] 	fast;
   input 	slowmethod;
   input [3:0] 	slow;
   output 	read;
   output 	dacdat;
   output [17:0] addr ;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [4:0] 	 counter;
   reg [4:0] 	 counter_addr;
   reg 		 dacdat;
   reg 		 read;
   reg [3:0] 	 counter2;
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 	 addr_buffer;
   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   
   always @(posedge bclk) begin
      if(play == 0)
	read <= 0;
      else begin
	 read <= 1;
	 if (slowmethod == 0) begin
	 	if (daclrc == 0 && counter_addr != 5'd16) begin
		if(counter == 5'd15)
		counter <= 0;
		else
		counter <= counter+1;
	    	dacdat <= data[counter];
	    	if(counter2 == slow-1)begin
			counter2 <= 0;
			counter_addr <= counter_addr+1;
	    	end
		counter2 <= counter2 + 1;
	 end   
	 end else
	   dacdat <= 0;
	 if (counter_addr == 5'd16 && daclrc == 1) begin
	    counter_addr <= 0;
	    counter <=0;
	    addr_buffer <= addr_buffer+fast;
	 end
      end
   end
endmodule			
