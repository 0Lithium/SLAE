

#!/usr/bin/python

from statistics import mode
shellcode = ("\xeb\x17\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x59\x31\xd2\xb2\x0d\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xcd\x80\xe8\xe4\xff\xff\xff\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x72\x6c\x64\x21\x0a")
encoded2 = ""

shellcode = bytearray(shellcode)
coded = []
for u in shellcode:
	encoded = '%02x' % u
	coded.append(encoded)

common_byte = mode(coded)


reversed_ = reversed(shellcode) 
for m in reversed_:	
	encoded2 += '0x'
	encoded2 += '%02x,' % m
	
encoded2 = encoded2.replace(common_byte,"0x90")
print "Encoded shellcode.."
print encoded2
print "The common byte : " + common_byte
print 'Len: %d' % len(bytearray(shellcode))
