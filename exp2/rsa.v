module rsa (/*AUTOARG*/
   // Outputs
   ready, data_o,
   // Inputs
   clk, reset, we, oe, start, reg_sel, addr, data_i
   );
   input clk,reset,we,oe,start;
   input [1:0] reg_sel;
   input [4:0] addr;
   input [7:0] data_i;
   output      ready;
   output [7:0] data_o;
   integer 	addr_num;
   reg [255:0] 	a[3:0]; //a[0] = a[1]^a[2] mod a[3]
   
   always @ (posedge clk)
     begin
	addr_num <= addr;
	if (we == 0) begin
	   a[reg_sel][8*(addr_num+1)-1:(8*addr_num)] = data_i;
	end 
     end
   
endmodule
