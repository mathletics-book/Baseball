###########################################################################
### Chapter 11 - Streakiness in Sports                                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)
library(dplyr)
library(knitr)

game_shots <- read_csv("westbrook_shots.csv")

westbrook_fgp <- sum(game_shots$FG) / sum(game_shots$FGA)

makes <- rep(0, 10000)
shots <- rep(0, 10000)
miss_after_three_makes <- rep(0, 10000)
miss_after_three_misses <- rep(0, 10000)
make_after_three_makes <- rep(0, 10000)
make_after_three_misses <- rep(0, 10000)

for (b in 1:10000) {
  for (i in 1:nrow(game_shots)) {
    s <- rbinom(game_shots$FGA[i], 1, westbrook_fgp)
    makes[b] <- makes[b] + sum(s)
    shots[b] <- shots[b] + length(s)
    
    for (k in 1:(length(s) - 3)) {
      if (identical(s[k:(k+2)], c(1, 1, 1))) {
        if (!is.na(s[k + 4])) {
          if (s[k + 4] == 1) {
            make_after_three_makes[b] <- make_after_three_makes[b] + 1
          } else {
            miss_after_three_makes[b] <- miss_after_three_makes[b] + 1
          }
        }
      }
      
      if (identical(s[k:(k+2)], c(0, 0, 0))) {
        if (!is.na(s[k + 4])) {
          if (s[k + 4] == 1) {
            make_after_three_misses[b] <- make_after_three_misses[b] + 1
          } else {
            miss_after_three_misses[b] <- miss_after_three_misses[b] + 1
          }
        }
      }
    }
  }
}

results_after_three_makes <- data.frame(
  'Shots Made' = mean(makes),
  'Shots Misses' = mean(shots) - mean(makes),
  'actual percentage' = mean(makes) / mean(shots),
  'Made after 3 makes' = mean(make_after_three_makes),
  'Misses after 3 makes' = mean(miss_after_three_makes),
  'percentage after 3 makes' = mean(make_after_three_makes) / (mean(make_after_three_makes) + mean(miss_after_three_makes))
)

results_after_three_misses <- data.frame(
  'Shots Made' = mean(makes),
  'Shots Misses' = mean(shots) - mean(makes),
  'actual percentage' = mean(makes) / mean(shots),
  'Made after 3 misses' = mean(make_after_three_misses),
  'Misses after 3 misses' = mean(miss_after_three_misses),
  'percentage after 3 misses' = mean(make_after_three_misses) / (mean(make_after_three_misses) + mean(miss_after_three_misses))
)

print(results_after_three_makes)
print(results_after_three_misses)

