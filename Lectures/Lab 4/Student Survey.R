# Student Survey Analysis in R
library(haven)      # for reading .sav
library(tidyverse)

df <- read_sav("/Users/arjolaarapi-gjini/Desktop/survey.sav")

# 1. Summary statistics
summary(df[c("life_satisfaction", "expected_income", "age", "sports_weekly")])

# Frequencies for categorical
table(df$gender)
table(df$cannabis_use)

# Group means by gender
df %>% 
  group_by(gender) %>% 
  summarise(
    mean_life_sat = mean(life_satisfaction, na.rm = TRUE),
    mean_exp_income = mean(expected_income, na.rm = TRUE),
    n = n()
  )

# Hypothesis 1: One-sample t-test (expected_income == 750)
t.test(df$expected_income, mu = 750)

# Hypothesis 2: One-tailed t-test (males > females on life_satisfaction)
# Change the order if your coding is different (e.g. if 1=Female)
t.test(life_satisfaction ~ gender, data = df, 
       alternative = "greater", var.equal = FALSE)

# Two correlations
cor.test(df$life_satisfaction, df$expected_income, method = "pearson")
cor.test(df$life_satisfaction, df$age, method = "pearson")

# Optional boxplot by gender
boxplot(life_satisfaction ~ gender, data = df, 
        main = "Life Satisfaction by Gender")