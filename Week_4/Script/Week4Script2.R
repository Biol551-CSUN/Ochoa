### This is my script for Week 4. I will be practicing biogeochemistry data from Hawaii
### Created by Ashlee Ochoa 
### Created on 2022-02-17

### Load Libraries 
library(tidyverse)
library(here)

### Load Data
ChemData <- read_csv(here("Week_4", "Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

ChemData_clean <- ChemData %>% 
  filter(complete.cases(.)) %>% ### filters out everything that is not a complete row 
  separate(col = Tide_time, 
           into = c("Tide", "Time"),
           sep = "-",
           remove = FALSE) %>% 
  unite(col = "Site_Zone",
        c(Site,Zone), ### Name of column that already exists. doesnt require quotes
        sep = ".",
        remove = FALSE)
head(ChemData_clean)

###separate(
##  data = [data frame you are using],
  ##col = [column you eant to sep],
 ## into = [name of the new column],
 ## sep = [what are you separating by?]
##) ###


ChemData_long <- ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")
view(ChemData_long)

ChemData_long %>% 
  group_by(Variables, Site, Zone, Tide) %>% ### Group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            param_sd = sd(Values, na.rm = TRUE))

ChemData_long %>% 
  ggplot(aes(x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables, scales = "free") ### scales = "free" releases both x and y axes 

ChemData_wide <- ChemData_long %>% 
  pivot_wider(names_from = Variables,
              values_from = Values)
View(ChemData_wide)

ChemData_clean <- ChemData %>% 
  filter(complete.cases(.)) %>%   ##filters out everything that is not complete 
  separate(col = Tide_time, ### choose the tide time col
           into = c("Tide", "Time"), ## Separate it into two columns Tide and time 
           sep = "_", ## Separate by __
           remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd, ### THe colmns you want to pivot 
               names_to = "Variables", ## names of new col
               values_to = "Values") %>% 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% 
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% 
  write_csv(here("Week_4", "Output", "Summary.csv")) ### Exports as CSV 

View(ChemData_clean)
