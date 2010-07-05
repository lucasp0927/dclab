module plusminus_oneshot (/*AUTOARG*/
   // Outputs
   plus, minus, reset,
   // Inputs
   clk, plus_button, minus_button, reset_button
   );
   input clk;
   input plus_button;
   input minus_button;
   input reset_button;
   
   output plus;
   output minus;
   output reset;
   
   reg    a_plus;
   reg 	  a_minus;
   reg 	  a_reset;
   
   reg [1:0] b_plus;
   reg [1:0] b_minus;
   reg [1:0] b_reset;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			minus;
   reg			plus;
   reg			reset;
   // End of automatics
   /*AUTOWIRE*/
   
   initial
     begin
	plus = 1'b0;
	minus = 1'b0;
	reset = 1'b0;
     end

   always @(posedge clk) begin
      case (b_plus)
	2'b00:
	  if(a_plus == 1'b1)
	    b_plus <= 2'b01;
	2'b01:
	  begin
	     b_plus <= 2'b10;
	     plus <= plus + 1'b1 ;
	  end
	2'b10:
	  if(a_plus == 1'b0)
	    b_plus <= 2'b11;
	2'b11:
	  b_plus <= 2'b00;
	default:
	  b_plus <= 2'b00;
      endcase // case (b)
   end // always @ (posedge clk)
   
   always @(posedge clk) begin
      case (b_minus)
	2'b00:
	  if(a_minus == 1'b1)
	    b_minus <= 2'b01;
	2'b01:
	  begin
	     b_minus <= 2'b10;
	     minus <= minus + 1'b1 ;
	  end
	2'b10:
	  if(a_minus == 1'b0)
	    b_minus <= 2'b11;
	2'b11:
	  b_minus <= 2'b00;
	default:
	  b_minus <= 2'b00;
      endcase // case (b)
   end // always @ (posedge clk)

   always @(posedge clk) begin
      case (b_reset)
	2'b00:
	  if(a_reset == 1'b1)
	    b_reset <= 2'b01;
	2'b01:
	  begin
	     b_reset <= 2'b10;
	     reset <= reset + 1'b1 ;
	  end
	2'b10:
	  if(a_reset == 1'b0)
	    b_reset <= 2'b11;
	2'b11:
	  b_reset <= 2'b00;
	default:
	  b_reset <= 2'b00;
      endcase // case (b)
   end // always @ (posedge clk)

   always @(*) begin
      a_plus = !plus_button;
      a_minus = !minus_button;
            a_reset = !reset_button;
   end
   
endmodule
