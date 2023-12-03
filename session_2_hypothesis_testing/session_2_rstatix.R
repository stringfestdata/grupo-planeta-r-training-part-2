library(tidyverse)
library(palmerpenguins)
library(rstatix)
library(ggpubr)
library(janitor)

# Convert to "tidyverse-friendly" tibble
tooth_growth <- as_tibble(ToothGrowth)



# Pull summary stats "tidy" style
tooth_growth %>% 
  get_summary_stats()

# What can this function do for us?

?get_summary_stats

names(tooth_growth)

# Get grouped summary stats
tooth_growth %>%
  group_by(supp) %>% 
  get_summary_stats(dose, type = 'mean_sd')


# Is the overall length 
# statistically different than 1?
tooth_growth %>% t_test(len ~ 1, mu = 0)

# Is the length for each dose significantly different 
# than 1?
tooth_growth %>% 
  group_by(dose) %>%
  t_test(len ~ 1, mu = 0)


# Is there a relationship between len and supp? 
len_supp_t_test <- tooth_growth %>% 
  t_test(len ~ supp, paired = FALSE) 

len_supp_t_test

# Visualize results with paired boxplot
p <- ggboxplot(
  tooth_growth, x = 'supp', y = 'len', 
  color = 'supp', ylim = c(0, 40))

# y_position = where on y-axis does this go?
p + stat_pvalue_manual(len_supp_t_test, label = 'p', y.position = 35)

## Paired sample t-test on sleep dataset
### Try exploring this dataset on your own

sleep %>% 
  group_by(group) %>% 
  get_summary_stats()


# Paired sample t-test
## Read in relevant dataset

tomography <- read_csv('https://raw.githubusercontent.com/stringfestdata/training-assets/master/datasets/tomography.csv')
tomography

tomography_paired <- tomography %>% 
  t_test(volume ~ period, paired = TRUE) 

tomography_paired

## Visualize results of paired sample t-test

p <- ggpaired(
  tomography, x = 'period', y = 'volume',
  color = 'period', ylim = c(0, 8000))

p + stat_pvalue_manual(tomography_paired, label = 'p', y.position = 7500)


### Head to exercises ###


## Back to tooth_growth
# One way ANOVA

tooth_growth %>% anova_test(len ~ dose)

## Visualizing multi-pairwise:
### https://rpkgs.datanovia.com/rstatix/

# https://raw.githubusercontent.com/mwaskom/seaborn-data/master/mpg.csv

# Two way ANOVA

tooth_growth %>% anova_test(len ~ supp * dose)


# Chi square
## Use the penguins dataset 
### Use the tabyl function to get frequencies

data('penguins')

penguins %>% 
  drop_na()%>% 
  tabyl(island, sex) %>% 
  chisq.test()

## Correlation test
names(penguins)

penguins_select <- penguins %>% 
  select(bill_length_mm,
         bill_depth_mm,
         flipper_length_mm,
         body_mass_g
         )

# Correlation test between two variables
penguins_select %>% cor_test(flipper_length_mm, body_mass_g, method = "pearson")

# Correlation of one variable against all
penguins_select %>% cor_test(body_mass_g, method = "pearson")


# Pairwise correlation test between all variables
penguins_select %>% cor_test(method = 'pearson')


# Correlation plot

penguins_corr <- penguins_select %>% cor_mat()
penguins_corr

# Confirm this works on a larger screen
penguins_corr %>%
  cor_reorder() %>%
  pull_lower_triangle() %>% 
  cor_plot()
