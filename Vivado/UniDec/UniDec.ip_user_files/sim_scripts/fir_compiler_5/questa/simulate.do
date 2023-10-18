onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib fir_compiler_5_opt

do {wave.do}

view wave
view structure
view signals

do {fir_compiler_5.udo}

run -all

quit -force
