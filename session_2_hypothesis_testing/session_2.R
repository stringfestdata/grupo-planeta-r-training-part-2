# https://rpkgs.datanovia.com/rstatix/

# https://rpkgs.datanovia.com/rstatix/reference/chisq_test.html

install.packages('infer')
library(infer)
browseVignettes('infer')

# https://www.google.com/search?q=statistical+hypothesis+testing+tidyverse+filetype%3Apdf&sca_esv=577175651&sxsrf=AM9HkKnPbPNsflVmG5bYcKdNRE3CQ4HCuA%3A1698415755965&source=hp&ei=i8Q7ZdvVOMmsptQPjbCBiAU&iflsig=AO6bgOgAAAAAZTvSmyHfwquGepJt6fX3NrbXwOkxJa7P&ved=0ahUKEwibx8Des5aCAxVJlokEHQ1YAFEQ4dUDCAw&uact=5&oq=statistical+hypothesis+testing+tidyverse+filetype%3Apdf&gs_lp=Egdnd3Mtd2l6IjVzdGF0aXN0aWNhbCBoeXBvdGhlc2lzIHRlc3RpbmcgdGlkeXZlcnNlIGZpbGV0eXBlOnBkZkiqXlAAWO5bcAp4AJABA5gBwwGgAf42qgEFMTguNDW4AQPIAQD4AQGoAgrCAgQQIxgnwgIOEC4YigUYxwEY0QMYkQLCAg4QABiKBRixAxiDARiRAsICCxAAGIAEGLEDGIMBwgILEC4YgAQYsQMYgwHCAhEQLhiABBixAxiDARjHARjRA8ICBxAjGOoCGCfCAgcQLhjqAhgnwgIHECMYigUYJ8ICFBAuGIoFGLEDGIMBGMcBGNEDGJECwgIIEAAYigUYkQLCAgsQABiKBRixAxiDAcICFBAuGIMBGMcBGLEDGNEDGIoFGJECwgIHEAAYigUYQ8ICCxAAGIoFGLEDGJECwgIREC4YgwEYxwEYsQMY0QMYgATCAgUQABiABMICChAAGIoFGLEDGEPCAg0QLhiKBRixAxiDARhDwgIFEC4YgATCAggQABiABBixA8ICChAAGIAEGBQYhwLCAg0QABiABBgUGIcCGLEDwgIWEC4YgAQYsQMYgwEYxwEY0QMY1AIYCsICBhAAGBYYHsICCBAAGBYYHhgPwgIIEAAYigUYhgPCAgUQIRigAcICBRAhGKsCwgIIECEYFhgeGB3CAgoQIRgWGB4YDxgdwgIHECEYoAEYCg&sclient=gws-wiz#ip=1

## One-sample t-test

# theory-based 
t_test(gss, response = hours, mu = 40)

## Simulation-based 

# Make point estimate

observed_statistic <- gss %>%
  specify(response = hours) %>%
  calculate(stat = "mean")

observed_statistic

# Is the point estimate significantly different than 0?

null_dist_1_sample <- gss %>%
  specify(response = hours) %>%
  hypothesize(null = 'point', mu = 40) %>%
  generate(reps = 1000, type = 'bootstrap') %>%
  calculate(stat = 'mean')


# visualize the null distribution and test statistic
null_dist_1_sample %>%
  visualize() + 
  shade_p_value(observed_statistic,
                direction = "two-sided")


## Two-sample t-test

### Theory-based 

t_test(x = gss, 
       formula = hours ~ college, 
       order = c('degree', 'no degree'))


### Simulation

observed_statistic <- gss %>%
  specify(hours ~ college) %>%
  calculate(stat = "diff in means", order = c("degree", "no degree"))

observed_statistic

null_dist_2_sample <- gss %>%
  specify(hours ~ college) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in means", order = c("degree", "no degree"))


null_dist_2_sample %>%
  visualize() + 
  shade_p_value(observed_statistic,
                direction = "two-sided")

# calculate the p value from the randomization-based null 
# distribution and the observed statistic

p_value_2_sample <- null_dist_2_sample %>%
  get_p_value(obs_stat = observed_statistic,
              direction = "two-sided")

p_value_2_sample



# INSERT EXERCISES HERE

# https://chat.openai.com/share/ee716340-79d9-4d48-b546-679b0e0d7d65


### ANOVA ###


# calculate the observed statistic
observed_f_statistic <- gss %>%
  specify(age ~ partyid) %>%
  hypothesize(null = "independence") %>%
  calculate(stat = "F")

# generate the null distribution using randomization
null_dist <- gss %>%
  specify(age ~ partyid) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "F")


# visualize the null distribution and test statistic!
null_dist %>%
  visualize() + 
  shade_p_value(observed_f_statistic,
                direction = "greater")


# visualize the theoretical null distribution and test statistic!
null_dist_theory <- gss %>%
  specify(age ~ partyid) %>%
  assume(distribution = "F")

visualize(null_dist_theory) +
  shade_p_value(observed_f_statistic,
                direction = "greater")

# visualize both null distributions and the test statistic!
null_dist %>%
  visualize(method = "both") + 
  shade_p_value(observed_f_statistic,
                direction = "greater")


# calculate the p value from the observed statistic and null distribution
p_value <- null_dist %>%
  get_p_value(obs_stat = observed_f_statistic,
              direction = "greater")

p_value


# http://127.0.0.1:29121/library/infer/doc/chi_squared.html


