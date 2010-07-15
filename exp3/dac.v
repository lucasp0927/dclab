module dac (play, bclk, daclrc, dacdat, addr, read ,data, read_o,daccounter);
   input play;	
   input bclk;
   input daclrc;
   input [15:0] data;

   output 	read;
   output 	dacdat;
   output [17:0] addr ;
   output 	 read_o;
   output [4:0]  daccounter;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [4:0]		counter;
   reg [4:0]		daccounter;
   reg			dacdat;
   reg			read;
   reg			read_o;
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 		addr_buffer;
   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   always@ (*)begin
      read_o = read;
      daccounter = counter;
   end
     
   always @(posedge bclk) begin
      if(play == 0)
	read <= 0;
      else begin
	 read <= 1;

	 if (daclrc == 0 && counter != 5'd16) begin
	    counter <= counter+1;
	    dacdat <= data[counter];
	 end else
	   dacdat <= 0;
	 if (counter == 5'd16 && daclrc == 1) begin
	    counter <= 0;
	    addr_buffer <= addr_buffer+1;
	 end

//	 addr_buffer = 1;
	 
      end
   end
endmodule			
