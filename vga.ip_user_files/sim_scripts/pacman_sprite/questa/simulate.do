onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pacman_sprite_opt

do {wave.do}

view wave
view structure
view signals

do {pacman_sprite.udo}

run -all

quit -force
