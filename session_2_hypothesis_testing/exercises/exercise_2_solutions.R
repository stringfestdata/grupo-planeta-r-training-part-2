library(tidyverse)
library(janitor)
library(rstatix)


# 1. One-way ANOVA 
mpg %>% anova_test(hwy ~ class)


# 2. Two-way ANOVA
mpg %>% anova_test(cty ~ class * drv)

# 3. Chi square

view(mpg)

contingency_table <- mpg %>% 
  drop_na() %>% 
  tabyl(manufacturer, drv)
chisq.test(contingency_table)


# 4. Correlation test




# 5. Correlation test and plot 