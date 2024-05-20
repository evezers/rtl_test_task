`include "adder.v"

module reducer
(
    input logic clk,
    input logic reset,
    input logic [31:0] num_i,
    output logic [31:0] sum_o
);
  logic [31:0] w_adder;
  logic [31:0] r_sum;

  assign sum_o = r_sum;

  adder  adder_inst (
    .clk(clk),
    .rst(reset),
    .input_a(num_i),
    .input_a_stb(1'b1),
    .input_a_ack(input_a_ack),
    .input_b(r_sum),
    .input_b_stb(1'b1),
    .input_b_ack(input_b_ack),
    .output_z(w_adder),
    .output_z_stb(output_z_stb),
    .output_z_ack(1'b1)
  );

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      r_sum <= 0;
    end else begin

      if (output_z_stb)
        r_sum <= w_adder;
    end
  end

endmodule