`timescale 1ns/1ns


module test;

   wire clk;
   reg rst_n;
   reg req;
   reg ack;
   initial begin	 
  // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);
end  
   // simple signal check OVL 
   ovl_frame #(0,2,4,0) u_ovl_frame ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .start_event (req),
			     .test_expr (ack)
			     );
   ovl_frame #(1,3,0,0) u_ovl_frame_1 ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .start_event (req),
			     .test_expr (ack)
			     );
ovl_frame #(1,0,7,0) u_ovl_frame_2 ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .start_event (req),
			     .test_expr (ack)
			     );
   initial begin
     
      // Initialize values.
      rst_n = 0;
      req=0;
      ack=0;
      $display("ovl_frame does not fire at rst_n");
      wait_clks(5);

      rst_n = 1;
      req =1;
      wait_clks(3);
      $display("req is high after 3 clocks ack should highi");
      ack=1;
       $display({"ovl_frame does not fire ",
                "when is FALSE"});

      wait_clks(1);
      
      rst_n =0;
      req=0;
      ack=0;
      $display("ovl_frame does not fire at rst_n when min_clk is 3 and max_cks is 0");
      wait_clks(5);
      rst_n=1;
      wait_clks(1);
      req=1;
      wait_clks(3);
      ack=1;
      $display("ovl_frame :: ideal condition when min_clk is 3 and max_cks is 0 Test_expr should low till min_clk -1");

      rst_n =0;
      req=0;
      ack=0;
      $display("ovl_frame does not fire at rst_n when min_clk is 0 and max_cks is 7");
      wait_clks(5);
      rst_n=1;
      req =1;
      ack=0;
      wait_clks(6);  
          
      $display("ovl_frame :: Error condition when min_clk is 3 and max_cks is 0 Test_expr should low till min_clk -1");
      ack=1;
      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


