###########################################################################
### Chapter 13 - Was Tony Perez a Great Clutch Hitter?                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import numpy as np
from statsmodels.formula.api import ols
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.optimize import fsolve

dataset = pd.read_csv("clutch.csv")


model = ols('WPAPA ~ wOBA', data = dataset).fit()

model.summary()

# calculate the residual standard error 
res_se = np.sqrt(model.scale)

dataset['predicted'] = model.predict(dataset)
dataset['zscore'] = (dataset['WPAPA']-dataset['predicted'])/res_se

## create a lollipop plot 
ordered_df = dataset.sort_values(by='zscore')
my_range=range(1,len(dataset.index)+1)
plt.hlines(y=my_range, xmin=0, xmax=ordered_df['zscore'], color='skyblue')
plt.plot(ordered_df['zscore'], my_range, "o")
## we will not show the names of all the players for visibility
plt.yticks([i for i in range(0,146,5)], [ordered_df['Name'].iloc[i] for i in range(0,146,5)])
plt.xlabel('Clutch z-score')
plt.savefig("clutch_lollipop.png")


# what is Tony Perez wOBA equivalent considering his clutch hitting? 
# Given the different era for Tony Perez, we use the corresponding coefficients for the model between wOBA and WPA/PA
# For the actual model for that era look at 'Tony Perez New wOBA' worksheet at CLUTCH.XLSX

perez_model = [-0.0276, 0.086051]
perez_res_se = 0.002289844

perez = pd.read_csv("perez.csv")
perez['predicted'] = perez_model[0] + (perez_model[1]*perez['wOBA'])
perez['zscore'] = (perez['WPAPA']-perez['predicted'])/res_se

f = lambda x: np.mean((perez['WPAPA']-(perez_model[0] + (perez_model[1]*(perez['wOBA']+x))))/perez_res_se)

print('wOBA of ', fsolve(f,0)[0]+np.mean(perez['wOBA']),' makes Perez z-score 0')
