library(tidyverse)
library(nycflights13)
library(ggrepel)

# Tools > Global Options > 
# Code > native pipe operator

flights |>
  filter(dep_time > 600 & dep_time < 2000 & abs(arr_delay) < 20)


flights |>
  mutate(
    daytime = dep_time > 600 & dep_time < 2000,
    approx_ontime = abs(arr_delay) < 20,
    .keep = "used"
  )

# Missing values = NA

is.na(c(TRUE, FALSE, TRUE, NA))

# filter missing values

flights |>
  filter(is.na(dep_time))

# override placing na's at the end of filter:

flights |>
  filter(month == 1, day == 1) |>
  arrange(desc(is.na(dep_time)), dep_time)

# %in% operator - is x in y?

'r' %in% c('time', 'to', 'learn', 'r')

# letters is a vector
letters %in% 'r'

# Find all flights in Nov/Dec
flights |>
  filter(month %in% c(11, 12))

# Can also search for missing values like this
flights |>
  filter(dep_time %in% c(NA, 0800))


# recoding values

my_if_else <- c(-3:3, NA)

case_when(
  my_if_else == 0 ~ '0',
  my_if_else < 0 ~ 'minus',
  my_if_else > 0 ~ 'plus'
)

# NA's are treated differently 

case_when(
  my_if_else == 0 ~ '0',
  my_if_else < 0 ~ 'minus',
  my_if_else > 0 ~ 'plus', 
  is.na(my_if_else) ~ '???'
)

# Recode/bin arrival delay

flights |>
  mutate(
    status = case_when(
      is.na(arr_delay) ~ "cancelled",
      arr_delay < -30 ~ "very early",
      arr_delay < -15 ~ "early",
      abs(arr_delay) <= 15 ~ "on time",
      arr_delay < 60 ~ "late",
      arr_delay < Inf ~ "very late",
    ),
    .keep = "used"
  )



### Data visualization with ggplot2 ###


ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, shape = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, size = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) +
  geom_point()

# Color doesn't say anything about the aesthetic mappings 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")


# Different geometry for different points

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_point(
    data = mpg |> filter(class == "2seater"),
    color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"),
    shape = "circle open", size = 3, color = "red"
  )

# Facet plots -- small multiples

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~cyl)


# bivariate facet grid

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl)

# Spot outliers

potential_outliers <- mpg |>
  filter(hwy > 40 | (hwy > 20 & displ > 5))

# geom_text_repel() comes from ggrepel package
# helps us highlight certain points on a plot 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_text_repel(data = potential_outliers, aes(label = model)) +
  geom_point(data = potential_outliers, color = "red") +
  geom_point(
    data = potential_outliers,
    color = "red", size = 3, shape = "circle open"
  )

# Custom themes

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_minimal()




