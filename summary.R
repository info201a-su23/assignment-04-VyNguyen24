library(dbplyr)
library(tidyverse)

prison_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")
jail_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true")
pop_rate <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates.csv?raw=true")
small_pop_rate <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates-1990.csv?raw=true")
WA_pop_rate <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")

# What is the sum of jail population in the US?
sum_total_jail_pop <- jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  mutate(sum_total_pop = sum(total_jail_pop)) %>%
  head(1) %>%
  pull(sum_total_pop)

# What is the average of female and male jail population? 

avg_female_jail_pop <- jail_pop %>%
  filter(!is.na(female_jail_pop)) %>%
  group_by(state) %>%
  summarise(avg_female_pop = mean(female_jail_pop))

avg_male_jail_pop <- jail_pop %>%
  filter(!is.na(male_jail_pop)) %>%
  group_by(state) %>%
  summarise(avg_male_pop = mean(male_jail_pop))

# Where is my variable the highest / lowest?
jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  group_by(state) %>%
  summarise(sum_pop = sum(total_jail_pop)) %>%
  arrange(desc(sum_pop)) %>%
  head(1)

avg_female_jail_pop %>%
  arrange(desc(avg_female_pop)) %>%
  head(1)
avg_female_jail_pop %>%
  arrange(desc(avg_female_pop)) %>%
  tail(1)

avg_male_jail_pop %>%
  arrange(desc(avg_male_pop)) %>%
  head(1)
avg_male_jail_pop %>%
  arrange(desc(avg_male_pop)) %>%
  tail(1)

# How much has jail population changed over the last 10 years?
x1 <- jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  group_by(year) %>%
  filter(year =="2010") %>%
  summarise(avg = mean(total_jail_pop)) %>%
  pull(avg)

x2 <- jail_pop %>%
  filter(!is.na(total_jail_pop)) %>%
  group_by(year) %>%
  filter(year=="2018") %>%
  summarise(avg = mean(total_jail_pop)) %>%
  pull(avg)

x2 - x1
