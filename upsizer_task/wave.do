onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/s_valid_i
add wave -noupdate /testbench/s_ready_o
add wave -noupdate /testbench/s_last_i
add wave -noupdate /testbench/s_data_i
add wave -noupdate /testbench/m_valid_o
add wave -noupdate /testbench/m_ready_i
add wave -noupdate /testbench/m_last_o
add wave -noupdate -radix binary -childformat {{{/testbench/m_keep_o[1]} -radix binary} {{/testbench/m_keep_o[0]} -radix binary}} -subitemconfig {{/testbench/m_keep_o[1]} {-height 16 -radix binary} {/testbench/m_keep_o[0]} {-height 16 -radix binary}} /testbench/m_keep_o
add wave -noupdate -expand /testbench/m_data_o
add wave -noupdate -expand /testbench/stream_upsize_inst/r_latency_shift
add wave -noupdate -radix decimal /testbench/stream_upsize_inst/j
add wave -noupdate /testbench/stream_upsize_inst/r_valid_i
add wave -noupdate -radix binary -childformat {{{/testbench/stream_upsize_inst/r_keep_shift[2]} -radix binary} {{/testbench/stream_upsize_inst/r_keep_shift[1]} -radix binary} {{/testbench/stream_upsize_inst/r_keep_shift[0]} -radix binary}} -subitemconfig {{/testbench/stream_upsize_inst/r_keep_shift[2]} {-height 16 -radix binary} {/testbench/stream_upsize_inst/r_keep_shift[1]} {-height 16 -radix binary} {/testbench/stream_upsize_inst/r_keep_shift[0]} {-height 16 -radix binary}} /testbench/stream_upsize_inst/r_keep_shift
add wave -noupdate /testbench/stream_upsize_inst/r_last
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {131 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 282
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {215 ns}
