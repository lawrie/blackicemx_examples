###############################################################################
#                                                                             #
# Copyright 2016 myStorm Copyright and related                                #
# rights are licensed under the Solderpad Hardware License, Version 0.51      #
# (the “License”); you may not use this file except in compliance with        #
# the License. You may obtain a copy of the License at                        #
# http://solderpad.org/licenses/SHL-0.51. Unless required by applicable       #
# law or agreed to in writing, software, hardware and materials               #
# distributed under this License is distributed on an “AS IS” BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or             #
# implied. See the License for the specific language governing                #
# permissions and limitations under the License.                              #
#                                                                             #
###############################################################################

chip.bin: chip.v hex27seg.v 7seg_display.v 7seg_display.pcf
	yosys -q -p "synth_ice40 -blif chip.blif -top chip" chip.v hex27seg.v 7seg_display.v
	arachne-pnr -d 8k -P tq144:4k -p 7seg_display.pcf chip.blif -o chip.txt
	icepack chip.txt chip.bin

.PHONY: upload
upload: chip.bin
	stty -F /dev/ttyACM0 raw
	cat chip.bin >/dev/ttyACM0

.PHONY: clean
clean:
	$(RM) -f chip.blif chip.txt chip.ex chip.bin
