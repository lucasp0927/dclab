module dac (slowmethod, slow, fast, play, bclk, daclrc, dacdat, addr, read ,data, reset);
   input play;	
   input bclk;
   input daclrc;
   input signed [15:0] data;
   input [3:0] 	fast;
   input 	slowmethod;
   input [3:0] 	slow;
   input 	reset;
   
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
   reg [3:0] 	 slowcount;
   reg [15:0] 	 data_tmp;
   reg signed [15:0] data_tmp1;
   reg  signed [15:0] data_tmp2;
   reg signed [15:0]  div;
   
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 	      addr_buffer;
   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   
   always @(posedge bclk) begin
if (reset == 1) begin
   addr_buffer <= 0;
end else begin
      if(play == 0)
	read <= 0;
      else begin
	 read <= 1;
	 

	 if (slow == 1) begin
	    /*
	     * fast or normal
	     */
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
		  addr_buffer <= addr_buffer+fast;
	       end
	    end
	 end else begin
	    /*
	     * slow
	     */
	    if (slowmethod == 0) begin
	       /*
		* zero order
		*/
	       read <= 1;
	       if (daclrc == 0 && counter != 5'd16) begin
		  counter <= counter+1;
		  dacdat <= data[counter];
	       end else
		 dacdat <= 0;
	       if (counter == 5'd16 && daclrc == 1) begin
		  counter <= 0;
		  if (slowcount == (slow-1)) begin
		     addr_buffer <= addr_buffer+1;
		     slowcount <= 0;
		  end else begin
		     slowcount <= slowcount +1;
		  end
	       end
	    end else begin
	       /*
		* first order
		*/
	       read <= 1;
	       if (daclrc == 0 && counter != 5'd16) begin
		  counter <= counter+1;
		  dacdat <= data_tmp[counter];
	       end else
		 dacdat <= 0;
	       
	       if (counter == 5'd16 && daclrc == 1) begin
		  counter <= 0;
		  if (slowcount == (slow-1)) begin
		     addr_buffer <= addr_buffer+1;
		     slowcount <= 0;
		     data_tmp1 <= data_tmp2;
		     data_tmp2 <= data;
		  end else begin
		     slowcount <= slowcount +1;			
		  end
	       end
	    end
	 end
      end   
end

   end // always @ (posedge bclk)
   
   
   always @(*) begin
      div = $signed({1'b0,slowcount})/$signed({1'b0,slow});
      data_tmp =  data_tmp1*(1-div) + data_tmp2*div;
   end
endmodule			
