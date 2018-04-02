from Crypto.Cipher import AES
import base64
	
encryptedShellcode = raw_input('Please enter the encrypted payload: ')	
key = raw_input('Please enter the key to decrypt the payload: ')

padding = '?'
b64decodeAES = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(padding)

cipher = AES.new(key)
decoded = b64decodeAES(cipher, encryptedShellcode)
	
decodeFormatted = ' '
for x in bytearray(decoded):
	decodeFormatted += '\\x'
	convert = '%02x' % (x & 0xff)
	decodeFormatted += convert

print decodeFormatted 
