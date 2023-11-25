onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ghost_sprite_opt

do {wave.do}

view wave
view structure
view signals

do {ghost_sprite.udo}

run -all

quit -force
