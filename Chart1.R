library(tidyverse)
library(ggplot2)
library(patchwork)
library(dplyr)
jail_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true")

df1 <- jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  filter(state == "CA")
df2 <- jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  filter(state == "WA")
df3 <- jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  filter(state == "FL")

combined_data <- bind_rows(df1, df2, df3)

# Create the plot
ggplot(combined_data, aes(x = year, y = total_jail_pop, color = state)) +
  geom_line(stat = "summary", fun = mean) +
  labs(title = "CA, WA, FL Jail Population over time", x = "Year", y = "Total Jail Population") +
  scale_color_manual(values = c("red", "blue","green"), labels = c("CA", "WA", "FL")) +
  theme_minimal()
