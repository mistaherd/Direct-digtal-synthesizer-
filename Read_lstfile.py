import pandas as pd
import numpy as np
import matplotlib.pylab as plt
fname="outputofrom.lst"
with open(fname, 'r') as file:
    lines = file.readlines()  # Read all lines into a list
    items = [line.strip() for line in lines]  # Remove newline characters and
output=[items[i].split() for i in range(len(items))]
output=output[3:]
header=["ps","Delta","clkin","datain","dataout","testout"]
for i in range(len(output)):
    output[i][0]=int(output[i][0])*10**-3
df =pd.DataFrame(data=output,columns=header,index=None)
time_bins=df.ps.to_list()
output_lut=df.dataout.to_list()
output_lut=["00000000" if output_lut[i]=="UUUUUUUU" else output_lut[i]  for i in range(len(output_lut))]
def reverse_two_complement(bin_string):
    decimal = int(bin_string, 2) - 1  # Convert to decimal, subtract 1
    flipped_binary = bin(decimal ^ (2 ** (len(bin_string)) - 1))[2:].zfill(len(bin_string))  # Flip bits
    return flipped_binary
output_lut=[int(output_lut[i],2) if output_lut[i][0]=="0" else int(reverse_two_complement(output_lut[i]),2)*-1 for i in range(len(output_lut))]
# plt.plot(time_bins,output_lut)
# plt.xlabel("time in nano seconds")
# plt.ylabel("Amplitude ")
# plt.show()
yf=np.fft.fft(output_lut)
xf=np.fft.fftfreq(len(output_lut),1/2**5)
plt.stem(xf[:len(xf)//2],2.0/len(output_lut) *np.abs(yf[:len(yf)//2]))
plt.xlabel('Frequency (Hz)')
plt.ylabel('Magnitude')
plt.grid()

plt.show()