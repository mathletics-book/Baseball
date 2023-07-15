###########################################################################
### Chapter 17 - Projecting Major League Performance                    ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)

# these are the weights for each one of the 3 past years for HR rates and PA- earlier first, so recent years are weighted more
weights <- c(3, 4, 5)
weights_pa <- c(0, 0.1, 0.5)

# age adjustment 
player_age <- 31

if (player_age < 29) {
  player_adj <- 0.006 * (29 - player_age)
} else {
  player_adj <- -0.003 * (player_age - 29)
}

## Steps 1 - 2 
player_data <- read_csv("marcel.csv")

## Step 3
player_data$player_rate <- player_data$HR / player_data$PA

## Step 4
player_wavg <- sum(player_data$PA * player_data$player_rate * weights) / sum(player_data$PA * weights)
## Step 5
league_wavg <- sum(player_data$PA * player_data$LeagueAvgR * weights) / sum(player_data$PA * weights)
## Step 6
playerw <- sum(player_data$PA * weights) / (sum(player_data$PA * weights) + 1200)
leaguew <- 1 - playerw
## Step 7
pred_playerHRprob <- (player_wavg * playerw) + (league_wavg * leaguew)
pred_playerPA <- 200 + sum(player_data$PA * weights_pa)
## Step 8
predicted_playerHR <- pred_playerPA * pred_playerHRprob
## Step 9
predicted_playerHR_age_adjusted <- (1 + player_adj) * predicted_playerHR

cat("This player's predicted HRs for next season is:", predicted_playerHR_age_adjusted, "\n")
