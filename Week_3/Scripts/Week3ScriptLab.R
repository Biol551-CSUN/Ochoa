### This is my script for the lab assignment on plotting pengins ###
### Created by Ashlee Ochoa ###
### Created on 2022-02-10 ###

### loading libraries ###
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)

### Graphing ###
ggplot(data = penguins,
       mapping =aes (x = bill_depth_mm, 
                     y = bill_length_mm,
                     color = species)) +
  geom_boxplot(fill = "pink") +
  labs(x = "Bill Depth (mm)", y= "Bill Length (mm)", title = "Penguins") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_color_manual(values = beyonce_palette(90)) + 
  theme_light()

ggsave(here("Week_3", "Output", "Penguin2lab.png"))


        