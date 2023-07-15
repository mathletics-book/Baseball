###########################################################################
### Chapter 13 - Was Tony Perez a Great Clutch Hitter?                  ###
# Mathletics: How Gamblers, Managers, and Sports Enthusiasts              #
# Use Mathematics in Baseball, Basketball, and Football                   #
###########################################################################

library(readr)
library(dplyr)
library(stats)
library(ggplot2)
library(seewave)

dataset <- read_csv("clutch.csv")

model <- lm(WPAPA ~ wOBA, data = dataset)

summary(model)

# calculate the residual standard error 
res_se <- sqrt(deviance(model) / df.residual(model))

dataset$predicted <- predict(model, dataset)
dataset$zscore <- (dataset$WPAPA - dataset$predicted) / res_se

## create a lollipop plot 
ordered_df <- dataset %>% arrange(zscore)
my_range <- seq_along(dataset$zscore)
plt <- ggplot(ordered_df, aes(x = zscore, y = my_range)) +
  geom_segment(aes(x = 0, xend = zscore, y = my_range, yend = my_range), color = "skyblue") +
  geom_point(shape = "o") +
  scale_y_continuous(breaks = seq(0, 146, 5), labels = ordered_df$Name[seq(1, 146, 5)]) +
  xlab("Clutch z-score")
ggsave("clutch_lollipop.png", plot = plt, width = 6, height = 10)

# what is Tony Perez wOBA equivalent considering his clutch hitting? 
# Given the different era for Tony Perez, we use the corresponding coefficients for the model between wOBA and WPA/PA
# For the actual model for that era look at 'Tony Perez New wOBA' worksheet at CLUTCH.XLSX

perez_model <- c(-0.0276, 0.086051)
perez_res_se <- 0.002289844

perez <- read_csv("perez.csv")

perez$predicted <- perez_model[1] + (perez_model[2] * perez$wOBA)
perez$zscore <- (perez$WPAPA - perez$predicted) / res_se

f <- function(x) mean((perez$WPAPA - (perez_model[1] + (perez_model[2] * (perez$wOBA + x)))) / perez_res_se)

result <- uniroot(f, interval = c(-1, 1))
perez_wOBA <- result$root + mean(perez$wOBA)

cat("wOBA of", perez_wOBA, "makes Perez z-score 0\n")
