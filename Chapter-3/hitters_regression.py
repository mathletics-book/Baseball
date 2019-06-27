###########################################################################
### Chapter 3 - Evaluating Hitters by Linear Weights                    ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

import pandas as pd
import statsmodels.api as sm

df = pd.read_csv("data_hitters_linear_weights.csv")

# remove the columns that you do not need for the regression; i.e., 'Yr' and 'Tm'

df = df.drop(['Yr', 'Tm'], axis = 1) 

# create the independent variables
X = df.loc[:, df.columns != 'R']
# add the constant term 
X = sm.add_constant(X)
# create the dependent variable
y = pd.DataFrame(df['R'])

model = sm.OLS(y, X).fit()

print(model.summary())
