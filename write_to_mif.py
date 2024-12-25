import numpy as np
import sys
def level_shift(data):
    return np.round(abs(data)*255).astype(int)
def sine_wave_cycle_logic(choice:int,fs=1,Number_of_bits=8,amount_ofmem=32):
    if choice==0:
        N=2**Number_of_bits
        t=np.linspace(0,N,amount_ofmem)

        output= np.sin(2*np.pi*fs*t)
        output=level_shift(output)
    elif choice==1:
        N=2**Number_of_bits
        t=np.linspace(0,N,amount_ofmem*2)
        output= np.sin(2*np.pi*fs*t)
        output=level_shift(output)[:32]
    elif choice==2:
        N=2**Number_of_bits
        t=np.linspace(0,N,amount_ofmem*4)

        output= np.sin(2*np.pi*fs*t)+12
        output=level_shift(output)[:32]
    else:
        print("0: full cycle sine wave \n1: half cycle sine wave")
        return None

    return output
def complement_2s(data,ammount_of_bits):
    ones="".join('0' if data[i]=='1' else '1' for i in range(ammount_of_bits))
    max_val=(2**ammount_of_bits)-1
    ones_dig=int(ones,2)
    if ones_dig>max_val:
        ones_dig-=1
    twos=bin(ones_dig)
  
    return twos[2:]

output=sine_wave_cycle_logic(0)

def write_mif(output,fname=None,amountofbits=8,size_ofmem=32):
    with open(r"C:\Users\lanzb\Documents\Github\Direct-digtal-synthesizer-\coswavesoted.mif",'w') as file:
        file.write("--This has been generated from python\n")
        change_string=f"DEPTH = {size_ofmem}; -- The size of memory in words \nWIDTH = {amountofbits}; -- The size of data in bits \nADDRESS_RADIX = HEX; -- The radix for address values \nDATA_RADIX = BIN; -- The radix for data values \nCONTENT -- start of (address : data pairs)\nBEGIN\n"
        file.write(change_string)
      
        for i in range(size_ofmem):
            message =hex(i)[2:]
            if len(message)<2:
                message ='0'+message
            b=bin(int(output[i]))[2:]
            lenofb=len(b)
           
            half=round((2**amountofbits)-1)
            if int(output[i])<128:
                if lenofb<amountofbits:
                    a="".join(["0" for j in range(amountofbits-lenofb)])
                    b=a+b
                b=complement_2s(b,amountofbits)
                
            else:
                if lenofb<amountofbits:
                    a="".join(["0" for j in range(amountofbits-lenofb)])
                    b=a+b
            
            file.write(f"\n{message} : {b};")
        file.write("\nEND;")
write_mif(output)
