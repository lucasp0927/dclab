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
   reg [8:0] 	i;
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
      m_o [7:0] = n [7:0];
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
	 a<=1;
	 i<=0;
	 k<=0;
	 n<=0;
	 m<=0;
	 //U<=1;
	 c_ready <= 0;
	 t_ready <= 0;
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
		  5'd0: a[3][1*8-1:0]<=data_i;
		  5'd1: a[3][2*8-1:1*8]<=data_i;
		  5'd2: a[3][3*8-1:2*8]<=data_i;
		  5'd3: a[3][4*8-1:3*8]<=data_i;
		  5'd4: a[3][5*8-1:4*8]<=data_i;
		  5'd5: a[3][6*8-1:5*8]<=data_i;
		  5'd6: a[3][7*8-1:6*8]<=data_i;
		  5'd7: a[3][8*8-1:7*8]<=data_i;
		  5'd8: a[3][9*8-1:8*8]<=data_i;
		  5'd9: a[3][10*8-1:9*8]<=data_i;
		  5'd10: a[3][11*8-1:10*8]<=data_i;
		  5'd11: a[3][12*8-1:11*8]<=data_i;
		  5'd12: a[3][13*8-1:12*8]<=data_i;
		  5'd13: a[3][14*8-1:13*8]<=data_i;
		  5'd14: a[3][15*8-1:14*8]<=data_i;
		  5'd15: a[3][16*8-1:15*8]<=data_i;
		  5'd16: a[3][17*8-1:16*8]<=data_i;
		  5'd17: a[3][18*8-1:17*8]<=data_i;
		  5'd18: a[3][19*8-1:18*8]<=data_i;
		  5'd19: a[3][20*8-1:19*8]<=data_i;
		  5'd20: a[3][21*8-1:20*8]<=data_i;
		  5'd21: a[3][22*8-1:21*8]<=data_i;
		  5'd22: a[3][23*8-1:22*8]<=data_i;
		  5'd23: a[3][24*8-1:23*8]<=data_i;
		  5'd24: a[3][25*8-1:24*8]<=data_i;
		  5'd25: a[3][26*8-1:25*8]<=data_i;
		  5'd26: a[3][27*8-1:26*8]<=data_i;
		  5'd27: a[3][28*8-1:27*8]<=data_i;
		  5'd28: a[3][29*8-1:28*8]<=data_i;
		  5'd29: a[3][30*8-1:29*8]<=data_i;
		  5'd30: a[3][31*8-1:30*8]<=data_i;
		  5'd31: a[3][32*8-1:31*8]<=data_i;
		endcase
	     end
	   2'd1:
	     begin
		case (addr)
		  5'd0: a[1][1*8-1:0]<=data_i;
		  5'd1: a[1][2*8-1:1*8]<=data_i;
		  5'd2: a[1][3*8-1:2*8]<=data_i;
		  5'd3: a[1][4*8-1:3*8]<=data_i;
		  5'd4: a[1][5*8-1:4*8]<=data_i;
		  5'd5: a[1][6*8-1:5*8]<=data_i;
		  5'd6: a[1][7*8-1:6*8]<=data_i;
		  5'd7: a[1][8*8-1:7*8]<=data_i;
		  5'd8: a[1][9*8-1:8*8]<=data_i;
		  5'd9: a[1][10*8-1:9*8]<=data_i;
		  5'd10: a[1][11*8-1:10*8]<=data_i;
		  5'd11: a[1][12*8-1:11*8]<=data_i;
		  5'd12: a[1][13*8-1:12*8]<=data_i;
		  5'd13: a[1][14*8-1:13*8]<=data_i;
		  5'd14: a[1][15*8-1:14*8]<=data_i;
		  5'd15: a[1][16*8-1:15*8]<=data_i;
		  5'd16: a[1][17*8-1:16*8]<=data_i;
		  5'd17: a[1][18*8-1:17*8]<=data_i;
		  5'd18: a[1][19*8-1:18*8]<=data_i;
		  5'd19: a[1][20*8-1:19*8]<=data_i;
		  5'd20: a[1][21*8-1:20*8]<=data_i;
		  5'd21: a[1][22*8-1:21*8]<=data_i;
		  5'd22: a[1][23*8-1:22*8]<=data_i;
		  5'd23: a[1][24*8-1:23*8]<=data_i;
		  5'd24: a[1][25*8-1:24*8]<=data_i;
		  5'd25: a[1][26*8-1:25*8]<=data_i;
		  5'd26: a[1][27*8-1:26*8]<=data_i;
		  5'd27: a[1][28*8-1:27*8]<=data_i;
		  5'd28: a[1][29*8-1:28*8]<=data_i;
		  5'd29: a[1][30*8-1:29*8]<=data_i;
		  5'd30: a[1][31*8-1:30*8]<=data_i;
		  5'd31: a[1][32*8-1:31*8]<=data_i;
		endcase
	     end
	   2'd2:
	     begin
		case (addr)
		  5'd0: a[2][1*8-1:0]<=data_i;
		  5'd1: a[2][2*8-1:1*8]<=data_i;
		  5'd2: a[2][3*8-1:2*8]<=data_i;
		  5'd3: a[2][4*8-1:3*8]<=data_i;
		  5'd4: a[2][5*8-1:4*8]<=data_i;
		  5'd5: a[2][6*8-1:5*8]<=data_i;
		  5'd6: a[2][7*8-1:6*8]<=data_i;
		  5'd7: a[2][8*8-1:7*8]<=data_i;
		  5'd8: a[2][9*8-1:8*8]<=data_i;
		  5'd9: a[2][10*8-1:9*8]<=data_i;
		  5'd10: a[2][11*8-1:10*8]<=data_i;
		  5'd11: a[2][12*8-1:11*8]<=data_i;
		  5'd12: a[2][13*8-1:12*8]<=data_i;
		  5'd13: a[2][14*8-1:13*8]<=data_i;
		  5'd14: a[2][15*8-1:14*8]<=data_i;
		  5'd15: a[2][16*8-1:15*8]<=data_i;
		  5'd16: a[2][17*8-1:16*8]<=data_i;
		  5'd17: a[2][18*8-1:17*8]<=data_i;
		  5'd18: a[2][19*8-1:18*8]<=data_i;
		  5'd19: a[2][20*8-1:19*8]<=data_i;
		  5'd20: a[2][21*8-1:20*8]<=data_i;
		  5'd21: a[2][22*8-1:21*8]<=data_i;
		  5'd22: a[2][23*8-1:22*8]<=data_i;
		  5'd23: a[2][24*8-1:23*8]<=data_i;
		  5'd24: a[2][25*8-1:24*8]<=data_i;
		  5'd25: a[2][26*8-1:25*8]<=data_i;
		  5'd26: a[2][27*8-1:26*8]<=data_i;
		  5'd27: a[2][28*8-1:27*8]<=data_i;
		  5'd28: a[2][29*8-1:28*8]<=data_i;
		  5'd29: a[2][30*8-1:29*8]<=data_i;
		  5'd30: a[2][31*8-1:30*8]<=data_i;
		  5'd31: a[2][32*8-1:31*8]<=data_i;
		endcase
	     end
	   2'd0:
	     begin
		case (addr)
		  5'd0: data_o<=a[0][1*8-1:0];
		  5'd1: data_o<=a[0][2*8-1:1*8];
		  5'd2: data_o<=a[0][3*8-1:2*8];
		  5'd3: data_o<=a[0][4*8-1:3*8];
		  5'd4: data_o<=a[0][5*8-1:4*8];
		  5'd5: data_o<=a[0][6*8-1:5*8];
		  5'd6: data_o<=a[0][7*8-1:6*8];
		  5'd7: data_o<=a[0][8*8-1:7*8];
		  5'd8: data_o<=a[0][9*8-1:8*8];
		  5'd9: data_o<=a[0][10*8-1:9*8];
		  5'd10: data_o<=a[0][11*8-1:10*8];
		  5'd11: data_o<=a[0][12*8-1:11*8];
		  5'd12: data_o<=a[0][13*8-1:12*8];
		  5'd13: data_o<=a[0][14*8-1:13*8];
		  5'd14: data_o<=a[0][15*8-1:14*8];
		  5'd15: data_o<=a[0][16*8-1:15*8];
		  5'd16: data_o<=a[0][17*8-1:16*8];
		  5'd17: data_o<=a[0][18*8-1:17*8];
		  5'd18: data_o<=a[0][19*8-1:18*8];
		  5'd19: data_o<=a[0][20*8-1:19*8];
		  5'd20: data_o<=a[0][21*8-1:20*8];
		  5'd21: data_o<=a[0][22*8-1:21*8];
		  5'd22: data_o<=a[0][23*8-1:22*8];
		  5'd23: data_o<=a[0][24*8-1:23*8];
		  5'd24: data_o<=a[0][25*8-1:24*8];
		  5'd25: data_o<=a[0][26*8-1:25*8];
		  5'd26: data_o<=a[0][27*8-1:26*8];
		  5'd27: data_o<=a[0][28*8-1:27*8];
		  5'd28: data_o<=a[0][29*8-1:28*8];
		  5'd29: data_o<=a[0][30*8-1:29*8];
		  5'd30: data_o<=a[0][31*8-1:30*8];
		  5'd31: data_o<=a[0][32*8-1:31*8];
		endcase
	     end
	 endcase // case (reg_sel)
      end
   end 
endmodule

