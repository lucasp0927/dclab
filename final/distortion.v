module distortion (/*AUTOARG*/
		   // Outputs
		   dataout,
		   // Inputs
		   datain, on, threshold, gain
		   );
   input signed   [15:0] datain;
   input 		 on;
   
   output signed [15:0]  dataout;
   
   input signed [15:0] 	 threshold;
   input signed [15:0] 	 gain;
   reg signed [15:0] 	 dataout;
   
   reg signed [15:0] 	 data_tmp;
   
   always @(*) begin
      if (on == 1) begin
	 /*
	  * distortion
	  */
	 if (datain > threshold ) begin
            data_tmp = threshold;
	 end else begin
            if (datain < ($signed(16'b1111111111111111)*threshold)) begin
      	       data_tmp = $signed(16'b1111111111111111)*threshold;
            end else begin
	       data_tmp = datain;
	    end
	 end
	 dataout = data_tmp * gain;   
      end else begin // if (distortionon == 1)
	 /*
	  * bypass
	  */
	 dataout = datain;
      end
      
   end
endmodule
