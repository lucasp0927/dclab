module recorder (/*AUTOARG*/
   // Outputs
   addr_o, ce, oe, we, ub, lb, dacdat, i2c_clk, i2c_dat,clk,
   // Inouts
   io,
   // Inputs
   play_dirty, record_dirty, reset_dirty, clkfast, bclk, adclrc,
   adcdat, daclrc
   );

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
   reg [17:0] 	 addr;
   reg 	 play, record, reset;
   wire  clk;

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
