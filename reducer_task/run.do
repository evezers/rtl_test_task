vlog adder.v reducer.sv testbench.sv
vsim -voptargs=+acc work.testbench
do wave.do
run -all
