module recorder (/*AUTOARG*/
   // Inputs
   record_button, play_button
   );
   input record_button, play_button;

 /*AUTOWIRE*/
 /*AUTOREG*/   

    reg [17:0]		addr_o;			// From sram1 of sram.v
       reg [17:0]		addr_i;			// From sram1 of sram.v
 reg			ce;			// From sram1 of sram.v
 reg [15:0]		data;			// To/From sram1 of sram.v
 reg [15:0]		io;			// To/From sram1 of sram.v
 reg			lb;			// From sram1 of sram.v
 reg			oe;			// From sram1 of sram.v
 reg			ub;			// From sram1 of sram.v
 reg			we;			// From sram1 of sram.v

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
	       .addr_i			(addr_i[17:0]),
	       .r			(r),
	       .w			(w));
   
endmodule
