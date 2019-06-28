###########################################################################
### Chapter 4 - Evaluating Hitters by Monte Carlo Simulation            ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import numpy as np
from random import random

print("++++++++ Damn Yankees! Joe Hardy & Monte Carlo ++++++++")

# 0.5 probability of a home run at each plate appearance
# 0.5 probability of an out at each plate appearance

nsim = input("How many simulations do you want: ")

if (int(nsim) < 10000):
	print(" **** A higher number of simulations will provide a more accurate answer **** ")
	print(" **** Don't be afraid I can handle orders of magnitude higher **** ")

# the following list will keep the number of runs for each inning simulated 
nruns = []

for i in range(int(nsim)):
	inning_runs = 0
	inning_outs = 0
	while (inning_outs <3):
		if (random() < 0.5):
			inning_runs += 1
		else:
			inning_outs += 1
	nruns.append(inning_runs)

print("The average number of runs/inning for a team of Joe Hardys is: ", np.mean(nruns))	
