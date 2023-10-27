
# Load the required libraries
library(palmerpenguins)
library(tidyverse)

# 1. Filtering Penguins Based on Body Mass
filtered_penguins <- penguins |>
  filter(body_mass_g > 4000 & body_mass_g < 5000)

# 2. Mutate Penguins with Logical Columns
mutated_penguins <- penguins |>
  mutate(
    medium_bill = bill_length_mm > 40 & bill_length_mm < 45,
    is_dream_island = island == 'Dream',
    .keep = "used"
  )

# 3. Handling Missing Values in Island Column
na_island_penguins <- penguins |>
  filter(is.na(island))

# 4. Ordering Penguins Based on Missing Body Mass Data
ordered_penguins <- penguins |>
  filter(species == 'Adelie') |>
  arrange(desc(is.na(body_mass_g)), body_mass_g)

# 5. Using the `%in%` operator with Penguin Islands
island_filtered_penguins <- penguins |>
  filter(island %in% c('Dream', 'Torgersen'))
