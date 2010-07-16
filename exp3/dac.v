module dac (stop, slowmethod, slow, fast, play, bclk, daclrc, dacdat, addr, read ,data);
   input play;	
   input bclk;
   input daclrc;
   input [15:0] data;
   input [3:0] slow,fast;
   input slowmethod;
   input stop;

   output 	read;
   output 	dacdat;
   output [17:0] addr ;

   reg [3:0]     finish,finish2;
   reg [15:0]    now;
   reg [4:0] 	 counter;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			dacdat;
   reg			read;
   reg [3:0]		finish;
   // End of automatics
   /*AUTOWIRE*/
   reg [17:0] 		addr_buffer;
   assign addr = play?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   
   always @(negedge bclk) begin
      if (stop == 1) begin
         read <= 0;
	 finish <= 0;
	 counter <= 0;
	 addr_buffer <= 0;
///////////////////////////////////
      end else begin
         if(play == 0)
	   read <= 0;
////////////////////////////////////
         else begin
	    read <= 1;
	    if (daclrc == 0 && counter != 5'd16) begin
	       if (slowmethod == 0)begin
                  if (finish < slow-1) begin
	       	     if (counter == 5'd15) begin
		        counter <= counter+1 ;    
		        dacdat <= data[counter];
			finish <= finish + 1;
			addr_buffer <= addr_buffer-1;
		     end else begin
	    	        counter <= counter+1;
	    	        dacdat <= data[counter];
	   	     end
	          end else begin
		     counter <= counter+1;
	    	     dacdat <= data[counter];
	          end

////////////////////////////////////////
	       end else begin
                  if (finish2 < slow-1) begin
		     if (finish2 == 0 )
	       	        if (counter == 5'd15) begin
		           counter <= counter+1 ;    
		           dacdat <= data[counter];
			   finish2 <= finish2 + 1;
			   now <= data;
		        end else begin
	    	           counter <= counter+1;
	    	           dacdat <= data[counter];
	   	        end
		     end

		     if (finish2 != 0)
	       	        if (counter == 5'd15) begin
		           counter <= counter+1 ;    
		           dacdat <= (((slow-finish2)*now-finish2*data)/slow)[counter];
			   finish2 <= finish2 + 1;
			   addr_buffer <= addr_buffer-1;
		        end else begin
	    	           counter <= counter+1;
	    	           dacdat <= (((slow-finish2)*now-finish2*data)/slow)[counter];
	   	        end
		     end



	          end else begin
		     counter <= counter+1;
	    	     dacdat <= (((slow-finish2)*now-finish2*data)/slow)[counter];
		     addr_buffer <=addr_buffer + 1;
	          end



/////////////////////////
	    end else begin
	        dacdat <= 0;
	    end
	  
////////////////////////////////
	    if (counter == 5'd16 && daclrc == 1) begin
	       if (finish == slow-1)
	       finish <= 0;
	       if (finish2 == slow-1)
	       finish2<=0;
	       counter <= 0;
	       addr_buffer <= addr_buffer+fast;
	    end
         end
      end
   end	 
endmodule			
