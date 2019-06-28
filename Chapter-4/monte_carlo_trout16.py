###########################################################################
### Chapter 4 - Evaluating Hitters by Monte Carlo Simulation            ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import numpy as np
from random import random

probs = pd.read_csv("Trout2016_probs.csv")

# we create a list that keeps the probability sum of the events up to the corresponding element
# this will help us decide which event happened when we draw the random number during the Monte Carlo simulation

probs_cumsum = list(np.cumsum(list(probs['Probability'])))

runs = pd.read_csv("runs.csv")
outs = pd.read_csv("outs.csv")
state_transitions = pd.read_csv("state_transitions.csv",dtype=object)

nsim = input("How many simulations do you want: ")

if (int(nsim) < 10000):
        print(" **** A higher number of simulations will provide a more accurate answer **** ")
        print(" **** Don't be afraid I can handle orders of magnitude higher **** ")

nruns = []

for i in range(int(nsim)):
	inning_state = '000'
	inning_outs = 0
	inning_runs = 0
	while (inning_outs <3):
		# first let's find what event happened
		coin_flip = random()
		if coin_flip < probs_cumsum[0]:
			event = 0 ## note that this is event code - 1 since in Python indices start from 0 and not 1
		else:
			event = [i for i in range(len(probs_cumsum)) if coin_flip >= probs_cumsum[i] and coin_flip < probs_cumsum[i+1]][0]+1
		# find how many runs happened
		inning_runs += runs[inning_state+'-'+str(inning_outs)][event]
		# find how many outs were added 
		inning_outs += outs[inning_state+'-'+str(inning_outs)][event]
		# find the new state
		inning_state = str(state_transitions[inning_state][event])
	nruns.append(inning_runs)


print("The average number of runs/inning for a team of Mike Trouts is: ", np.mean(nruns))
