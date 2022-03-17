### Today we will be working on advanced plotting 
### Created by Ashlee Ochoa 
### Created on 2022-03-15

### Loading Libraries 
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)

### plotting 

### Using PatchWork 

# Plot 1
p1 <- penguins %>%  ### assigning first data set 
  ggplot(aes(x = body_mass_g, 
             y= bill_length_mm, 
             color = species)) +
  geom_point()
p1

# Plot 2 
p2 <- penguins %>% # assigning secodn data set 
  ggplot(aes(x =sex,
             y= body_mass_g,
             color = species)) +
  geom_jitter()
p2

p1 + p2 + ### combining both data sets side by side 
  plot_layout(guides = 'collect') +
  plot_annotation(tag_levels = 'A')

p1/p2 + ### combining both data sets one on top of the other 
  plot_layout(guides = 'collect') +
  plot_annotation(tag_levels = 'A')


## gg repel 

View(mtcars)

ggplot(mtcars, aes(x = wt, 
                   y= mpg,
                   label = rownames(mtcars))) +
  geom_label_repel() + ## creates text label 
  geom_point(color = 'red')

## gg animate 
penguins %>% 
  ggplot(aes(x = body_mass_g,
             y= bill_depth_mm,
             color = species)) +
  geom_point() +
  transition_states(
    year, ## what we are animating by 
    transition_length = 2, ## 
    state_length = 1 ## the length 
  ) +
  ease_aes("bounce-in-out") + ## how you want the animation to be 
  ggtitle('Year: {closest_state}')+  ## closest state pulls out information you are using for that specific variable 
  anim_save(here("Week_8", "Output", "mypenguingif.gif")) ## save as gif 

# magik package 
penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png") ## image_read reads in a png 
penguin

penguins %>% 
  ggplot(aes(x = body_mass_g,
             y = bill_depth_mm, 
             color = species)) +
  geom_point()
ggsave(here("Week_8", "Output", "penplot.png"))

penplot <- image_read(here("Week_8", "Output", "penplot.png"))
out <-image_composite(penplot, penguin, offset = "+70+30") ## image composite turns two separate images into a composite. Combines both into one  
out

# Read in a penguin gif 
pengif<-image_read("https://media3.giphy.com/media/H4uE6w9G1uK4M/giphy.gif")
outgif <- image_composite(penplot, pengif, gravity = "center")
animation <- image_animate(outgif, fps = 10, optimize = TRUE)
animation
