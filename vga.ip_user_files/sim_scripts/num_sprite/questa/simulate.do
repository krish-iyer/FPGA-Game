onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib num_sprite_opt

do {wave.do}

view wave
view structure
view signals

do {num_sprite.udo}

run -all

quit -force
