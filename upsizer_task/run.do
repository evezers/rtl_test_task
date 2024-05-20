vlog stream_upsize.sv testbench.sv
vsim -voptargs=+acc work.testbench
do wave.do
run -all
