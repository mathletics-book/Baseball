###########################################################################
### Chapter 11 - Streakiness in Sports                                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import numpy as np
import pandas as pd
from tabulate import tabulate

game_shots = pd.read_csv("westbrook_shots.csv")

westbrook_fgp = sum(game_shots.FG)/sum(game_shots.FGA)

# simulate every game 
makes = list(np.zeros(10000))
shots = list(np.zeros(10000))
miss_after_three_makes = list(np.zeros(10000))
miss_after_three_misses = list(np.zeros(10000))
make_after_three_makes = list(np.zeros(10000))
make_after_three_misses = list(np.zeros(10000))

for b in range(10000):
	for i in range(len(game_shots)):
		s = [np.random.binomial(1,westbrook_fgp) for _ in range(game_shots['FGA'].iloc[i])]
		makes[b] += sum(s)
		shots[b] += len(s)
		for k in range(len(s)-3):
			if s[k:k+3] == [1,1,1]:
				try:
					if s[k+4] == 1:
						make_after_three_makes[b] += 1
					else:
						miss_after_three_makes[b] += 1
				except IndexError:
					# in this case the 4th shot of the sequence was not realized in the dataset. I.e., the simulation of the game finished with three makes, so we cannot use this observation.
					pass
			if s[k:k+3] == [0,0,0]:	
				try:
					if s[k+4] == 1:
						make_after_three_misses[b] += 1
					else:
						miss_after_three_misses[b] += 1
				except IndexError:
					# in this case the 4th shot of the sequence was not realized in the dataset. I.e., the simulation of the game finished with three misses, so we cannot use this observation. 
					pass


print(tabulate([[np.mean(makes),np.mean(shots)-np.mean(makes),np.mean(makes)/np.mean(shots),np.mean(make_after_three_makes),np.mean(miss_after_three_makes),np.mean(make_after_three_makes)/(np.mean(make_after_three_makes)+np.mean(miss_after_three_makes))]], headers=['Shots Made','Shots Misses','actual percentage','Made after 3 makes','Misses after 3 makes','percentage after 3 makes'], tablefmt='orgtbl'))
print(tabulate([[np.mean(makes),np.mean(shots)-np.mean(makes),np.mean(makes)/np.mean(shots),np.mean(make_after_three_misses),np.mean(miss_after_three_misses),np.mean(make_after_three_misses)/(np.mean(make_after_three_misses)+np.mean(miss_after_three_misses))]], headers=['Shots Made','Shots Misses','actual percentage','Made after 3 misses','Misses after 3 misses','percentage after 3 misses'], tablefmt='orgtbl'))
