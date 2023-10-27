Answer the following questions using the `penguins` dataset from the `palmerpenguins` package in R:


### Exercise 1: Filtering Penguins Based on Bill Length
Filter the penguins dataset to include only those records where `bill_length_mm` is between 40 and 50.

---

### Exercise 2: Mutate & Filter Penguins
Add two new columns to the penguins dataset:
- `small_bill`: TRUE if `bill_length_mm` is less than 40, otherwise FALSE.
- `heavy_body`: TRUE if `body_mass_g` is greater than 4500, otherwise FALSE.

Afterwards, filter the dataset to include only those records where both `small_bill` and `heavy_body` are TRUE.

---

### Exercise 3: Handling Missing Values
Identify how many records in the penguins dataset have a missing value (`NA`) in the `sex` column.

---

### Exercise 4: Ordering Penguins Based on Missing Sex Data
Filter the penguins dataset to include records from the species `Adelie`. Then, arrange the dataset in such a way that records with missing `sex` data appear first, followed by the rest ordered by `bill_length_mm` in ascending order.

---

### Exercise 5: Using the `%in%` operator with Penguins
Check if the string 'adelie' is present in the unique species names of the penguins dataset.

---

### Exercise 6: Filtering Penguins Based on Island
Filter the penguins dataset to include only those records where the `island` value is either 'Dream' or 'Torgersen'.

---

### Exercise 7: Searching for Missing Body Mass Values
Filter the penguins dataset to include only those records where `body_mass_g` is either missing (`NA`) or equal to 4200.

---
