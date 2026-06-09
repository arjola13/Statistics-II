## Rscript: Housing Data/Descriptives/Visuals and CI

# =========================
# 1. SETUP
# =========================
install.packages(tidyverse)
library(tidyverse)

# =========================
# 2. LOAD DATA
# =========================

df <- read.csv("C:/Users/Student/Downloads/king_country_houses.csv")


# Quick look
head(df)
str(df) # check the structure of the data
summary(df) # summary statistics

# =========================
# 3. BASIC DESCRIPTIVES (PRICE)
# =========================

mean(df$price)
median(df$price)
sd(df$price)

quantile(df$price, probs = c(0.25, 0.5, 0.75))

# =========================
# 4. HISTOGRAMS
# =========================

# Raw prices (will be skewed)
ggplot(df, aes(x = price)) +
  geom_histogram(bins = 50, fill = "skyblue", color = "black") +
  labs(title = "Histogram of House Prices")

# Log prices (much nicer shape)
ggplot(df, aes(x = log(price))) +
  geom_histogram(bins = 50, fill = "green", color = "black") +
  labs(title = "Histogram of Log House Prices")

# =========================
# 5. BOXPLOTS
# =========================

# Overall boxplot
ggplot(df, aes(y = price)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Boxplot of House Prices")

# Boxplot by waterfront
ggplot(df, aes(x = factor(waterfront), y = price)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Prices by Waterfront (0 = No, 1 = Yes)",
       x = "Waterfront")

# =========================
# 6. PROPORTION OF WATERFRONT
# =========================

table(df$waterfront)
prop.table(table(df$waterfront))

# =========================
# 7. GROUPED DESCRIPTIVES
# =========================

df %>%
  group_by(waterfront) %>%
  summarise(
    mean_price = mean(price),
    median_price = median(price),
    sd_price = sd(price),
    n = n()
  )

# =========================
# 8. CONFIDENCE INTERVAL FOR MEAN (MANUAL)
# =========================

n <- length(df$price)
mean_price <- mean(df$price)
sd_price <- sd(df$price)

error <- 1.96 * (sd_price / sqrt(n))

lower <- mean_price - error
upper <- mean_price + error

lower
upper

# =========================
# 9. CONFIDENCE INTERVAL FOR MEAN (t-test)
# =========================

t.test(df$price)

# =========================
# 10. CONFIDENCE INTERVAL FOR PROPORTION
# =========================

x <- sum(df$waterfront == 1)
n <- length(df$waterfront)

p_hat <- x / n

error_prop <- 1.96 * sqrt(p_hat * (1 - p_hat) / n)

lower_p <- p_hat - error_prop
upper_p <- p_hat + error_prop

lower_p
upper_p

# =========================
# 11. PROP TEST (BUILT-IN)
# =========================

prop.test(x, n)

# =========================
# 12. CI BY GROUP 
# =========================

df %>%
  group_by(waterfront) %>%
  summarise(
    mean_price = mean(price),
    sd_price = sd(price),
    n = n(),
    lower = mean_price - 1.96 * sd_price / sqrt(n),
    upper = mean_price + 1.96 * sd_price / sqrt(n)
  )