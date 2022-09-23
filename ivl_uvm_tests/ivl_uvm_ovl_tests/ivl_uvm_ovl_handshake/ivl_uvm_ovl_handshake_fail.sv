`timescale 1ns/1ns
module test;

   wire clk;
   reg rst_n;
   reg req;
   reg ack;
  initial begin
// Dump waves
      $dumpfile("dump_fail.vcd");
      $dumpvars(1, test);	 
   end
   // simple signal check OVL 
   ovl_handshake #(1,0,3,1,1,1) u_ovl_handshake ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .req (req),
			     .ack (ack)
			     );
      initial begin
      // Initialize values.
      rst_n = 0;
      req=0;
      ack=0;
      $display("ovl_handshake does not fire at rst_n");
      wait_clks(5);
rst_n = 1;
      wait_clks(1);
      req =1; 
      rst_n =0;
      req=0;
      ack=0;
      $display("ovl_hanshake does not fire at rst_n");
      wait_clks(5);
      rst_n=1;
      wait_clks(1);
      req=1;
      wait_clks(1);
      ack=0;
      $display("ovl_handshake :: Error condition when req is high then ack is high");


      req=1;
      ack=1;
      $display("ovl_handshake req and ack both low");
      wait_clks(5);
      rst_n=1;
      wait_clks(1);
      req=0;
      ack=0;
      wait_clks(5);
      
      $display("ovl_handshake :: Error condition No request but Ack is there");
      req=0;
      ack=0;
      wait_clks(1);
      ack=0;
rst_n = 1;
      wait_clks(1);
      req =1;
      
        
    rst_n =0;
    req=0;
      ack=0;
      $display("ovl_hanshake does not fire at rst_n");
      wait_clks(5);
      rst_n=1;
      wait_clks(1);
      req=1;
      wait_clks(1);
      ack=1;
      $display("ovl_handshake :: Error condition when req is high then ack is high");


      req=0;
      ack=0;
      $display("ovl_handshake req and ack both low");
      wait_clks(5);
      rst_n=1;
      wait_clks(1);
      req=1;
      ack=0;
      wait_clks(5);
      
      $display("ovl_handshake :: Error condition No request but Ack is there");
      req=0;
      ack=1;
      wait_clks(1);
      ack=0;
      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
