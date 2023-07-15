###########################################################################
### Chapter 4 - Evaluating Hitters by Monte Carlo Simulation            ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

print("++++++++ Damn Yankees! Joe Hardy & Monte Carlo ++++++++")

# 0.5 probability of a home run at each plate appearance
# 0.5 probability of an out at each plate appearance

nsim <- as.integer(readline("How many simulations do you want: "))

if (nsim < 10000) {
  cat(" **** A higher number of simulations will provide a more accurate answer ****\n")
}
cat(" **** Don't be afraid I can handle orders of magnitude higher ****\n")

# the following list will keep the number of runs for each inning simulated
nruns <- c()

for (i in 1:nsim) {
  inning_runs <- 0
  inning_outs <- 0
  
  while (inning_outs < 3) {
    if (runif(1) < 0.5) {
      inning_runs <- inning_runs + 1
    } else {
      inning_outs <- inning_outs + 1
    }
  }
  
  nruns <- c(nruns, inning_runs)
}

cat("The average number of runs/inning for a team of Joe Hardys is: ", mean(nruns), "\n")
