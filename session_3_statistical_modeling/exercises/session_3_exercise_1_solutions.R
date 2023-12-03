# Load libraries
library(tidyverse)
library(infer)

# Question 1: Data Exploration
heights <- read.csv("heights.csv")
head(heights)

# Question 2: Point Estimate
mean_height_women <- mean(heights$Height_Women)
mean_height_women

# Question 3: Histogram
ggplot(heights, aes(x = Height_Women)) +
  geom_histogram(binwidth = 1)

# Question 4: Resampling
set.seed(123)
women_resample <- sample(heights$Height_Women, 100, replace = TRUE)
dim(heights)
length(women_resample)

# Question 5: Resampled Means
resampled_means <- replicate(100, mean(sample(heights$Height_Women, 100, replace = TRUE)))
ggplot(data.frame(Resampled_Mean = resampled_means), aes(x = Resampled_Mean)) +
  geom_histogram(binwidth = 1)

# Question 6: Bootstrap Resampling
bootstrap_resamples <- replicate(50, sample(heights$Height_Women, size = nrow(heights), replace = TRUE))
bootstrap_means <- apply(bootstrap_resamples, 2, mean)

# Question 7: Analysis of Resampled Data
ggplot(data.frame(Bootstrap_Means = bootstrap_means), aes(x = Bootstrap_Means)) +
  geom_histogram(binwidth = 1)
mean(bootstrap_means)
sd(bootstrap_means)

# Question 8: Confidence Interval
conf_interval <- quantile(bootstrap_means, c(0.025, 0.975))
conf_interval
