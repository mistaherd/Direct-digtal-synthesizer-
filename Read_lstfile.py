import pandas as pd
import numpy as np
import matplotlib.pylab as plt
# fname="outputofrom_fullwave.lst"
# fname="outputfrom_halfwave.lst"
# fname="outputfrom_quaterwave.lst"
#fname="part6.lst"
fname="part6_fix.lst"
with open(fname, 'r') as file:
    lines = file.readlines()  # Read all lines into a list
    items = [line.strip() for line in lines]  # Remove newline characters and
output=[items[i].split() for i in range(len(items))]
#print(output)
output=output[3:]
#header=["ps","Delta","clkin","datain","dataout","testout"]
header=["ps","Delta","clkin","data_port_A","LFSR_OUTPUT","LFSR_BUS","ASK_OUT","LUT_OUT"]
for i in range(len(output)):
    output[i][0]=int(output[i][0])*10**-9
df =pd.DataFrame(data=output,columns=header,index=None)
time_bins=df.ps.to_list()
output_lut=df.ASK_OUT.to_list()
output_lut=["0000000000" if output_lut[i]=="UUUUUUUUUU" else output_lut[i]  for i in range(len(output_lut))]
def reverse_two_complement(bin_string):
    decimal = int(bin_string, 2) - 1  # Convert to decimal, subtract 1i
    flipped_binary=~decimal
#    flipped_binary=''.join(('0'if bin(10)[2:][i]=='1'else '1' for i in range(len(bin(10))-2)))#lp bits
#    if flipped_binary[0]=='1':
 #       flipped_binary=int(flipped_binary)*-1
#    else:
#        flipped_binary=int(flipped_binary)
    return flipped_binary
output=[]
for i in range(len(output_lut)):
    if int(output_lut[i],2)<255:
        output.append(int(output_lut[i],2))
    else:
        output.append(reverse_two_complement(output_lut[i]))
mav_hn=np.ones(3)/3
output=np.convolve(output,mav_hn,mode="same")
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
