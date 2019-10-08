###########################################################################
### Chapter 11 - Streakiness in Sports                                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

# this is an implementation of WWRT

import numpy as np

def find_runs(seq):
	return 1+sum([1 if seq[i]!=seq[i+1] else 0 for i in range(len(seq)-1)])

# returns the z-score of the WWRT test. 
# H_0: elements in the sequence are mutually independent
# H_1: elements in the sequence are NOT mutually independent
def WWRT(seq):
	s = sum(seq)
	f = len(seq)-s
	mu = ((2*s*f)/(s+f))+1
	sigma = np.sqrt((mu-1)*(mu-2)/(s+f-1))
	return (find_runs(seq)-mu)/sigma

# two sequences for illustrative purposes 
seq1 = [0,1,0,0,1,1,1,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,0,1,0]
seq2 = [0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0]

print("Sequence: ",seq1, "has a WWRT z-score of: ", WWRT(seq1))
print("Sequence: ",seq2, "has a WWRT z-score of: ", WWRT(seq2))

