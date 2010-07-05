module io (/*AUTOARG*/
   // Inouts
   a,
   // Inputs
   clk, we, addr, data_i, reg_sel
   );
   input clk;
   input we;
   input [4:0] 	 addr;
   input [7:0] 	 data_i;
   input [1:0] 	 reg_sel;
   inout [255:0] a;
   reg [255:0] 	 a;
   /*AUTOREG*/
   /*AUTOWIRE*/
   always @(posedge clk) begin
      
      case (addr)
	5'd0: a[7:0]<=data_i;
	5'd1: a[2*8-1:1*8]=data_i;
	5'd2: a[3*8-1:2*8]=data_i;
	5'd3: a[4*8-1:3*8]=data_i;
	5'd4: a[5*8-1:4*8]=data_i;
	5'd5: a[6*8-1:5*8]=data_i;
	5'd6: a[7*8-1:6*8]=data_i;
	5'd7: a[8*8-1:7*8]=data_i;
	5'd8: a[9*8-1:8*8]=data_i;
	5'd9: a[10*8-1:9*8]=data_i;
	5'd10: a[11*8-1:10*8]=data_i;
	5'd11: a[12*8-1:11*8]=data_i;
	5'd12: a[13*8-1:12*8]=data_i;
	5'd13: a[14*8-1:13*8]=data_i;
	5'd14: a[15*8-1:14*8]=data_i;
	5'd15: a[16*8-1:15*8]=data_i;
	5'd16: a[17*8-1:16*8]=data_i;
	5'd17: a[18*8-1:17*8]=data_i;
	5'd18: a[19*8-1:18*8]=data_i;
	5'd19: a[20*8-1:19*8]=data_i;
	5'd20: a[21*8-1:20*8]=data_i;
	5'd21: a[22*8-1:21*8]=data_i;
	5'd22: a[23*8-1:22*8]=data_i;
	5'd23: a[24*8-1:23*8]=data_i;
	5'd24: a[25*8-1:24*8]=data_i;
	5'd25: a[26*8-1:25*8]=data_i;
	5'd26: a[27*8-1:26*8]=data_i;
	5'd27: a[28*8-1:27*8]=data_i;
	5'd28: a[29*8-1:28*8]=data_i;
	5'd29: a[30*8-1:29*8]=data_i;
	5'd30: a[31*8-1:30*8]=data_i;
	5'd31: a[32*8-1:31*8]=data_i;
      endcase
      case (addr)
	5'd0: a[7:0]<=data_i;
	5'd1: a[2*8-1:1*8]=data_i;
	5'd2: a[3*8-1:2*8]=data_i;
	5'd3: a[4*8-1:3*8]=data_i;
	5'd4: a[5*8-1:4*8]=data_i;
	5'd5: a[6*8-1:5*8]=data_i;
	5'd6: a[7*8-1:6*8]=data_i;
	5'd7: a[8*8-1:7*8]=data_i;
	5'd8: a[9*8-1:8*8]=data_i;
	5'd9: a[10*8-1:9*8]=data_i;
	5'd10: a[11*8-1:10*8]=data_i;
	5'd11: a[12*8-1:11*8]=data_i;
	5'd12: a[13*8-1:12*8]=data_i;
	5'd13: a[14*8-1:13*8]=data_i;
	5'd14: a[15*8-1:14*8]=data_i;
	5'd15: a[16*8-1:15*8]=data_i;
	5'd16: a[17*8-1:16*8]=data_i;
	5'd17: a[18*8-1:17*8]=data_i;
	5'd18: a[19*8-1:18*8]=data_i;
	5'd19: a[20*8-1:19*8]=data_i;
	5'd20: a[21*8-1:20*8]=data_i;
	5'd21: a[22*8-1:21*8]=data_i;
	5'd22: a[23*8-1:22*8]=data_i;
	5'd23: a[24*8-1:23*8]=data_i;
	5'd24: a[25*8-1:24*8]=data_i;
	5'd25: a[26*8-1:25*8]=data_i;
	5'd26: a[27*8-1:26*8]=data_i;
	5'd27: a[28*8-1:27*8]=data_i;
	5'd28: a[29*8-1:28*8]=data_i;
	5'd29: a[30*8-1:29*8]=data_i;
	5'd30: a[31*8-1:30*8]=data_i;
	5'd31: a[32*8-1:31*8]=data_i;
      endcase
      case (addr)
	5'd0: a[7:0]<=data_i;
	5'd1: a[2*8-1:1*8]=data_i;
	5'd2: a[3*8-1:2*8]=data_i;
	5'd3: a[4*8-1:3*8]=data_i;
	5'd4: a[5*8-1:4*8]=data_i;
	5'd5: a[6*8-1:5*8]=data_i;
	5'd6: a[7*8-1:6*8]=data_i;
	5'd7: a[8*8-1:7*8]=data_i;
	5'd8: a[9*8-1:8*8]=data_i;
	5'd9: a[10*8-1:9*8]=data_i;
	5'd10: a[11*8-1:10*8]=data_i;
	5'd11: a[12*8-1:11*8]=data_i;
	5'd12: a[13*8-1:12*8]=data_i;
	5'd13: a[14*8-1:13*8]=data_i;
	5'd14: a[15*8-1:14*8]=data_i;
	5'd15: a[16*8-1:15*8]=data_i;
	5'd16: a[17*8-1:16*8]=data_i;
	5'd17: a[18*8-1:17*8]=data_i;
	5'd18: a[19*8-1:18*8]=data_i;
	5'd19: a[20*8-1:19*8]=data_i;
	5'd20: a[21*8-1:20*8]=data_i;
	5'd21: a[22*8-1:21*8]=data_i;
	5'd22: a[23*8-1:22*8]=data_i;
	5'd23: a[24*8-1:23*8]=data_i;
	5'd24: a[25*8-1:24*8]=data_i;
	5'd25: a[26*8-1:25*8]=data_i;
	5'd26: a[27*8-1:26*8]=data_i;
	5'd27: a[28*8-1:27*8]=data_i;
	5'd28: a[29*8-1:28*8]=data_i;
	5'd29: a[30*8-1:29*8]=data_i;
	5'd30: a[31*8-1:30*8]=data_i;
	5'd31: a[32*8-1:31*8]=data_i;
      endcase
      
   end


endmodule
