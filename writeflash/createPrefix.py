import struct

#addr = 0
addr = 0x28000
length = 135100
#length = 0x48fbc

prefix = open("prefix.bin", mode='wb') 
prefix.write(struct.pack('>I', addr))
prefix.write(struct.pack('>I', length))
prefix.close()

