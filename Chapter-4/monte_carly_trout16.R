###########################################################################
### Chapter 4 - Evaluating Hitters by Monte Carlo Simulation            ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)
library(dplyr)

probs <- read_csv("Trout2016_probs.csv")

# we create a list that keeps the probability sum of the events up to the corresponding element
# this will help us decide which event happened when we draw the random number during the Monte Carlo simulation

probs_cumsum <- cumsum(probs$Probability)

runs <- read_csv("runs.csv")
outs <- read_csv("outs.csv")
state_transitions <- read_csv("state_transitions.csv", col_types = cols())

nsim <- as.integer(readline("How many simulations do you want: "))

if (nsim < 10000) {
  cat(" **** A higher number of simulations will provide a more accurate answer ****\n")
  cat(" **** Don't be afraid I can handle orders of magnitude higher ****\n")
}

nruns <- c()

for (i in 1:nsim) {
  inning_state <- '000'
  inning_outs <- 0
  inning_runs <- 0
  
  while (inning_outs < 3) {
    # first let's find what event happened
    coin_flip <- runif(1)
    event <- ifelse(coin_flip < probs_cumsum[1], 1,
                    match(TRUE, coin_flip >= probs_cumsum[-length(probs_cumsum)] &
                            coin_flip < probs_cumsum[-1]) + 1)
    
    # find how many runs happened
    inning_runs <- inning_runs + runs[[paste0(inning_state, '-', inning_outs)]][event]
    
    # find how many outs were added
    inning_outs <- inning_outs + outs[[paste0(inning_state, '-', inning_outs)]][event]
    
    # find the new state
    inning_state <- as.character(state_transitions[[inning_state]][event])
  }
  
  nruns <- c(nruns, inning_runs)
}

cat("The average number of runs/inning for a team of Mike Trouts is: ", mean(nruns), "\n")

