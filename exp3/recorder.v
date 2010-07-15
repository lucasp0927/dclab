module recorder (/*AUTOARG*/
   // Outputs
   addr_o, ce, oe, we, ub, lb, dacdat, i2c_clk, i2c_dat, write_o,record_o,adclrc_o,bclk_o,clk,adcdat_o,play_o,daclrc_o,read_o,io_o,we_o, ce_o, oe_o, addr_out, daccounter,
   // Inouts
   io,
   // Inputs
   play_dirty, record_dirty, reset_dirty, clkfast, bclk, adclrc,
   adcdat, daclrc
   );

   output [17:0] 	 addr_out;   
   input play_dirty, record_dirty, reset_dirty;
   input clkfast;
   //io of sram
   output [17:0] addr_o;
   output 	 ce, oe, we, ub, lb, clk;
   inout [15:0]  io;
   // io  of adc
   input 	 bclk, adclrc, adcdat;
   // io of dac	 
   output 	 dacdat;
   input 	 daclrc;
   // io of i2c
   output 	 i2c_clk;
   output 	 i2c_dat;

   //debug
   output write_o;
   output [4:0]  daccounter;
   output record_o;
   output play_o;
   output adclrc_o,bclk_o;
   output adcdat_o;
   output daclrc_o;
   output read_o;
   output [15:0] io_o;
   output 	 oe_o, we_o, ce_o;
   reg 	 oe_o, we_o, ce_o;
   reg [15:0] 	 io_o;
   reg 	  adcdat_o;
   reg record_o;
   reg play_o;
   reg [17:0] addr_out;
   reg [17:0] 	 addr;
   reg [4:0] daccounter;
   reg adclrc_o;
   reg bclk_o;
   reg daclrc_o;
   reg 	 play, record, reset;
   wire  clk;

   //debug
   always @ (*) begin
      record_o = record;
      play_o = play;
      bclk_o = bclk;
      adcdat_o = adcdat;
      daclrc_o = daclrc;
      io_o = io;
      oe_o = oe;
      we_o =we;
      ce_o = ce;
      addr_out = addr_o;
   end
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]		data;			// From adc1 of adc.v
   wire			read;			// From dac1 of dac.v
   wire			write;			// From adc1 of adc.v
   // End of automatics
   /*AUTOREG*/

   /*
    * phase lock loop, change 50Mhz to 12Mhz
    */
   pll pll1 ( , clkfast,clk, );

   /*
    * i2c protocol
    */
   i2c i2c1 (/*AUTOINST*/
	     // Outputs
	     .i2c_clk			(i2c_clk),
	     .i2c_dat			(i2c_dat),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset));
   
   sram sram1 (/*AUTOINST*/
	       // Outputs
	       .addr_o			(addr_o[17:0]),
	       .ce			(ce),
	       .oe			(oe),
	       .we			(we),
	       .ub			(ub),
	       .lb			(lb),
	       // Inouts
	       .io			(io[15:0]),
	       .data			(data[15:0]),
	       // Inputs
	       .addr			(addr[17:0]),
	       .read			(read),
	       .write			(write),
	       .play			(play),
	       .record			(record));
   
   adc adc1 (/*AUTOINST*/
	     // Outputs
	     .addr			(addr[17:0]),
	     .data			(data[15:0]),
	     .write			(write),
	     .write_o			(write_o),
         .adclrc_o          (adclrc_o),
	     // Inputs
	     .bclk			(bclk),
	     .adclrc			(adclrc),
	     .adcdat			(adcdat),
	     .record			(record));
   
   dac dac1 (/*AUTOINST*/
	     // Outputs
	     .read			(read),
	     .dacdat			(dacdat),
	     .addr			(addr[17:0]),
	     .read_o (read_o),
	     .daccounter (daccounter),
	     // Inputs
	     .play			(play),
	     .bclk			(bclk),
	     .daclrc			(daclrc),
	     .data			(data[15:0]));
   
   debounce debounce1 (
		       // Outputs
		       .clean		(reset),
		       // Inputs
		       .clks		(clk),
		       .noisy		(reset_dirty));
   debounce debounce2 (
		       // Outputs
		       .clean		(play),
		       // Inputs
		       .clks		(clk),
		       .noisy		(play_dirty));
   debounce debounce3 (
		       // Outputs
		       .clean		(record),
		       // Inputs
		       .clks		(clk),
		       .noisy		(record_dirty));
endmodule
