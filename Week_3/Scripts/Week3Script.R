### This is my script for Week 3. Plotting Palmer Penguins.  
### Created by Ashlee Ochoa 
### Created on 2022-02-08
###############################
#### Install packages being used beforehand ####

### load libraries ###
library(palmerpenguins) #loads Palmer penguins data set 
library(tidyverse)

### starting Data Analysis ###
glimpse(penguins) # function to visualize data

### Plotting ###
ggplot(data=penguins, #presents grey box. data is penguins. telling ggplot what data is. 
mapping=aes(x= bill_depth_mm,#aes= aesthetic, SPECIFIC to data. X= data from column. Use equal sign when assigning within a function. 
            y=bill_length_mm, # y= data from column. Don't forget to add "+" when adding other functions.
          color = species,# Color for each species in data set
          size = body_mass_g,
          alpha = flipper_length_mm, #alpha= transparency
            shape = species)) + # shape changes "point" of that specific thing
  geom_point()+ #tells you graph will be a point
  facet_wrap(~species, ncol=2) + # ~ means as a function of. sex as a function of species. facet_grid rows vs columns. Facet wrap for just columns or rows, 1D plotting. 
  guides(color = FALSE)
  labs(title = "Bill depth and length", #labs= labels. How things look. Quotations assign the title name 
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x= "Bill depth (mm)", y= "Bill length (mm)", color = "Species", # capitalization for the species in-between quotations
       shape = "Species", 
       caption = "Source: Palmer Station LTER/ palmerpenguins package") + # perfect for sourcing
  scale_colour_viridis_d() # For color blindness 


