module rsa (/*AUTOARG*/
	    // Outputs
	    ready, data_o, sig, ready_o, we_o, i_o, k_o, m_o, n_o,
	    // Inputs
	    clk, reset, we, oe, start, reg_sel, addr, data_i
	    );
   input clk,reset,we,oe,start;
   input [1:0] reg_sel;
   input [4:0] addr;
   input [7:0] data_i;
   output      ready;
   output [7:0] data_o;
   output 	sig;
   output 	ready_o;
   output       we_o;
   output [7:0] i_o,k_o,m_o,n_o;
   
   integer 	addr_num;
   integer 	debug;
   
   reg [255:0] 	a[3:0]; //a[0] = a[1]^a[2] mod a[3]
   reg [255:0] 	t_now,t,temp,U;
   
   reg [255:0] 	c;
   reg [255:0] 	c_temp;

   reg [7:0] 	data_o;
   reg 		ready,ready_tmp;
   reg 		sig;
   reg [1:0] 	start_tmp;
   reg [8:0] 	k,n,m;
   integer 	k_max,n_max;
   reg [9:0] 	i;
   reg 		c_ready,t_ready;
   reg [1:0] 		reset_tmp;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [7:0] 	i_o;
   reg [7:0] 	k_o;
   reg [7:0] 	m_o;
   reg [7:0] 	n_o;
   reg 		ready_o;
   reg 		we_o;
   // End of automatics
   /*AUTOWIRE*/


   always @(*) begin //test
      sig = oe;
      ready_o = ready;
      we_o = we;
      i_o [7:0] = i [7:0];		  
      k_o [7:0] = k [7:0];
      m_o [7:0] = i [7:0];
      n_o [7:0] = n [7:0];
   end

   always @(*) begin
      k_max = 255;
      n_max = 225;
   end


   ////////////////////////////////////////////////////////////////////////////////////////////////////
   // rsa
   ////////////////////////////////////////////////////////////////////////////////////////////////////

   always @(posedge clk) begin
      if (reset_tmp == 2'b01) begin
	 c<=1;
	 a[0]<=1;
	 i<=0;
	 k<=0;
	 n<=0;
	 m<=0;
	 //U<=1;
	 c_ready <= 0;
	 t_ready <= 0;
	 debug <=0;
	 
      end else begin
	 if (start == 0 || i!=0) begin
	    c[255:0] <= c[255:0] << 1;
	    if(c[255:0] >= a[3][255:0])
	      c<=c-a[3];	      
	    i <= i+1;
	    if(i == 512)
	      begin
		 i<=0;
		 c_ready <= 1;
		 //U<=1;
	      end
	 end else begin
	    if (c_ready == 1 || m != 0) begin
	       //T=MA(C,M)
	       if (m==0)
		 t_now <= 0;
	       temp <= t_now + c[m]*a[1];
	       t_now <= (temp+temp[0]*a[3])>>1;
	       m<=m+1;

	       if (m == 255) begin
		  t <= t_now;
		  m <= 0;
		  c_ready <= 0;
		  t_ready <= 1;
	       end
	    end else begin
	       //tamp Si+ai*B
	       //t_now s
	       if (t_ready == 1 || k!=0 || n!=0) begin
		  if (a[2][k] == 1) begin
		     //a[0] <= MA(a[0],T);
		     if (n == 0)
		       U<=0;
		     temp <= U+a[0][n]*t;
		     U <= (temp+temp[0]*a[3])>>1;
		  end
		  //T<= MA(T,T)
		  if (n==0)
		    t_now <= 0;
		  temp <= t_now+t[n]*t;
		  t_now <= (temp+temp[0]*a[3])>>1;
		  
		  n<=n+1;
		  if (n == n_max) begin
		     a[0]<=U;
		     t <= t_now;
		     k <= k+1;
		     n <= 0;
		  end
		  if(k == k_max)
		    begin
		       k<=0;
		       n <= 0;
		       t_ready <= 0;
		    end
	       end // if (start == 0 || k!=0)
	    end
	 end // else: !if(start == 0 || i!=0)
      end // else: !if(reset_tmp == 2'b01)
      	 reset_tmp[1]<=reset_tmp[0];
	 reset_tmp[0] <= reset;
   end  

   always @(*)begin
      if(i != 0 || k!=0 || n!=0 || m !=0 ||c_ready == 1|| t_ready == 1 )
	ready=1;
      else
        ready=0;
   end

   ////////////////////////////////////////////////////////////////////////////////////////////////////
   //    io
   ////////////////////////////////////////////////////////////////////////////////////////////////////

   
   always @(posedge clk) begin
      if ((we==0) || (oe==0)) begin
	 case (reg_sel)
	   2'd3:
	     begin
		case (addr)
	 	  5'd0: a[3][7:0]<=data_i;
		  5'd1: a[3][15:8]<=data_i;
		  5'd2: a[3][23:16]<=data_i;
		  5'd3: a[3][31:24]<=data_i;
		  5'd4: a[3][39:32]<=data_i;
		  5'd5: a[3][47:40]<=data_i;
		  5'd6: a[3][55:48]<=data_i;
		  5'd7: a[3][63:56]<=data_i;
		  5'd8: a[3][71:64]<=data_i;
		  5'd9: a[3][79:72]<=data_i;
		  5'd10: a[3][87:80]<=data_i;
		  5'd11: a[3][95:88]<=data_i;
		  5'd12: a[3][103:96]<=data_i;
		  5'd13: a[3][111:104]<=data_i;
		  5'd14: a[3][119:112]<=data_i;
		  5'd15: a[3][127:120]<=data_i;
		  5'd16: a[3][135:128]<=data_i;
		  5'd17: a[3][143:136]<=data_i;
		  5'd18: a[3][151:144]<=data_i;
		  5'd19: a[3][159:152]<=data_i;
		  5'd20: a[3][167:160]<=data_i;
		  5'd21: a[3][175:168]<=data_i;
		  5'd22: a[3][183:176]<=data_i;
		  5'd23: a[3][191:184]<=data_i;
		  5'd24: a[3][199:192]<=data_i;
		  5'd25: a[3][207:200]<=data_i;
		  5'd26: a[3][215:208]<=data_i;
		  5'd27: a[3][223:216]<=data_i;
		  5'd28: a[3][231:224]<=data_i;
		  5'd29: a[3][239:232]<=data_i;
		  5'd30: a[3][247:240]<=data_i;
		  5'd31: a[3][255:248]<=data_i;
		endcase
	     end
	   2'd1:
	     begin
		case (addr)
		  5'd0: a[1][7:0]<=data_i;
		  5'd1: a[1][15:8]<=data_i;
		  5'd2: a[1][23:16]<=data_i;
		  5'd3: a[1][31:24]<=data_i;
		  5'd4: a[1][39:32]<=data_i;
		  5'd5: a[1][47:40]<=data_i;
		  5'd6: a[1][55:48]<=data_i;
		  5'd7: a[1][63:56]<=data_i;
		  5'd8: a[1][71:64]<=data_i;
		  5'd9: a[1][79:72]<=data_i;
		  5'd10: a[1][87:80]<=data_i;
		  5'd11: a[1][95:88]<=data_i;
		  5'd12: a[1][103:96]<=data_i;
		  5'd13: a[1][111:104]<=data_i;
		  5'd14: a[1][119:112]<=data_i;
		  5'd15: a[1][127:120]<=data_i;
		  5'd16: a[1][135:128]<=data_i;
		  5'd17: a[1][143:136]<=data_i;
		  5'd18: a[1][151:144]<=data_i;
		  5'd19: a[1][159:152]<=data_i;
		  5'd20: a[1][167:160]<=data_i;
		  5'd21: a[1][175:168]<=data_i;
		  5'd22: a[1][183:176]<=data_i;
		  5'd23: a[1][191:184]<=data_i;
		  5'd24: a[1][199:192]<=data_i;
		  5'd25: a[1][207:200]<=data_i;
		  5'd26: a[1][215:208]<=data_i;
		  5'd27: a[1][223:216]<=data_i;
		  5'd28: a[1][231:224]<=data_i;
		  5'd29: a[1][239:232]<=data_i;
		  5'd30: a[1][247:240]<=data_i;
		  5'd31: a[1][255:248]<=data_i;
		endcase
	     end
	   2'd2:
	     begin
		case (addr)
		  5'd0: a[2][7:0]<=data_i;
		  5'd1: a[2][15:8]<=data_i;
		  5'd2: a[2][23:16]<=data_i;
		  5'd3: a[2][31:24]<=data_i;
		  5'd4: a[2][39:32]<=data_i;
		  5'd5: a[2][47:40]<=data_i;
		  5'd6: a[2][55:48]<=data_i;
		  5'd7: a[2][63:56]<=data_i;
		  5'd8: a[2][71:64]<=data_i;
		  5'd9: a[2][79:72]<=data_i;
		  5'd10: a[2][87:80]<=data_i;
		  5'd11: a[2][95:88]<=data_i;
		  5'd12: a[2][103:96]<=data_i;
		  5'd13: a[2][111:104]<=data_i;
		  5'd14: a[2][119:112]<=data_i;
		  5'd15: a[2][127:120]<=data_i;
		  5'd16: a[2][135:128]<=data_i;
		  5'd17: a[2][143:136]<=data_i;
		  5'd18: a[2][151:144]<=data_i;
		  5'd19: a[2][159:152]<=data_i;
		  5'd20: a[2][167:160]<=data_i;
		  5'd21: a[2][175:168]<=data_i;
		  5'd22: a[2][183:176]<=data_i;
		  5'd23: a[2][191:184]<=data_i;
		  5'd24: a[2][199:192]<=data_i;
		  5'd25: a[2][207:200]<=data_i;
		  5'd26: a[2][215:208]<=data_i;
		  5'd27: a[2][223:216]<=data_i;
		  5'd28: a[2][231:224]<=data_i;
		  5'd29: a[2][239:232]<=data_i;
		  5'd30: a[2][247:240]<=data_i;
		  5'd31: a[2][255:248]<=data_i;
		endcase
	     end
	   2'd0:
	     begin
		case (addr)

		  5'd0: data_o<=c[7:0];	   
		  5'd1: data_o<=c[15:8];   
		  5'd2: data_o<=c[23:16];  
		  5'd3: data_o<=c[31:24];  
		  5'd4: data_o<=c[39:32];  
		  5'd5: data_o<=c[47:40];  
		  5'd6: data_o<=c[55:48];  
		  5'd7: data_o<=c[63:56];  
		  5'd8: data_o<=c[71:64];  
		  5'd9: data_o<=c[79:72];  
		  5'd10: data_o<=c[87:80]; 
		  5'd11: data_o<=c[95:88]; 
		  5'd12: data_o<=c[103:96];
		  5'd13: data_o<=c[111:104];
		  5'd14: data_o<=c[119:112];
		  5'd15: data_o<=c[127:120];
		  5'd16: data_o<=c[135:128];
		  5'd17: data_o<=c[143:136];
		  5'd18: data_o<=c[151:144];
		  5'd19: data_o<=c[159:152];
		  5'd20: data_o<=c[167:160];
		  5'd21: data_o<=c[175:168];
		  5'd22: data_o<=c[183:176];
		  5'd23: data_o<=c[191:184];
		  5'd24: data_o<=c[199:192];
		  5'd25: data_o<=c[207:200];
		  5'd26: data_o<=c[215:208];
		  5'd27: data_o<=c[223:216];
		  5'd28: data_o<=c[231:224];
		  5'd29: data_o<=c[239:232];
		  5'd30: data_o<=c[247:240];
		  5'd31: data_o<=c[255:248];
		endcase
	     end
	 endcase // case (reg_sel)
      end
   end 
endmodule

