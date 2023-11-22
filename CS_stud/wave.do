onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/INPUT_DATA
add wave -noupdate /test/GOLDEN
add wave -noupdate /test/N_PAT
add wave -noupdate /test/t_reset
add wave -noupdate /test/reset
add wave -noupdate /test/clk
add wave -noupdate /test/ready
add wave -noupdate /test/stop
add wave -noupdate /test/flag1
add wave -noupdate /test/flag2
add wave -noupdate /test/pclk
add wave -noupdate /test/i
add wave -noupdate /test/out_f
add wave -noupdate /test/err
add wave -noupdate /test/pattern_num
add wave -noupdate /test/a
add wave -noupdate /test/b
add wave -noupdate /test/X
add wave -noupdate /test/data_base1
add wave -noupdate /test/data_base2
add wave -noupdate /test/data_tmp
add wave -noupdate /test/Y
add wave -noupdate /test/appr
add wave -noupdate /test/avg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {630 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
