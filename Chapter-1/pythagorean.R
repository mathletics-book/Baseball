###########################################################################
### Chapter 1 - Pythagorean Theorem in Baseball                         ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)
library(dplyr)
library(stats)
library(tictoc)

df <- read_csv("MLB-data.csv") %>%
  mutate(Opp_Runs = `Opp Runs`)

cat("First we will identify the best exponent in the range [1, 3] that minimizes the mean absolute deviation between the Pythagorean equation predicted and the actual win-loss percentage of an MLB team\n")
cat("Using data from 2005-2016 MLB seasons...\n")
tic()
Sys.sleep(3)

# define the objective function we want to minimize
# this is the sum of the absolute differences between the predicted win and actual win %
mad <- function(x) {
  df <- df %>%
    mutate(actual_wl = Wins / (Losses + Wins),
           ratio = Runs / Opp_Runs)
  mean(abs(df$actual_wl - (df$ratio^x / (1 + df$ratio^x))))
}

# minimize mad in the range [1, 3]
res <- optimize(f = mad, interval = c(1, 3))

toc()
cat("The exponent that minimizes the mean absolute deviation/error is: ", res$minimum, "\n")
