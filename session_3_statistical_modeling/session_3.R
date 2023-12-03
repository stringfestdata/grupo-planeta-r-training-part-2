# Ch8.4.2 - confidence intervals of Modern Dive

library(tidyverse)
library(moderndive)
library(infer)

# What is average year of US pennies in 2019?

## This data was collected by hand
## by going to the bank
head(pennies_sample)

ggplot(pennies_sample, aes(x = year)) +
  geom_histogram(binwidth = 10)

# Get a point estimate
x_bar <- pennies_sample %>% 
  summarize(mean_year = mean(year))
x_bar

# Resample 50 pennies from our 
# original sample of 50 pennies.
View(pennies_resamples)

dim(pennies_sample)
dim(pennies_resamples)

# What are the resampled means?
resampled_means <- pennies_resamples %>% 
  group_by(name) %>% 
  summarize(mean_year = mean(year))
resampled_means

# Visualize distribution of sample means
ggplot(resampled_means, aes(x = mean_year)) +
  geom_histogram(binwidth = 1) +
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
  geom_histogram(binwidth = 1) +
  labs(x = "Resample mean year")

# Summarize mean of means
virtual_resampled_means %>% 
  summarize(mean_of_means = mean(mean_year))

# Summarize standard error
virtual_resampled_means %>% 
  summarize(SE = sd(mean_year))

### Go back to original dataset and use infer
## Calculate confidence interval ##
pennies_sample %>% 
  specify(response = year) %>% 
  calculate(stat = 'mean')

# Create a bootstrap 
# resample the pennies with replacement 1,000 times
pennies_sample %>% 
  specify(response = year) %>% 
  generate(reps = 1000, type = 'bootstrap')

# Now find the mean
bootstrap_distribution <- pennies_sample %>% 
  specify(response = year) %>% 
  generate(reps = 1000) %>% 
  calculate(stat = 'mean')
bootstrap_distribution

# Find bootstrap confidence range
percentile_ci <- bootstrap_distribution %>% 
  get_confidence_interval(level = 0.95, type = 'percentile')
percentile_ci

visualize(bootstrap_distribution)


visualize(bootstrap_distribution) + 
  shade_confidence_interval(endpoints = percentile_ci)


### Move to regression inference

evals_ch5 <- evals %>%
  select(ID, score, bty_avg, age)
glimpse(evals_ch5)


ggplot(evals_ch5, 
       aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = 'Beauty Score', 
       y = 'Teaching Score',
       title = 'Relationship between teaching 
       and beauty scores') +  
  geom_smooth(method = 'lm', se = FALSE)

# Fit regression model:
score_model <- lm(score ~ bty_avg, data = evals_ch5)

# Get regression table:
get_regression_table(score_model)

# Fit regression model:
score_model <- lm(score ~ bty_avg, data = evals_ch5)

# Get regression points:
## What are these?
regression_points <- get_regression_points(score_model)
regression_points

# Find bootstrap distribution
# for slope

bootstrap_distn_slope <- evals_ch5 %>% 
  specify(formula = score ~ bty_avg) %>%
  generate(reps = 1000, type = 'bootstrap') %>% 
  calculate(stat = 'slope')
bootstrap_distn_slope


# visualize bootstrap
visualize(bootstrap_distn_slope)

# Get confidence interval
percentile_ci <- bootstrap_distn_slope %>% 
  get_confidence_interval(type = 'percentile', level = 0.95)
percentile_ci


# Visualize bootstrap
visualize(bootstrap_distn_slope) + 
  shade_confidence_interval(endpoints = percentile_ci, fill = NULL, 
                            linetype = "solid", color = "grey90")


# Add bootstrap slope 
null_distn_slope <- evals %>% 
  specify(score ~ bty_avg) %>%
  hypothesize(null = 'independence') %>% 
  generate(reps = 1000, type = 'permute') %>% 
  calculate(stat = 'slope')

null_distn_slope

observed_slope <- evals %>% 
  specify(score ~ bty_avg) %>% 
  calculate(stat = 'slope')
observed_slope

# Get p-value

null_distn_slope %>% 
  get_p_value(obs_stat = observed_slope, direction = "both")
