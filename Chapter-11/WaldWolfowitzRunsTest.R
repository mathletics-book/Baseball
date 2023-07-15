###########################################################################
### Chapter 11 - Streakiness in Sports                                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

# this is an implementation of WWRT

find_runs <- function(seq) {
  return(1 + sum(ifelse(seq[-length(seq)] != seq[-1], 1, 0)))
}

WWRT <- function(seq) {
  s <- sum(seq)
  f <- length(seq) - s
  mu <- ((2 * s * f) / (s + f)) + 1
  sigma <- sqrt((mu - 1) * (mu - 2) / (s + f - 1))
  return((find_runs(seq) - mu) / sigma)
}

# Two sequences for illustrative purposes
seq1 <- c(0,1,0,0,1,1,1,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,0,1,0)
seq2 <- c(0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0)

cat("Sequence:", paste(seq1, collapse = ", "), "has a WWRT z-score of:", WWRT(seq1), "\n")
cat("Sequence:", paste(seq2, collapse = ", "), "has a WWRT z-score of:", WWRT(seq2), "\n")


