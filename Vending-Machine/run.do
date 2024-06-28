vlib work
vdel -all
vlib work

vlog -f $1.list +acc -sv
vsim work.tb
do wave.do
#add wave -r *
run -all
