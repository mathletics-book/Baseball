###########################################################################
### Chapter 7 - Evaluating Fielders                                     ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)
library(dplyr)

df <- read_csv("shift.csv")

df <- df %>%
  mutate(changeDistance = (Base - 1) * 90 + distance)

# Define the objective function
# Return the negative of the objective function since we want to maximize,
# but the built-in optimization functions in R are minimizers
obj <- function(x) {
  ffielded <- mean(ifelse(sapply(df$changeDistance, function(k) min(abs(x - k)) <= 5), 1, 0))
  return(-ffielded)
}

# Use the optim function for optimization
res <- optim(par = c(0, 0, 0, 0), fn = obj, method = "Nelder-Mead")

cat("The optimal positions are:\n")
cat(paste("\t", round(res$par[1], 2), "\n"))
cat(paste("\t", round(res$par[2], 2), "\n"))
cat(paste("\t", round(res$par[3], 2), "\n"))
cat(paste("\t", round(res$par[4], 2), "\n"))
cat("and the fraction fielded is expected to be:", round(abs(obj(res$par)), 2), "\n")

