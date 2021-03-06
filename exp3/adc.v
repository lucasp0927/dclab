module adc(//input from  Audio CODEC
           bclk,adclrc,adcdat,
           //input from I2C
           record,
           //output for RAM
           addr,data,write,reset
           );

   input  bclk,adclrc,adcdat,record;
   input  reset;
   
   output [17:0] addr;
   output [15:0] data;
   output 	 write; 
   reg [1:0] 	 adclrc_tmp;
   reg [1:0] 	 reset_tmp;
   
   reg 		 one;
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

   always @ (*) begin
      if (record == 1) begin
	 write = adclrc;
      end else begin
	 write = 0;
      end
   end
   
   always @ (posedge bclk) begin
      if (reset == 1) begin
	 addr_buffer <= 0;
      end
      if (record == 1) begin
	 if ((adclrc_tmp == 2'b10) || (reg_count != 0)) begin
	    data_tmp[reg_count] <= adcdat;
	    if (reg_count == 15) begin
	       reg_count <= 0;
	    end else begin
	       reg_count <= reg_count +1 ;
	    end
	 end
	 if (adclrc_tmp == 2'b01) begin
	    data_buffer <= data_tmp;
	    addr_buffer <= addr_buffer +1;
	 end 
      end // if (record == 1)
      adclrc_tmp[1] <= adclrc_tmp[0];
      adclrc_tmp[0] <= adclrc;
      reset_tmp[1] <= reset_tmp[0];
      reset_tmp[0] <= reset;
   end // always @ (posedge bclk)

endmodule

