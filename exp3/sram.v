module sram (/*AUTOARG*/
   // Outputs
   addr_o, ce, oe, we, ub, lb,
   // Inouts
   io, data,
   // Inputs
   addr, read, write, play, record
   );
   output [17:0] addr_o;
   input [17:0]  addr;
   input 	 read;  //read
   input 	 write;  //write
   input 	 play;
   input 	 record;
   
   
   inout [15:0]  io; // to sram
   inout [15:0]  data;
  // reg [15:0] 	 data;
   
   output 	 ce, oe, we, ub, lb;
   reg [15:0] 	 io_buffer;
   reg [15:0] 	 data_buffer;
    //debug


   
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
      addr_o = addr;
   end

   assign io = we?16'hzzzz:io_buffer;
   assign data = record?16'hzzzz:data_buffer;
   
   //read and write
   always @(*) begin
      lb = 0;
      ub = 0;
      if ((read == 1) && (write == 0)) begin //read
	 ce = 0;
	 we = 1;
	 oe = 0;
	 data_buffer = io;
      end else begin
	 if ((write == 1) && (read == 0)) begin //write
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
