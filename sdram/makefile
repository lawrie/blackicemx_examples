VERILOG = BlackiceMxSocSdram.v blackice_mx_pll.v

bin/toplevel.json : ${VERILOG}
	mkdir -p bin
	yosys -v3 -p "synth_ice40 -top BlackiceMxSocSdram -json bin/toplevel.json" ${VERILOG}

bin/toplevel.asc : blackice_mx_sdram.pcf bin/toplevel.json
	nextpnr-ice40 --freq 25 --hx8k --package tq144:4k --json bin/toplevel.json --pcf blackice_mx_sdram.pcf --asc bin/toplevel.asc --opt-timing --placer heap

bin/toplevel.bin : bin/toplevel.asc
	icepack bin/toplevel.asc bin/toplevel.bin

compile : bin/toplevel.bin

time: bin/toplevel.bin
	icetime -tmd hx8k bin/toplevel.asc

prog : bin/toplevel.bin
	stty -F /dev/ttyACM0 raw
	cat bin/toplevel.bin >/dev/ttyACM0

clean :
	rm -rf bin
