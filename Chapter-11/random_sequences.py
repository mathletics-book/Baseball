###########################################################################
### Chapter 11 - Streakiness in Sports                                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import numpy as np
import matplotlib.pyplot as plt
import random
from itertools import groupby

## helper functions for calculating the largest winning streak for a sequence of wins-loses

def len_iter(items):
	return sum(1 for _ in items)

def consecutive_wins(data):
	if sum(data) == 0:
		return 0
	else:
		return max(len_iter(run) for val, run in groupby(data) if val)


# we will generate 10000 win-loss sequences of length 160 games, where the probability of winning each game is 0.6
# for each sequence we will calculate the longest winning streak

threshold = 0.4
win_streaks = []

for s in range(10000):
	sequence = [round(random.random()-threshold+0.5) for _ in range(160)]
	win_streaks.append(consecutive_wins(sequence))

bins = np.arange(0, max(win_streaks) + 1.5) - 0.5

fig, ax = plt.subplots()
_ = ax.hist(win_streaks, bins,density=True)
ax.set_xticks(bins + 0.5)
plt.xlabel("Largest Win Streak")
plt.ylabel("Probability")
plt.savefig("largest_win_streaks.png")

