onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib fir_compiler_4_opt

do {wave.do}

view wave
view structure
view signals

do {fir_compiler_4.udo}

run -all

quit -force
