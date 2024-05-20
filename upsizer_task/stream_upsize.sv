module stream_upsize #(
    parameter T_DATA_WIDTH = 1,
    T_DATA_RATIO = 2
) (
    input logic clk,
    input logic rst_n,
    input logic [T_DATA_WIDTH-1:0] s_data_i,
    input logic s_last_i,
    input logic s_valid_i,
    output logic s_ready_o,
    output logic [T_DATA_WIDTH-1:0] m_data_o[T_DATA_RATIO-1:0],
    output logic [T_DATA_RATIO-1:0] m_keep_o,
    output logic m_last_o,
    output logic m_valid_o,
    input logic m_ready_i

);

  int word_counter;
  logic r_last;

  logic [T_DATA_WIDTH-1:0] r_latency_shift[T_DATA_RATIO + 1];
  logic [T_DATA_RATIO:0] r_keep_shift;

  logic r_valid_i;


  always_ff @(posedge clk, posedge rst_n) begin
    if (rst_n == 0) begin

      for (int i = 0; i <= T_DATA_RATIO - 1; i = i + 1) begin
        r_latency_shift[i] <= 0;
      end

      r_valid_i <= 0;
      r_last <= 0;
      r_keep_shift <= 0;

    end else begin
      r_valid_i <= s_valid_i;
      r_last <= s_last_i;

      if (r_last || s_valid_i != 1) begin
        r_latency_shift[T_DATA_RATIO] <= 'hF;
        r_keep_shift <= {1'b0, r_keep_shift[T_DATA_RATIO:1]};
      end else begin
        r_latency_shift[T_DATA_RATIO] <= s_data_i;
        r_keep_shift <= { 1'b1 , r_keep_shift[T_DATA_RATIO:1]};
      end

      for (int i = 0; i <= T_DATA_RATIO - 1; i = i + 1) begin
        r_latency_shift[i] <= r_latency_shift[i+1];
      end
    end
  end

  generate
    for (genvar i = 0; i <= T_DATA_RATIO - 1; i = i + 1) begin
      assign m_data_o[i] = r_latency_shift[i];
      assign m_keep_o[i] = r_keep_shift[i];
    end
  endgenerate

  always_ff @(posedge clk, posedge rst_n) begin
    if (rst_n == 0) begin
      s_ready_o <= 0;
      m_valid_o <= 0;
      m_last_o <= 0;
      word_counter <= T_DATA_RATIO - 1;
    end else begin

      if (r_last || s_valid_i) begin
        if (r_last && word_counter == 0) s_ready_o <= 0;
        else  s_ready_o <= 1;

        if (word_counter == T_DATA_RATIO - 1) begin
          word_counter <= 0;

          if (r_valid_i) m_valid_o <= 1;
          if (r_last) m_last_o <= 1;
        end else begin
          m_valid_o <= 0;
          m_last_o <= 0;

          word_counter <= word_counter + 1;
        end
      end else begin
        m_valid_o <= 0;
        m_last_o  <= 0;
        s_ready_o <= 1;
      end
    end
  end
endmodule
