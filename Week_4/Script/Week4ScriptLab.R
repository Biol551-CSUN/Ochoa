### This is my Script for the lab assignment on the penguin data for week 4 ###
### Created by Ashlee Ochoa 
### Created on 2022-02-10 

### Loading libraries 
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)

### Load Data 
glimpse(penguins)


### Question 1 ###
penguins %>%
  group_by(species, sex, island) %>% 
  summarise(mean_bodymass = mean(body_mass_g, na.rm=TRUE),
             variance_bodymass = var(body_mass_g, na.rm = TRUE)) %>% 
  drop_na(species, sex, island)

penguins %>% 
  filter(sex == "female") %>% 
  mutate(log_bodymass = log(body_mass_g)) %>% 
  select(species, island, sex, log_bodymass) %>% 
  ggplot(aes(x = species, y = log_bodymass)) +
  geom_violin(fill = "Pink") +
  labs(y = "Log Body Mass (g)", x = "Species", title = "Penguins") + 
  theme_linedraw() + 
  theme(plot.title= element_text(hjust = 0.5))
