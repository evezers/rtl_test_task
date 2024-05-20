onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix float32 /testbench/num
add wave -noupdate -radix float32 /testbench/sum
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {959 ns} 0} {{Cursor 2} {1084 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 333
configure wave -valuecolwidth 92
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1279 ns}
