### This is my script for plotting penguin data ###
### Created by: Ashlee Ochoa ####
### Created on 2022-02-10 ####

### Loading Libraries ###
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)

### Graphing ###
plot1 <- ggplot(data = penguins, ### <- can be used to assign objects 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species, ### creates regression line for each species 
                     color = species)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)") +
   ### scale_color_viridis_d()
scale_color_manual(values = beyonce_palette(2)) + 
  theme_bw() +
  theme(axis.title = element_text(size = 20,
                                  color = "red"),
       panel.background = element_rect(fill = "linen"))
pggsave(here("Week_3", "Output", "penguin.png"),### here is a library 
       width = 7, height = 5) 
  
  