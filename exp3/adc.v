module adc(/*AUTOARG*/
   // Outputs
   addr, data, write, data_o, write_o,
   // Inputs
   bclk, adclrc, adcdat, record
   );
   input  bclk,adclrc,adcdat,record;
   output [17:0] addr;
   output [15:0] data;
   output 	 write;     

   //reg [17:0] 	 addr;
//   reg [15:0] 	 data; 
   reg [15:0] 	 data_tmp;
   reg [4:0] 	 reg_count;
   //integer address_count;
   reg 		 write;
   //reg one; // ensure that ADC only do noe thing 
   reg [15:0] 	 data_buffer;
   reg [17:0] 	 addr_buffer;

   /*
    * debug
    */
   output [15:0] data_o;
   output 	 write_o;
   always @(*) begin
      data_o = data;
      write_o = write;
   end

   
   /*AUTOWIRE*/
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [15:0]		data_o;
   reg			write_o;
   // End of automatics
   assign data = record?data_buffer:16'bzzzzzzzzzzzzzzzz;
   assign addr = record?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
   
   always @ (posedge bclk) begin 
      if ( record==1) begin 
	 if (adclrc==0) begin       
	    if(addr_buffer!=2'b111111111111111111) begin
	       
	       if( reg_count != 16 ) begin
		  
		  data_tmp[reg_count] <= adcdat;
		  reg_count <= reg_count+1;
		  if (reg_count==15) begin
		     addr_buffer <= addr_buffer+1;
		     //data_buffer <= data_tmp;
		     if (reg_count % 2 == 1 ) begin
			data_buffer <= 2'b1111111111111111;
		     end else begin
			data_buffer <= 2'b0000000000000000;
		     end

		  end
		   
	       end
	    end
	 end else begin //adclrc==1
	    write <= 1;
	    reg_count <= 0 ;
	    if(write==1) write<=0;             
	 end 
      end else begin
	 write <= 0;   
      end
   end
endmodule
