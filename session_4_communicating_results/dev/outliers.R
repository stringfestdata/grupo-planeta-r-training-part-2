# https://www.statology.org/how-to-identify-influential-data-points-using-cooks-distance/
library(ggplot2)
library(gridExtra)

#create data frame with no outliers
no_outliers <- data.frame(x = c(1, 2, 2, 3, 4, 5, 7, 3, 2, 12, 11, 15, 14, 17, 22),
                          y = c(22, 23, 24, 23, 19, 34, 35, 36, 36, 34, 32, 38, 41,
                                42, 44))

#create data frame with two outliers
outliers <- data.frame(x = c(1, 2, 2, 3, 4, 5, 7, 3, 2, 12, 11, 15, 14, 17, 22),
                       y = c(190, 23, 24, 23, 19, 34, 35, 36, 36, 34, 32, 38, 41,
                             42, 180))

#create scatterplot for data frame with no outliers
no_outliers_plot <- ggplot(data = no_outliers, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = lm) +
  ylim(0, 200) +
  ggtitle("No Outliers")

#create scatterplot for data frame with outliers
outliers_plot <- ggplot(data = outliers, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = lm) +
  ylim(0, 200) +
  ggtitle("With Outliers")

#plot the two scatterplots side by side
gridExtra::grid.arrange(no_outliers_plot, outliers_plot, ncol=2)