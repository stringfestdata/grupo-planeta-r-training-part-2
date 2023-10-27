
# Solutions for Penguins Dataset Visualization Exercises

# Load necessary libraries
library(ggplot2)
library(palmerpenguins)

# 1. Basic Plotting
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point()

# 2. Using Different Shapes
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, shape = island)) +
  geom_point()

# 3. Using Size Aesthetic
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, size = body_mass_g)) +
  geom_point()

# 4. Highlighting Specific Species
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_point(
    data = subset(penguins, species == "Adelie"),
    color = "red"
  )

# 5. Facet Plots
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  facet_wrap(~island)

# 6. Highlighting Outliers
outliers <- subset(penguins, bill_length_mm > 50 & bill_depth_mm < 15)
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_point(data = outliers, color = "red")

# 7. Custom Themes
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() +
  theme_minimal()
