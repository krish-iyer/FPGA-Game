onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pacman_map_blockmem_opt

do {wave.do}

view wave
view structure
view signals

do {pacman_map_blockmem.udo}

run -all

quit -force
