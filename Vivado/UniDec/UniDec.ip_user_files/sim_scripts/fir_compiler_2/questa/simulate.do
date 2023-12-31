onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib fir_compiler_2_opt

do {wave.do}

view wave
view structure
view signals

do {fir_compiler_2.udo}

run -all

quit -force
