
# Penguins Dataset Exercises

Using the `palmerpenguins` dataset, perform the following operations:

1. **Filtering Penguins Based on Body Mass**
   
   Filter the penguins dataset to include only those records where `body_mass_g` is greater than 4000 but less than 5000.

2. **Mutate Penguins with Logical Columns**
   
   Add two new columns to the penguins dataset:
   - `medium_bill`: TRUE if `bill_length_mm` is greater than 40 and less than 45, otherwise FALSE.
   - `is_dream_island`: TRUE if the penguin is from the 'Dream' island, otherwise FALSE.
   
   Afterwards, filter the dataset to only show these two new columns.

3. **Handling Missing Values in Island Column**
   
   Filter the penguins dataset to include only records that have a missing value (`NA`) in the `island` column.

4. **Ordering Penguins Based on Missing Body Mass Data**
   
   Filter the penguins dataset to include only records from the species `Adelie`. Then, arrange the dataset so that records with missing `body_mass_g` data appear first, followed by the rest in ascending order based on `body_mass_g`.

5. **Using the `%in%` operator with Penguin Islands**
   
   Filter the penguins dataset to include only those records where the `island` value is either 'Dream' or 'Torgersen`.
