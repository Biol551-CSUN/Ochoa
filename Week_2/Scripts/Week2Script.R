### This is my first script. I am learning how to import data
### Created by: Ashlee Ochoa
### Created on: 2022-02-03
################################

### load libraries #######
library(tidyverse)
library(here)

### Read in data ####
WeightData <- read_csv(here("Week_2","Data","Weightdata.csv"))

# Data analysis ####
head(WeightData) # looks at top 6 lines #
tail(WeightData) # looks at bottom 6 lines #
View(WeightData) # View of Data Set #
