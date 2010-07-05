module oneshot ();
   
   task oneshot
     begin
	case (b)
	  2'b00:
	    if(a == 1'b1)
	      b <= 2'b01;
	  2'b01:
	    begin
	       b <= 2'b10;
	       stop <= stop + 1'b1 ;
	    end
	  2'b10:
	    if(a == 1'b0)
	      b <= 2'b11;
	  2'b11:
	    b <= 2'b00;
	  default:
	    b <= 2'b00;
	endcase // case (b)
     end
   endtask // oneshot

endmodule
