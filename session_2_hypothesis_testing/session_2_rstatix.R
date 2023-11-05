library(rstatix)
install.packages('ggpubr')
library(ggpubr)

# https://rpkgs.datanovia.com/rstatix/

iris %>% 
  get_summary_stats(Sepal.Length, Sepal.Width, type = "common")

iris %>%
  group_by(Species) %>% 
  get_summary_stats(Sepal.Length, type = "mean_sd")

df <- ToothGrowth
df$dose <- as.factor(df$dose)
head(df)


df %>% t_test(len ~ 1, mu = 0)

df %>% 
  group_by(dose) %>%
  t_test(len ~ 1, mu = 0)


stat.test <- df %>% 
  t_test(len ~ supp, paired = FALSE) 

p <- ggboxplot(
  df, x = "supp", y = "len", 
  color = "supp", palette = "jco", ylim = c(0,40)
)


p + stat_pvalue_manual(stat.test, label = "p", y.position = 35)


### Paired sample

stat.test <- df %>% 
  t_test(len ~ supp, paired = TRUE) 
stat.test

p <- ggpaired(
  df, x = "supp", y = "len", color = "supp", palette = "jco", 
  line.color = "gray", line.size = 0.4, ylim = c(0, 40)
)
p + stat_pvalue_manual(stat.test, label = "p", y.position = 36)

## One way ANOVA

df %>% anova_test(len ~ dose)

## Two way ANOVA

df %>% anova_test(len ~ supp*dose)

## Correlation test

mydata <- mtcars %>% 
  select(mpg, disp, hp, drat, wt, qsec)

# Correlation test between two variables
mydata %>% cor_test(wt, mpg, method = "pearson")

# Correlation of one variable against all
mydata %>% cor_test(mpg, method = "pearson")


# Pairwise correlation test between all variables
mydata %>% cor_test(method = "pearson")

cor.mat <- mydata %>% cor_mat()
cor.mat


cor.mat %>%
  cor_reorder() %>%
  pull_lower_triangle() %>% 
  cor_plot()
