module testbench;
  logic [31:0] num;
  logic [31:0] sum;

  /* Make a reset that pulses once. */
  logic reset = 0;
  initial begin
    num <= 0;

    #17 reset = 1;
    #11 reset = 0;
    #29 reset = 1;
    #11 reset = 0;

    #(10);
    #80;
    num <= $shortrealtobits(1.23);
    #160;
    num <= $shortrealtobits(5.23);
    #160;
    num <= $shortrealtobits(40.11);
    #160;
    num <= $shortrealtobits(-1.33);
    #160;
    num <= $shortrealtobits(-100.69);
    #160;
    num <= $shortrealtobits(1.23);
    #160;
    num <= 0;

    #100 $stop;
  end

  /* Make a regular pulsing clock. */
  logic clk = 0;
  always #5 clk = !clk;

  reducer reducer_i (
      .clk  (clk),
      .reset(reset),
      .num_i(num),
      .sum_o(sum)
  );

  initial begin
    $monitor("At time %t, value = %f", $time, $bitstoshortreal(sum));
  end

  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, num);
    $dumpvars(1, sum);
    // $dumpvars(2, c);s
    $dumpvars(3, clk);
    $dumpvars(4, reset);
  end

endmodule  // test
