module sram (/*AUTOARG*/
   // Outputs
   addr_o, ce, oe, we, ub, lb,
   // Inouts
   io, data,
   // Inputs
   addr_i, r, w
   );
   output [17:0] addr_o;
   input [17:0]  addr_i;
   input 	 r;  //read
   input 	 w;  //write
   
   inout [15:0]  io; // to sram
   inout [15:0]  data;
   wire [15:0] 	 io;
   wire [15:0] 	 data;
   
   output 	 ce, oe, we, ub, lb;
   reg [15:0] 	 io_buffer;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [17:0]		addr_o;
   reg			ce;
   reg			lb;
   reg			oe;
   reg			ub;
   reg			we;
   // End of automatics

   //pass address to sram
   always @(*) begin
      addr_o = addr_i;
   end
   
   //read and write
   always @(*) begin
      assign io = we?16'hzzzz:io_buffer;
      lb = 0;
      ub = 0;
      if ((r == 1) && (w == 0)) begin //read
	 ce = 0;
	 we = 1;
	 oe = 0;
	 data = io;
      end else begin
	 if ((w == 1) && (r == 0)) begin //write
	    ce = 0;
	    we = 0;
	    oe = 1;
	    io_buffer = data;
	 end else begin
	    ce = 1;
	 end
      end
   end
endmodule
