# start around 8.4.2

# Ch8 - confidence intervals of Modern Dive
## just go straight to the part about INFER 

library(tidyverse)
library(moderndive)
library(infer)

# What is average year of US pennies in 2019?

ggplot(pennies_sample, aes(x = year)) +
  geom_histogram(binwidth = 10, color = "white")

x_bar <- pennies_sample %>% 
  summarize(mean_year = mean(year))
x_bar

# Resampled data
pennies_resamples

dim(pennies_resamples)

# What are the resampled means?
resampled_means <- pennies_resamples %>% 
  group_by(name) %>% 
  summarize(mean_year = mean(year))
resampled_means

ggplot(resampled_means, aes(x = mean_year)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1990) +
  labs(x = "Sampled mean year")

# Bootstrap resampling with replacement

# Computational resampling

virtual_resample <- pennies_sample %>% 
  rep_sample_n(size = 50, replace = TRUE)

# Find the average year

virtual_resample %>% 
  summarize(resample_mean = mean(year))

# Virtually resample 35 times
virtual_resamples <- pennies_sample %>% 
  rep_sample_n(size = 50, replace = TRUE, reps = 35)
virtual_resamples

# Check each individual sample mean
virtual_resampled_means <- virtual_resamples %>% 
  group_by(replicate) %>% 
  summarize(mean_year = mean(year))
virtual_resampled_means


# Plot this as a histogram
ggplot(virtual_resampled_means, aes(x = mean_year)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1990) +
  labs(x = "Resample mean year")

# Combine these together
virtual_resampled_means <- pennies_sample %>% 
  rep_sample_n(size = 50, replace = TRUE, reps = 1000) %>% 
  group_by(replicate) %>% 
  summarize(mean_year = mean(year))
virtual_resampled_means

# Summarize mean of means
virtual_resampled_means %>% 
  summarize(mean_of_means = mean(mean_year))

# Summarize standard error
virtual_resampled_means %>% 
  summarize(SE = sd(mean_year))

## Calculate confidence interval ##

pennies_sample %>% 
  specify(response = year) %>% 
  calculate(stat = "mean")

pennies_sample %>% 
  specify(response = year)

pennies_sample %>% 
  specify(response = year) %>% 
  generate(reps = 1000, type = "bootstrap")


bootstrap_distribution <- pennies_sample %>% 
  specify(response = year) %>% 
  generate(reps = 1000) %>% 
  calculate(stat = "mean")
bootstrap_distribution


percentile_ci <- bootstrap_distribution %>% 
  get_confidence_interval(level = 0.95, type = "percentile")
percentile_ci

visualize(bootstrap_distribution)


visualize(bootstrap_distribution) + 
  shade_confidence_interval(endpoints = percentile_ci)

