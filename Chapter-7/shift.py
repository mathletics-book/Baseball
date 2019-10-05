###########################################################################
### Chapter 7 - Evaluating Fielders                                     ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import numpy as np
from scipy.optimize import differential_evolution

df = pd.read_csv("shift.csv")

df['changeDistance'] = [(df['Base'].iloc[i] - 1)*90 + df['distance'].iloc[i] for i in range(len(df))]

## return the negative of the objective function since we want to maximize but the built-in optimization functions are minimizers
def obj(x):
	ffielded = np.array([1 if min([abs(x[k]-df['changeDistance'].iloc[i]) for k in range(4)])<=5 else 0 for i in range(len(df))]).mean()
	return -ffielded

## since our objective function is not smooth we are using differential_evolution
res = differential_evolution(obj, bounds = [(0,8),(0,180),(0,180),(0,180)])

print("The optimal positions are: \n \t",round(res.x[0],2),"\n \t",round(res.x[1],2),"\n \t",round(res.x[2],2),"\n \t",round(res.x[3],2),"\n and the fraction fielded is expected to be: ",round(abs(obj(res.x)),2))
