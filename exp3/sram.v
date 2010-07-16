module sram (/*AUTOARG*/
	     // Outputs
	     addr_o, ce, oe, we, ub, lb,
	     // Inouts
	     io, data,
	     // Inputs
	     addr, read, write, play, record, reset, clk
	     );
   output [17:0] addr_o;
   input [17:0]  addr;
   input 	 read;  //read
   input 	 write;  //write
   input 	 play;
   input 	 record;
   input         reset;
   input 	 clk;
   
   inout [15:0]  io; // to sram
   inout [15:0]  data;
   // reg [15:0] 	 data;
   reg [15:0] 	 io;
   
   output 	 ce, oe, we, ub, lb;
   
   reg [15:0] 	 io_buffer;
   reg [15:0] 	 data_buffer;
   reg [15:0] 	 io_reset;

   reg [1:0] 	 reset_tmp;
   reg [17:0] 	 reset_counter;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   //   reg [17:0]		addr_o;
   reg 		 ce;
   reg 		 lb;
   reg 		 oe;
   reg 		 ub;
   reg 		 we;
   // End of automatics
/*
   always @ (posedge clk) begin
      if ((reset_tmp == 2'b01) || reset_counter != 0) begin
	 if (reset_counter == 18'b111111111111111111) begin
	    reset_counter <= 0;
	 end
	 else begin
	    reset_counter <= reset_counter + 1;
	 end
	 io_reset <= 16'h0000;
      end
      reset_tmp[1]  <= reset_tmp[0];
      reset_tmp[0] <= reset;   
   end
*/
   //pass address to sram
   //   always @(*) begin
   //      addr_o = addr;
   //   end

   always @ (*) begin
//      if (reset == 1) begin
//	 io = io_reset;
//      end else begin
	 if (write == 1) begin
	    io = io_buffer;
	 end else begin
	    io = 16'hzzzz;
	 end
  //    end
   end // always @ (*)
   
   assign data = record?16'hzzzz:data_buffer;
   assign addr_o = reset?reset_counter:addr;

   //read and write
   always @(*) begin
      lb = 0;
      ub = 0;
      if (reset == 1) begin
	 ce = 0;
	 we = 0;
	 oe = 1;
      end
      else begin
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
	 end // else: !if((read == 1) && (write == 0))
      end // else: !if(we == 0)
   end // if (reset == 1)

endmodule
