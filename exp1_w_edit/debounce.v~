///////////////////////////////////////////////////////////////////////////////
//
// Pushbutton Debounce Module 
//
///////////////////////////////////////////////////////////////////////////////

module debounce (/*AUTOARG*/
   // Outputs
   clean,
   // Inputs
   clks, noisy
   );
   input  clks, noisy;
   output clean;

   parameter NDELAY = 650000;
   parameter NBITS = 20;

   reg [NBITS-1:0] count;
   reg xnew, clean;

   always @(posedge clk)
     if (!noisy) begin xnew <= noisy; clean <= noisy; count <= 0; end
     else if (noisy != xnew) begin xnew <= noisy; count <= 0; end
     else if (count == NDELAY) clean <= xnew;
     else count <= count+1;

endmodule
