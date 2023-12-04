library(tidyverse)
library(rstatix)
library(ggpubr)
library(janitor)


# 1. One-way ANOVA 
mpg %>% anova_test(mpg ~ origin)


# 2. Chi-square
mpg %>% 
  tabyl(cylinders, origin) %>% 
  chisq.test()

# 3. Correlation test

mpg %>% 
  cor_test(displacement, mpg, method = 'pearson')



# 4. Pairwise correlation

mpg_select <- mpg %>% 
  select(displacement, horsepower, weight)

mpg_select %>% cor_test(method = 'pearson')


# 5. Correlation plot

mpg_corr <- mpg_select %>% cor_mat()
mpg_corr %>%
  cor_reorder() %>%
  pull_lower_triangle() %>% 
  cor_plot()
