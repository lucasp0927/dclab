module effect (/*AUTOARG*/
   // Outputs
   i2c_clk, i2c_dat, dacdat, clk,
   // Inputs
   clkfast, clkfast2, reset_dirty, bclk, adclrc, adcdat, daclrc,
   distortionon, choruson, vibratoon
   );

   output i2c_clk, i2c_dat;
   input  clkfast,clkfast2; //50M input
   input  reset_dirty;
   input  bclk, adclrc, adcdat, daclrc;

   //padel switch
   input  distortionon, choruson, vibratoon;
   
   output dacdat;
   
   output clk;
   
   
   //reg 	  clk; //12M
   wire 	  reset; //after debounce
   reg [15:0] data;
   wire       clk;
   reg 	      play, record;
   wire [15:0] datain, dataout;
   wire [15:0]  datacpuout;
   wire        dacdat;
   
//   reg 	       cpu_clk;
   
   /*AUTOREG*/
   /*AUTOWIRE*/
   always @(*) begin
      record = 1;
      play = 1;
   end

   
   clk12m clk12m1 ( , clkfast,clk, );
   
   i2c i2c1(/*autoinst*/
	    // Outputs
	    .i2c_clk			(i2c_clk),
	    .i2c_dat			(i2c_dat),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset));
   
   adc adc1 (
	     // Outputs
	     .data			(datain[15:0]),
	     // Inputs
	     .bclk			(bclk),
	     .adclrc			(adclrc),
	     .adcdat			(adcdat),
	     .record			(record),
	     .reset			(reset));
   
   dac dac1 (
	     // Outputs
	     .dacdat			(dacdat),
	     // Inputs
	     .play			(play),
	     .bclk			(bclk),
	     .daclrc			(daclrc),
	     .reset			(reset),
	     .data			(dataout[15:0]));
   distortion distortion1 (
			   // Outputs
			   .dataout		(dataout[15:0]),
			   // Inputs
			   .datain		(datacpuout[15:0]),
			   .threshold		($signed(500)),
			   .on                  (distortionon),
			   .gain		($signed(20)));

   cpueffect cpueffect1 (
			 // Outputs
			 .cpu_clk		(cpu_clk),
			 .out_port_from_the_dataout(datacpuout[15:0]),
			 // Inputs
			 .clk_50		(clkfast2),
			 .in_port_to_the_adclrc	(adclrc),
			 .in_port_to_the_chorus_on(choruson),
			 .in_port_to_the_clk	(clk),
			 .in_port_to_the_datain	(datain[15:0]),
			 .in_port_to_the_vibrato_on(vibratoon),
			 .reset_n		(reset));
   
   //debounces
   debounce debounce0 (
		       // Outputs
		       .clean		(reset),
		       // Inputs
		       .clks		(clk),
		       .noisy		(reset_dirty));
   
endmodule
