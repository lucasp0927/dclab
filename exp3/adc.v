module adc(//input from  Audio CODEC
           bclk,adclrc,adcdat,
           //input from I2C
           record,             
           //output for RAM
           addr,data,write,
           //output for debug
           data_o,write_o,adclrc_o
           );
   input  bclk,adclrc,adcdat,record;
   output [17:0] addr;
   output [15:0] data;
   output write;  
 
//////////////////////////////debug
// output [17:0] addr_o;
   output [15:0] data_o;   
   output write_o,adclrc_o;   
// reg [17:0] 	 addr_o;
   reg [15:0] 	 data_o; 
   reg write_o,adclrc_o;
   
///////////////////////////////debug


   reg [15:0] 	 data_tmp;
   reg [4:0] 	 reg_count;
   //integer address_count;
   reg 		 write;
   //reg one; // ensure that ADC only do noe thing 
   reg [15:0] 	 data_buffer;
   reg [17:0] 	 addr_buffer;
   /*AUTOWIRE*/
   /*AUTOREG*/
   assign data = record?data_buffer:16'bzzzzzzzzzzzzzzzz;
   assign addr = record?addr_buffer:18'bzzzzzzzzzzzzzzzzzz;
//debug
   always @ (*)begin   
// addr_o <= addr;
   data_o = data;
   write_o = write;
   adclrc_o=adclrc;
   end   
   
   always @ (posedge bclk) begin 
      if ( record == 1) begin 
		 if (adclrc==0) begin
		  write <= 0;        
			if(addr_buffer!=2'b111111111111111111) begin
			   
			     data_tmp[reg_count] <= adcdat;
			     reg_count <= reg_count+1;			     

    			 if (reg_count==15) begin
		           reg_count <= 0;
				   addr_buffer <= addr_buffer+1;
				   data_buffer <= data_tmp;
			     end
			end
		 end else begin //adclrc==1
			write <= 1;
			reg_count <= 0 ;
		             
		 end 
      end else begin // record != 1
	   write <= 0;   
      end
   end
endmodule
