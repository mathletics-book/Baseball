###########################################################################
### Chapter 1 - Pythagorean Theorem in Baseball                         ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import numpy as np
import time
from scipy.optimize import minimize_scalar

df = pd.read_csv("MLB-data.csv")

print("First we will identify the best exponent in the range [1, 3] that minimizes the mean absolute deviation between the Pythagorean equation predicted and the actual win-loss percentage of an MLB team")
print("Using data from 2005-2016 MLB seasons...")
time.sleep(3)

# define the objective function we want to minimize
# this is the sum of the absolute differences between the predicted win and actual win %

def mad(x):
	df = pd.read_csv("MLB-data.csv")
	df['actual-wl']=df['Wins']/(df['Losses']+df['Wins'])
	df['ratio'] = df['Runs']/df['Opp Runs']
	return np.mean(abs(df['actual-wl']-(df['ratio']**x/(1+(df['ratio']**x)))))

# minimize mad in the range [1, 3]

res = minimize_scalar(mad, bounds = (1,3), method = 'bounded')

print("The exponent that minimizes the mean absolute deviaton/error is: ", str(res.x)) 

