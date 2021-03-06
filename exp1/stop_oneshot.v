module stop_oneshot (/*AUTOARG*/
   // Outputs
   stop,
   // Inputs
   clk, stop_button
   );
   input clk;
   input stop_button;
   output stop;
   reg 	  a;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			stop;
   // End of automatics
   /*AUTOWIRE*/
   reg [1:0] 	b;

   initial
     begin
	stop = 1'b0;
     end
   always @(posedge clk) begin
      case (b)
	2'b00:
	  if(a == 1'b1)
	    b <= 2'b01;
	2'b01:
	  begin
	     b <= 2'b10;
	     stop <= stop + 1'b1 ;
	  end
	2'b10:
	  if(a == 1'b0)
	    b <= 2'b11;
	2'b11:
	  b <= 2'b00;
	default:
	  b <= 2'b00;
      endcase // case (b)
   end
   always @(*) begin
      a = !stop_button;
   end

   
endmodule
