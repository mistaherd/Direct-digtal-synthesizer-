import numpy as np
import sys
def sine_wave_cycle_logic(choice:int,fs=1,Number_of_bits=8,amount_ofmem=32):
    if choice==0:
        N=2**Number_of_bits
        t=np.linspace(0,N,amount_ofmem)

        output= np.sin(2*np.pi*fs*t)*255
        output=output.astype(np.uint8)
    elif choice==1:
        N=2**Number_of_bits
        t=np.linspace(0,N,amount_ofmem*2)
        output= np.sin(2*np.pi*fs*t)+12
        output=np.round(output)[:32]
    elif choice==2:
        N=2**Number_of_bits
        t=np.linspace(0,N,amount_ofmem*4)

        output= np.sin(2*np.pi*fs*t)+12
        output=np.round(output)[:32]
    else:
        print("0: full cycle sine wave \n1: half cycle sine wave")
        return None

    return output
def complement_2s(data):
    ones="".join('0' if data[i]=='1' else '1' for i in range(len(data)))
    j=False
    i=0
    twos=bin(int(ones,2)+1)

    return twos

output=sine_wave_cycle_logic(0)

def write_mif(fname=None,amountofbits=8,size_ofmem=32):
    with open(r"C:\Users\lanzb\Documents\Github\Direct-digtal-synthesizer-\coswavesoted.mif",'w') as file:
        file.write("--This has been generated from python\n")
        #change_string
        file.write("DEPTH = 32; -- The size of memory in words \nWIDTH =10; -- The size of data in bits \nADDRESS_RADIX = HEX; -- The radix for address values \nDATA_RADIX = BIN; -- The radix for data values \nCONTENT -- start of (address : data pairs) ")
        file.write("\nBEGIN\n")
        for i in range(0,len(output)):
            message =hex(i)[2:]
            if len(hex(i)[2:])<2:
                message ='0'+hex(i)[2:]
            b=bin(int(output[i]))
            lenofb=len(b)
            if int(output[i])<12:

                a="".join(["0" for j in range(8-lenofb)])
                b=a+b
                b=complement_1s(b)
            else:
                b=bin(int(output[i]))[2:]
                a="".join(["0" for j in range(8-lenofb)])
                b=a+b
            print(b,len(b))
            file.write(f"\n{message} : {b};")
        file.write("\nEnd;")
