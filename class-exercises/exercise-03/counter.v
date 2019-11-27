

module counter (/*AUTOARG*/
   // Inputs
   clk
   ) ;

   input clk;
   
   
   reg [15:0] counter;
   initial counter = 0;
   always @(posedge clk)
     if (counter == 16'd22)
       counter <= 0;
     else
       counter <= counter + 1'b1;

`ifdef FORMAL

   reg        f_past_valid;

   initial	f_past_valid = 1'b0;
   always @(posedge i_clk)
     f_past_valid <= 1'b1;
   
   // always @(*)
   //   assert (counter != 15'd500);   

   always @(posedge clk)
     if (f_past_valid &&($past(counter) == 16'd22)) begin
        assert(counter == 0);
     end else if (f_past_valid && (counter != 16'd22)) begin
        assert (counter == ($past(counter)+1) );        
     end
   
`endif
   
endmodule // counter
