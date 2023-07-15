###########################################################################
### Chapter 6 - Baseball Decision Making                                ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

xRuns <- read.csv("xRuns.csv")
transs <- list()
transf <- list()

trans <- readLines("transitionStates.csv")

for (line in trans) {
  linef <- strsplit(line, ",")[[1]]
  
  if (linef[3] == "s") {
    transs[[linef[1]]] <- linef[2]
  } else {
    transf[[linef[1]]] <- linef[2]
  }
}

cat("This demo will give you a break even probability of stealing a base for each situation you input.\n")
cat("Assumptions:\n")
cat("1. The more advanced runner only attempts to steal a base\n")
cat("2. We do not consider situations where the third base is loaded\n\n")

cat("Which bases are loaded? Enter a 3-character binary string for the three bases.")
cat("(e.g., 010 if there is a runner on second base and none on first and third)")

state <- readline("Which bases are loaded? : ")

outs <- as.integer(readline("How many outs?: "))

while (!(state %in% c("010", "100", "110")) || outs > 2 || outs < 0) {
  cat("Wrong input!! Try again\n")
  state <- readline("Which bases are loaded?: ")
  outs <- as.integer(readline("How many outs?: "))
}

SQ <- xRuns[outs, strtoi(state, base = 2)]

# if the steal is successful we advance one base with the same outs
S <- xRuns[outs, strtoi(transs[[state]], 2)]

F <- 0
if (exists(transf[[state]])) {
  F <- xRuns[(outs + 1), strtoi(transf[[state]], 2)]
}

P <- (SQ - F) / (S - F)

cat("The break even probability is: ", P, "\n")
