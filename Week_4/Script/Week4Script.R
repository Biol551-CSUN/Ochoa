### Today we are going to plot penguin data ###
### Created by Ashlee Ochoa 
### Created on 2022- 02- 15

### Loading Libraries ###
library(palmerpenguins)
library(tidyverse)
library(here)

### Load Data ###
glimpse(penguins)

### filter allows you to filter things other than variables you want to keep ###

head(penguins) 

### filter so only female data is kept >###
filter(.data = penguins, 
       sex == "female",
       year == "2008",  ## Two equal signs is a question. Is sex exactly equal to female?? One sets the argument in the function 
       body_mass_g > "5000") ## number doesn't need quotes 

### a & b : and, a | b : or, !a : not 

filter(.data = penguins,year == 2008 | year == 2009)
filter(.data =penguins, island !a= "Dream")
filter(.data = penguins, species %in% c("Adeline", "Gentoo"))

### %in% means within the vector. Vector is more than one ###

### mutate adds column with new info to current data frame ###

data2 <- mutate(.data = penguins, ## mutate: changing the data frame 
                body_mass_kg = body_mass_g/1000, ### naming new column "Body_mass_kg" to the equation. converting mass to kg
                bill_length_depth = bill_length_mm/bill_depth_mm)   ## calculating bill ratio to bill depth 
View(data2)

##ifelse testing if value is true or false 
  ### ifelse(Test, Value_if_true, Value_If_False)

data2<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
View(data2)

data2 <- mutate(.data = penguins,
                flipper_mass = flipper_length_mm + body_mass_g)
               
View(data2)

data2 <- mutate(.data =penguins,
               mass_big_small = ifelse(body_mass_g > 4000, "Big", "Small")) ## labeling body mass >4000 big 
View(data2)

### The Pipe "%>%" means "and then do"

penguins %>% ### uses penguin dataframe
  filter(sex == "female") %>% ## selects females
mutate(log_mass = log(body_mass_g)) %>% ## calculate log biomass 
select(Species = species, island, sex, log_mass)  ## select is for columns. filter for rows. Can also rename columns here 
## don't forget to include the pipe 

penguins %>% 
  group_by(island) %>% 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm = TRUE)) ### caluclate mean flipper length and exclude NA
penguins %>% 
  group_by(island) %>% 
  summarise(mean_bill_length = mean(bill_length_mm, na.rm= TRUE),
            max_bill_length = max(bill_length_mm, na.rm= TRUE))

penguins %>% 
  drop_na(sex) %>% 
  group_by(island, sex) ## drop rows with variables that contain na 

library(devtools)
library(dadjoke)
