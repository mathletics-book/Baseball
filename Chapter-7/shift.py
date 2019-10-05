###########################################################################
### Chapter 7 - Evaluating Fielders                                     ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import numpy as np
from scipy import optimize, optimize.LinearConstraint

df = pd.read_csv("shift.csv")

df['changeDistance'] = [(df['Base'].iloc[i] - 1)*90 + df['distance'].iloc[i] for i in range(len(df))]

## return the negative of the objective function since we want to maximize but the built-in optimization functions are minimizers
def obj(x):
	ffielded = np.array([1 if min([abs(x[k]-df['changeDistance'].iloc[i]) for k in range(4)])<=5 else 0 for i in range(len(df))]).mean()
	return -ffielded

## since our objective function is not smooth we are using differential_evolution
res = optimize.differential_evolution(obj, bounds = [(0,8),(0,180),(0,180),(0,180)])
