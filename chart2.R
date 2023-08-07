library(ggplot2)
library(tidyverse)
jail_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true")

ggplot(jail_pop, aes(x = male_jail_pop, y = female_jail_pop)) +
  geom_point() +
  labs(x = "Male Jail Population",
       y = "Female Jail Population",
       title = "Relationship between Male and Female Jail Population")+
  theme_minimal()