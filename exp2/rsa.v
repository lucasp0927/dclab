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

   task io;
      input [4:0] addr;
      input [7:0] data_i;
      output [255:0]
      begin
	 
   case (addr)
     5'd0: a[1*8-1:0*8]=data_i;
     5'd1: a[:]=data_i;
     5'd2: a[3*8-1:2*8]=data_i;
     5'd3:;
     5'd4: a[5*8-1:4*8]=data_i;
     5'd5:;
     5'd6: a[7*8-1:6*8]=data_i;
     5'd7:;
     5'd8: a[9*8-1:8*8]=data_i;
     5'd9:;
     5'd10: a[11*8-1:10*8]=data_i;
     5'd11:;
     5'd12: a[13*8-1:12*8]=data_i;
     5'd13:;
     5'd14: a[15*8-1:14*8]=data_i;
     5'd15:;
     5'd16: a[17*8-1:16*8]=data_i;
     5'd17:;
     5'd18: a[19*8-1:18*8]=data_i;
     5'd19:;
     5'd20: a[21*8-1:20*8]=data_i;
     5'd21:;
     5'd22: a[23*8-1:22*8]=data_i;
     5'd23:;
     5'd24: a[25*8-1:24*8]=data_i;
     5'd25:;
     5'd26: a[27*8-1:26*8]=data_i;
     5'd27:;
     5'd28: a[29*8-1:28*8]=data_i;
     5'd29:;
     5'd30: a[31*8-1:30*8]=data_i;
     5'd31:;
   endcase
      end
   endtask // convert
   
endmodule

