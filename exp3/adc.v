module adc(//input from  Audio CODEC
           bclk,adclrc,adcdat,
           //input from I2C
           record,             
           //output for RAM
           addr,data,write,
           //output for debug
           data_o,write_o,adclrc_o,reg_count_o
           );
   input  bclk,adclrc,adcdat,record;
   output [17:0] addr;
   output [15:0] data;
   output write;  
 
//////////////////////////////debug
// output [17:0] addr_o;
   output [15:0] data_o;   
   output write_o,adclrc_o;
   output reg_count_o;   
// reg [17:0] 	 addr_o;
   reg [15:0] 	 data_o; 
   reg write_o,adclrc_o;
   reg [4:0] reg_count_o;
///////////////////////////////debug

   reg one;
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
      reg_count_o = reg_count;
   end   
   
   always @ (posedge bclk) begin 
      if ( record == 1 && addr_buffer!=2'b111111111111111111) begin 
	 if (adclrc==0 && one==0) begin
	    if(reg_count!=16)  
	      data_tmp[reg_count] <= adcdat;
	    reg_count <= reg_count+1;			    
         end
	 if(reg_count==16) begin
	    reg_count <= 0;
	    data_buffer <= data_tmp;
	    one <= 1;
	 end
      end else begin //adclrc==1
	 if( adclrc==1 && one==1 )begin
	    addr_buffer <= addr_buffer+1;
	    reg_count <= 0 ;
	    one <= 0;         
	 end
      end 
   end

endmodule
