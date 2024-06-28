vlib work
vdel -all
vlib work

vlog -f $1.list +acc -sv
vsim work.tb
do wave.do  //comment for first time simulation.
#add wave -r * //uncomment for first time simulation.
run -all
