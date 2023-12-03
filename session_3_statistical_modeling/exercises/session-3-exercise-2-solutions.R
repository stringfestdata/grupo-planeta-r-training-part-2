# Load required libraries
library(tidyverse)
library(infer)

# Load the vehicle dataset
# Replace 'path/to/vehicle_data.csv' with the actual path to the dataset
vehicle_data <- read.csv('mpg.csv')

# Fit regression model
fuel_model <- lm(mpg ~ weight, data = vehicle_data)  # Replace 'mpg' and 'weight' with the appropriate column names

# Bootstrap for slope
bootstrap_distn_slope_fuel <- vehicle_data %>%
  specify(formula = mpg ~ weight) %>%  # Replace 'mpg' and 'weight' with the appropriate column names
  generate(reps = 1000, type = 'bootstrap') %>%
  calculate(stat = 'slope')

# Calculate and visualize 95% confidence interval
percentile_ci_slope <- bootstrap_distn_slope_fuel %>%
  get_confidence_interval(level = 0.95, type = 'percentile')
visualize(bootstrap_distn_slope_fuel) +
  shade_confidence_interval(endpoints = percentile_ci_slope)

# Hypothesis testing for slope
observed_slope_fuel <- coef(fuel_model)[2]
p_value_slope <- bootstrap_distn_slope_fuel %>%
  get_p_value(obs_stat = observed_slope_fuel, direction = "both")
