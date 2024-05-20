module testbench #(
    parameter T_DATA_WIDTH_TEST = 4,
    T_DATA_RATIO_TEST = 2
) ();
  logic [T_DATA_WIDTH_TEST-1:0] s_data_i;
  logic s_last_i;
  logic s_valid_i;
  logic s_ready_o;
  logic [T_DATA_WIDTH_TEST-1:0] m_data_o[T_DATA_RATIO_TEST-1:0];
  logic [T_DATA_RATIO_TEST-1:0] m_keep_o;
  logic m_last_o;
  logic m_valid_o;
  logic m_ready_i;

  /* Make a reset that pulses once. */
  logic reset = 0;
  initial begin
    s_valid_i = 0;
    s_last_i  = 0;
    s_data_i  = 4'hE;
    m_ready_i = 1;

    #17 reset = 1;
    #11 reset = 0;
    #29 reset = 1;
    #11 reset = 0;

    #17;

    #10;
    s_valid_i = 1;
    s_data_i  = 4'h0;

    #10;
    s_data_i = 4'h1;

    #10;
    s_last_i = 1;
    s_data_i = 4'h2;

    #10;
    s_last_i = 0;
    s_data_i = 4'hA;


    #10;

    #10;
    s_last_i = 1;
    s_data_i = 4'hB;

    #10;
    s_valid_i = 0;
    s_last_i  = 0;
    s_data_i  = 4'hE;

    #20 $stop;
  end

  /* Make a regular pulsing clock. */
  logic clk = 0;
  always #5 clk = !clk;

  stream_upsize #(
      .T_DATA_WIDTH(T_DATA_WIDTH_TEST),
      .T_DATA_RATIO(T_DATA_RATIO_TEST)
  ) stream_upsize_inst (
      .clk(clk),
      .rst_n(!reset),
      .s_data_i(s_data_i),
      .s_last_i(s_last_i),
      .s_valid_i(s_valid_i),
      .s_ready_o(s_ready_o),
      .m_data_o(m_data_o),
      .m_keep_o(m_keep_o),
      .m_last_o(m_last_o),
      .m_valid_o(m_valid_o),
      .m_ready_i(m_ready_i)
  );



  //   initial begin
  //     $monitor("At time %t, value = %h", $time, s_data_i);
  //   end

  //   initial begin
  //     $dumpfile("out.vcd");
  //     $dumpvars(0, clk);
  //     $dumpvars(1, reset);
  //     // $dumpvars(2, s_data_i);
  //     $dumpvars(3, s_ready_o);
  //     $dumpvars(4, s_valid_o);
  //   end

endmodule
