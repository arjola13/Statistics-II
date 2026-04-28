
# =========================
# Complete R Script for Exercises
# =========================

# Load dataset
data <- read.csv("your_dataset.csv")

# -------------------------
# Exercise 1: Exploration
# -------------------------
summary(data$hourly_wage)
mean(data$hourly_wage)
sd(data$hourly_wage)

# -------------------------
# Exercise 2: One-sample t-test
# -------------------------
t_test_result <- t.test(data$hourly_wage, mu = 30)
print(t_test_result)

# -------------------------
# Exercise 3: Confidence Interval
# -------------------------
ci <- t.test(data$hourly_wage)$conf.int
print(ci)

# -------------------------
# Exercise 4: Proportion Test
# -------------------------
# Create binary variable (1 = above threshold, 0 = otherwise)
threshold <- 30
data$above_threshold <- ifelse(data$hourly_wage > threshold, 1, 0)

successes <- sum(data$above_threshold)
total <- nrow(data)

prop_test <- prop.test(successes, total, p = 0.25)
print(prop_test)

# -------------------------
# End of Script
# -------------------------
