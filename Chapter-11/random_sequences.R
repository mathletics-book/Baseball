###########################################################################
### Chapter 11 - Streakiness in Sports                                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

consecutive_wins <- function(data) {
  if (sum(data) == 0) {
    return(0)
  } else {
    run_lengths <- rle(data)$lengths
    return(max(run_lengths[rle(data)$values == 1]))
  }
}

threshold <- 0.4
win_streaks <- c()

for (s in 1:10000) {
  sequence <- round(runif(160) - threshold + 0.5)
  win_streaks <- c(win_streaks, consecutive_wins(sequence))
}

bins <- seq(0, max(win_streaks) + 1.5) - 0.5

histogram <- hist(win_streaks, breaks = bins, plot = FALSE)
density <- histogram$density
midpoints <- histogram$mids

plot(midpoints, density, type = "h", lwd = 10, xlab = "Largest Win Streak",
     ylab = "Probability", main = "Distribution of Largest Win Streaks")

