import numpy as np

N=2**5
t=np.linspace(0,1,N-1)
fs=20
output= np.sin(2*np.pi*fs*t)
output=np.round(np.sin(2*np.pi*fs*t)*15).astype(np.uint8)



with open("C:\MWT2\DSS\coswavesoted.mif",'w') as file:
    file.write("--this has been genearted from python\n")
    file.write("DEPTH = 32; -- The size of memory in words \nWIDTH = 8; -- The size of data in bits \nADDRESS_RADIX = HEX; -- The radix for address values \nDATA_RADIX = BIN; -- The radix for data values \nCONTENT -- start of (address : data pairs) ")
    file.write("\nBEGIN\n")
    for i in range(len(output)):
        message =hex(i)[2:]
        if len(hex(i)[2:])<2:
            message ='0'+hex(i)[2:]
        b =bin(int(output[i])).removeprefix("-0b")[2:]
        lenofb=len(b)
        a=""
        if lenofb<8:
            a="".join(["0" for j in range(abs(lenofb-8))])
        b=a+b
        
        file.write(f"\n{message} : {b};")
    file.write("\nEnd;")