# Direct-digtal-synthesizer 
This document will cover the following
1. DDS basics
2. Phase Accumulator
3. Look up tabe
4. DAC
5. Nice Frequency
6. Jitter
7. Dithering
8. Aliasing 
9. FSW
10. sinc roll off
11. ASK
12. FSK
13. BPSK
## DDS Basics
- Direct digital synthesis (DDS) is a method of producing an analog waveform—usually a sine wave
- by generating a time-varying signal in digital form and then performing a digital-to-analog conversion. Because operations within a DDS device are primarily digital, it can offer fast switching between output frequencies, fine frequency resolution, and operation over a broad spectrum of frequencies.
## Phase Accumulator
A phase accumulator is a modulo-N counter, meaning it cycles through a finite number of states. Its size, typically ranging from 24 to 48 bits, determines the precision of the phase representation. The accumulator is updated constantly, typically determined by the DDS reference clock.
## Look up Table
 is an array that replaces runtime computation with simpler array indexing operation:

| $\dots A_{n+1}$ | $A_2$ | $A_1$ | $A_0$ | output |
| --------------- | ----- | ----- | ----- | ------ |
| $\dots$         | 0     | 0     | 0     | data@0 |
| $\dots$         | 0     | 0     | 1     | data@1 |
| $\dots$         | 0     | 1     | 0     | data@2 |
| $\dots$         | 0     | 1     | 1     | data@3 |
| $\dots$         | 1     | 0     | 0     | data@4 |
| $\dots$         | 1     | 0     | 1     | data@5 |
| $\dots$         | 1     | 1     | 0     | data@6 |
| $\dots$         | 1     | 1     | 1     | data@7 |
- the LUT will select the output data based on the index array which means the DDS can act as a system that samples signals and also as a synthesizer 
## DAC
- The Digital to analogue converter is a Discrete time injector meaning the samples are generator for a set period of time
each  pulse of the staircase generator has the same attributes has the same as the rectangular function look in [[#sinc roll off]] for explain of this.
## Nice Frequency
- Nice frequencies are Large Harmonic Spurs that have quite a large amplitude compared with other spurious components (during the Nice Condition, the only spurious components are those harmonic tones) 
- This happens when the LUT/ROM has $2^P$ locations and nice is when $\text{FSW}=2^j$ where $j<P$

## Jitter
- Variation in periodicity in time domain
- Occurs when FSW is not a power of 2 not a nice frequency output
- To mitigate this
	* post reconstruction filter
	* by Dithering the signal

## Dithering
- process of adding noise to  mask jitter
- used to reduce the amplitude of the harmonic spurs caused by the nice frequency condition
- to midagate:
	method :
	1. PRBS
	
## Aliasing
- The misidentification of a signal when two different expressions refer to the same object or an error that usually appears as a jagged outline
- Happens when the signal is   sampled  lower than Nyquist
	- Nyquist 
		-  a periodic signal  must be  sampled at more than twice the  highest  frequency
	 - prevented by an  antialiasing  filter 
## FSW

## Sinc roll off
- Sinc roll-off is a gradual decrease in the amplitude of a signal as its frequency increases.
- Sinc roll-off primarily occurs in digital-to-analogue converters (DACs) due to a process called zero-order hold (ZOH)
- each sample is held in the analogue at a constant value until the next sample. 
- This process is identical mathematically to convolving the discrete samples (as weighted impulses) with a rectangular function of width T where T is the sample time.
- The Fourier Transform of a rectangular function of width T is a Sinc function with first null at 1/T, where 1/T is the sampling rate.
- Convolving in the time domain is equivalent to multiplying in the frequency domain, so the spectrum of your discrete signal is multiplied by the Sinc function in the process of analogue reconstruction in the DAC due to the zero order hold.
- There are other DAC implementations that reduce this effect such as interpolating DACs and "Return to Zero" (R2Z) DACs. An R2Z DAC forces the output to return to zero prior to the next sample, reducing T and therefore pushing out in frequency where the first null occurs (therefore reducing passband roll off).
 
## ASK

## FSK
## BPSK
