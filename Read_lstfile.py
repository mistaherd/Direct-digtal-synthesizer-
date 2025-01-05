import pandas as pd
import numpy as np
import matplotlib.pylab as plt
# fname="outputofrom_fullwave.lst"
# fname="outputfrom_halfwave.lst"
# fname="outputfrom_quaterwave.lst"
#fname="part6.lst"
#fname="part6_fix.lst"
fname="part7.lst"
amount_of_bits=8
with open(fname, 'r') as file:
    lines = file.readlines()  # Read all lines into a list
    items = [line.strip() for line in lines]  # Remove newline characters and
output=[items[i].split() for i in range(len(items))]
#print(output)
output=output[3:]

#header=["ps","Delta","clkin","datain","dataout","testout"]
#header=["ps","Delta","clkin","data_port_A","LFSR_OUTPUT","LFSR_BUS","ASK_OUT","LUT_OUT"]
header=["ps","Delta","FSK_OUT"]
for i in range(len(output)):
    output[i][0]=int(output[i][0])*10**-6
df =pd.DataFrame(data=output,columns=header,index=None)
#df['ps'] = df['ps'] *10e-6
time_bins=df.ps.to_list()
output_lut=df.FSK_OUT.to_list()
output_lut=["00000000" if output_lut[i]=="UUUUUUUU" else output_lut[i]  for i in range(len(output_lut))]
def reverse_two_complement(bin_string):
    flipped_binary="".join('0' if bin_string[i]=='1' else '1' for i in range(len(bin_string)))
 
    decimal = int(bin_string, 2) + 1  # Convert to decimal, subtract 1
    if decimal>255:
        decimal=255
    binary=bin(decimal)[2:]

    return binary
output=[]
for i in range(len(output_lut)):
    if output_lut[i][4]=='1':
        bin_eqv=reverse_two_complement(output_lut[i])
        logic=-1
    else:
        bin_eqv=output_lut[i]
        logic=1
    real_val=logic*(int(bin_eqv,2)/255)
    output.append(real_val)
#mav_hn=np.ones(3)/3
#output=np.convolve(output,mav_hn,mode="same")
plt.plot(time_bins,output)
plt.xlabel("time in nano seconds")
plt.ylabel("Amplitude ")
plt.show()
yf=np.abs(np.fft.fft(output))
xf=np.fft.fftfreq(len(output),1/32)
plt.stem(xf,yf)
plt.xlabel('Frequency (Hz)')
plt.ylabel('Magnitude')
plt.grid()

plt.show()
