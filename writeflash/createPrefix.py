import struct

addr = 0
length = 135100

prefix = open("prefix.bin", mode='wb') 
prefix.write(struct.pack('>I', addr))
prefix.write(struct.pack('>I', length))
prefix.close()

