module rsa (clk,a,b,c);
   input clk;
   input [3:0] a,b;
   output [3:0] c;
   reg [3:0] 	c;

   always @ (posedge clk)begin
      c = a;	
   end
endmodule
