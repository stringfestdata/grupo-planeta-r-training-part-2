
# Ensure the 'palmerpenguins' package is installed and loaded
# install.packages('palmerpenguins')
library(palmerpenguins)

# Exercise 1
penguins %>% 
  get_summary_stats(bill_length_mm, bill_depth_mm, type = "common")

# Exercise 2
penguins %>%
  group_by(species) %>% 
  get_summary_stats(flipper_length_mm, type = "mean_sd")

# Exercise 3
head(penguins, 10)

# Exercise 4
penguins %>% t_test(body_mass_g ~ 1, mu = 4500)

# Exercise 5
penguins %>% 
  t_test(body_mass_g ~ species, paired = FALSE)

# Exercise 6
cor(penguins$bill_length_mm, penguins$body_mass_g, use = "complete.obs")

# Exercise 7
ggboxplot(
  penguins, x = "species", y = "body_mass_g", 
  color = "species", palette = "npg"
)
