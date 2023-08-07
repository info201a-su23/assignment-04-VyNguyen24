library(ggplot2)
library(openintro)
library(maps)
library(usmap)
library(datasets)
library(dplyr)
library(tidyverse)
jail_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true")

us_states <- map_data("state")

# adjust the column name
new_state_names <- c(
  "alabama" = "AL", "alaska" = "AK", "arizona" = "AZ", "california" ="CA", "colorado" = "CO", "connecticut" = "CT",
  "delaware" = "DE", "district of columbia" = "DC", "florida" = "FL", "georgia" = "GA", "idaho" = "ID", "illinois" = "IL",
  "indiana"="IN", "iowa" = "IA", "kansas" = "KS", "kentucky" = "KY", "louisiana" = "LA", "maine"="ME", "maryland"="MD",
  "massachusetts"="MA", "michigan"= "MI", "minnesota"="MN", "mississippi"="MS", "missouri"="MO", "montana"="MT",
  "nebraska"="NE", "nevada"="NV", "new hampshire"="NH", "new jersey"="NJ", "new mexico"="NM", "new york"="NY",
  "north carolina"="NC","north dakota"="ND", "ohio"="OH", "oklahoma"="OK", "oregon"="OR", "pennsylvania"="PA",
  "rhode island"="RI", "south carolina"= "SC", "south dakota"= "SD", "tennessee"="TN", "texas"="TX", "utah"="UT",
  "vermont"="VT", "virginia"="VA", "washington"="WA", "west virginia"="WV", "wisconsin"="WI", "wyoming"="WY") 
us_states$region <- new_state_names[us_states$region]

# merging dataset
new_data <- jail_pop %>%
  na.omit() %>%
  group_by(state) %>%
  summarise(sum_jail_pop = sum(total_jail_pop))
colnames(new_data)[colnames(new_data) == "state"] <- "state"
colnames(us_states)[colnames(us_states) == "region"] <- "state"


merged_data <- inner_join(us_states, new_data, by = "state")


ggplot(data = merged_data, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = sum_jail_pop), color = "white") +
  coord_fixed() +
  labs(title = "Heatmap of States Jail Population",
       fill = "Jail Population") +
  scale_fill_viridis_c() +
  theme_minimal()