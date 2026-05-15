module scr1_cg(clk, clk_en, test_mode, clk_out);
  input clk;
  input clk_en;
  input test_mode;
  output clk_out;

  wire en_or;
  sky130_fd_sc_hd__or2_1 or_gate (
    .A(clk_en),
    .B(test_mode),
    .X(en_or)
  );

  wire clk_inv;
  sky130_fd_sc_hd__inv_1 inv_gate (
    .A(clk),
    .Y(clk_inv)
  );


  wire latch_q;
  sky130_fd_sc_hd__dfrtp_1 cg_latch (
    .CLK(clk_inv),
    .D(en_or),
    .Q(latch_q),
    .RESET_B(1'b1)
  );

  sky130_fd_sc_hd__and2_1 and_gate (
    .A(latch_q),
    .B(clk),
    .X(clk_out)
  );
endmodule

(* blackbox *)
module sky130_fd_sc_hd__or2_1(input A, input B, output X); endmodule

(* blackbox *)
module sky130_fd_sc_hd__inv_1(input A, output Y); endmodule

(* blackbox *)
module sky130_fd_sc_hd__dfrtp_1(input CLK, input D, output Q, input RESET_B); endmodule

(* blackbox *)
module sky130_fd_sc_hd__and2_1(input A, input B, output X); endmodule