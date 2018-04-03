#import required modules
from Crypto.Cipher import AES
import base64

#asking the user to enter the encrypted payload and the key to decrypt the payload.
encryptedShellcode = raw_input('Please enter the encrypted payload: ')	
key = raw_input('Please enter the key to decrypt the payload: ')

#the same padding as before, needs to be the same as this will be stripped from the decrypted payload
padding = '?'

#lambda function to base64 decode the payload, decrypt it and remove the padding
b64decodeAES = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(padding)

#again, the cipher is the key entered by the user
cipher = AES.new(key)

#decoded is calling b64decodeAES with the key and encrypted shellcode as parameters
decoded = b64decodeAES(cipher, encryptedShellcode)

#creating decodeFormatted
decodeFormatted = ' '

#looping through decoded, the decoded payload and formatting it as hex, writing it to decodeFormatted
for x in bytearray(decoded):
	decodeFormatted += '\\x'
	convert = '%02x' % (x & 0xff)
	decodeFormatted += convert

print decodeFormatted 

