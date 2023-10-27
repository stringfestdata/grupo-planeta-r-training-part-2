library(tidyverse)
library(nycflights13)

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

### Exercises: 

### Exercise solutions: 
