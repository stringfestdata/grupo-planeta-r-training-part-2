library(tidyverse)
library(janitor)
library(rstatix)

# Read dataset

mpg <- read_csv('mpg.csv')


# 1. Descriptive stats
mpg %>% 
  get_summary_stats(horsepower)

# 2. Grouped summary statistics
mpg %>%
  group_by(origin) %>% 
  get_summary_stats(mpg, type = 'mean_sd')


# 3. One-sample t-test

mpg %>% 
  get_summary_stats(mpg, type = 'mean_sd')

mpg %>% 
  t_test(mpg ~ 1, mu = 25)

# 4. T-test: mpg ~ origin (usa and japan)


mpg_origin_t_test <- mpg %>%
  filter(origin %in% c('usa', 'japan')) %>% 
  t_test(mpg ~ origin, paired = FALSE) 

mpg_origin_t_test


# 5. Boxplot for each origin

p <- ggboxplot(
  mpg %>%
    filter(origin %in% c('usa', 'japan')), x = 'origin', y = 'mpg', 
  color = 'origin', ylim = c(0, 40))

# y_position = where on y-axis does this go?
p + stat_pvalue_manual(mpg_origin_t_test, label = 'p', y.position = 38)
