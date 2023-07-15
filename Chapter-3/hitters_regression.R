###########################################################################
### Chapter 3 - Evaluating Hitters by Linear Weights                    ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)
library(stats)
library(car)

df <- read_csv("data_hitters_linear_weights.csv")

# remove the columns that you do not need for the regression; i.e., 'Yr' and 'Tm'
df <- subset(df, select = -c(Yr, Tm))

# create the independent variables
X <- subset(df, select = -R)

# add the constant term
X <- cbind(1, X)

# create the dependent variable
y <- df$R

model <- lm(y ~ ., data = cbind(y, X))

print(summary(model))