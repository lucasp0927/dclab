module greenman ( clk, vert, hori, /*AUTOARG*/
		  // Inputs
		  greenmanon
		  );
   //input mode;
   input clk;
   input greenmanon;
   
   output [7:0] vert;
   output [7:0] hori;
   
   reg [7:0] 	vert;
   reg [7:0] 	hori;
   reg [2:0] 	counter;
   reg [24:0] 	clks;
   reg 		mode;
   
   always @ (posedge clk) begin
      clks <= clks + 1'b1;
   end

   always @(posedge clks[24]) begin
      mode <= !mode;
   end
   
   always @ (posedge clks[14]) begin
      counter <= counter + 1'b1;
   end

   always @ (*) begin
      if ((greenmanon == 0) || (mode == 0)) begin
	 case(counter)
	   3'd0: 
	     begin hori = 8'b00000000; vert = 8'b01111111; end
	   3'd1: 
	     begin hori = 8'b00011001; vert = 8'b10111111; end
	   3'd2: 
	     begin hori = 8'b00110011; vert = 8'b11011111; end
	   3'd3: 
	     begin hori = 8'b11111100; vert = 8'b11101111; end
	   3'd4: 
	     begin hori = 8'b11111100; vert = 8'b11110111; end
	   3'd5: 
	     begin hori = 8'b00110011; vert = 8'b11111011; end
	   3'd6: 
	     begin hori = 8'b00011001; vert = 8'b11111101; end
	   3'd7: 
	     begin hori = 8'b00000000; vert = 8'b11111110; end
	   default: begin hori = 8'b00000000; vert = 8'b00000000; end
	 endcase // case (counter)
      end
      else  begin
	 case(counter)
	   3'd0: 
	     begin hori = 8'b00010000; vert = 8'b01111111; end
	   3'd1: 
	     begin hori = 8'b00011001; vert = 8'b10111111; end
	   3'd2: 
	     begin hori = 8'b00110011; vert = 8'b11011111; end
	   3'd3: 
	     begin hori = 8'b11111100; vert = 8'b11101111; end
	   3'd4: 
	     begin hori = 8'b11111100; vert = 8'b11110111; end
	   3'd5: 
	     begin hori = 8'b00110011; vert = 8'b11111011; end
	   3'd6: 
	     begin hori = 8'b00011001; vert = 8'b11111101; end
	   3'd7: 
	     begin hori = 8'b00000000; vert = 8'b11111110; end
	   default: begin hori = 8'b00000000; vert = 8'b00000000; end
	 endcase
      end
   end

   /*
    3'd0: 
    begin hori = 8'b01111111; vert = 8'b00000000; end
    3'd1: 
    begin hori = 8'b10111111; vert = 8'b00011001; end
    3'd2: 
    begin hori = 8'b11011111; vert = 8'b00110011; end
    3'd3: 
    begin hori = 8'b11101111; vert = 8'b11111111; end
    3'd4: 
    begin hori = 8'b11110111; vert = 8'b11111111; end
    3'd5: 
    begin hori = 8'b11111011; vert = 8'b00110011; end
    3'd6: 
    begin hori = 8'b11111101; vert = 8'b00011001; end
    3'd7: 
    begin hori = 8'b11111110; vert = 8'b00000000; end
    */



endmodule
