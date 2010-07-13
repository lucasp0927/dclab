module dac (dacon, bclk, daclrc, dacdat, addr, read ,data) begin
	input dacon;	
	input bclk;
	input daclrc;
	input [15:0] data;

	output read;
	output dacdat;
	output [17:0] addr ;

	reg [4:0] counter;
	always @(posedge bclk) begin
		if(dacon == 0)
		read <= 0;
		else begin
			read <= 1;
			if (daclrc == 0 && counter != 4'd16) begin
				counter <= counter+1;
				dacdat <= data[counter];
			end else
			dacdat <= 0;
			if (counter == 4'd16) begin
				counter <= 0;
				addr <= addr+1;
			end
		end
	end
			
