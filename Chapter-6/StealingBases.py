###########################################################################
### Chapter 6 - Baseball Decision Making                                ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import numpy as np
from random import random

# input the expected runs for each of the 24 states of an inning 

xRuns = pd.read_csv("xRuns.csv")
transs = dict()
transf = dict()

trans = open("transitionStates.csv","r")

for line in trans:
	linef = line.rstrip().rsplit(",")
	if linef[2] == "s":
		transs[linef[0]] = linef[1]
	else:
		transf[linef[0]] = linef[1]

print("This demo will give you a break even probability of stealing a base for each situation you input.")
print("Assumptions: ")
print("1. The more advanced runner only attempts to steal a base")
print("2. We do not consider situations where the third base is loaded")

state = input("Which bases are loaded? Enter a 3-characters binary string for the three bases (e.g., 010 if there is a runner on second base and none on first and third): ")

outs = input("How many outs?: ")

while state not in ['010','100','110'] or int(outs) > 2 or int(outs) < 0:
	print("Wrong input!! Try again")
	state = input("Which bases are loaded? Enter a 3-characters binary string for the three bases (e.g., 010 if there is a runner on second base and none on first and third): ")
	outs = input("How many outs?: ")

SQ = xRuns[outs][int(state,2)]

# if the steal is successful we advance one base with the same outs
S = xRuns[outs][int(transs[state],2)]
try:
	F = xRuns[str(int(outs)+1)][int(transf[state],2)]
except KeyError:
	F = 0

P = (SQ-F)/(S-F)

print("The break even probability is: ", P)
