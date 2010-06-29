module minus_oneshot ( clk, minus_button, b );
input clk;
input minus_button;
output [1:0] b;
reg [1:0] b;
always @ (posedge clk) begin
case(b)
2'b00:
if(a == 1'b1)
b <= 2'b01;
2'b01:
b <= 2'b10;
2'b10:
if(a == 1'b0)
b <= 2'b11;
2'b11:
b <= 2'b00;
default:
b <= 2'b00;
endcase
end
endmodule