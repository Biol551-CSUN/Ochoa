### Todays lecture will be practice on joins with data using Becker and Silbiger 
### Created by Ashlee Ochoa 
### Created on 2022-02-22

### Load Libraries
library(tidyverse)
library(here)


### Load data 
EnviroData <- read_csv(here("Week_5", "Data", "site.characteristics.data.csv"))

TPCData <- read_csv(here("Week_5", "Data", "Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)

EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, ### pivot wider 
              values_from = values)
View(EnviroData_wide) %>% 
  arrange(site.letter) ### arrange the dataframe by site. arrange deals with rows

FullData_left <- left_join(TPCData, EnviroData_wide) %>% ### joining by "site.letter"
  relocate(where(is.numeric), .after = where(is.character)) 

### Summarise per site: mean and var 
sum <- FullData_left %>% 
  group_by(site.letter) %>% 
  summarise_if(is.numeric, list(mean = mean, var = var), na.rm= TRUE) ### summarise if 

head(FullData_left)

### Creating a tibble 
### use tibble()

T1 <- tibble(Site.ID = c("A", "B", "C", "D"), ### make your own data frame in R
             Temperature = c(14.1, 16.7, 15.3, 12.8))

T2 <- tibble(Site.ID = c("A", "B", "D", "E"),
             pH = c(7.3, 7.8, 8.1, 7.9))


## joining tibbles 
left_join(T1, T2) ###will keep only what is on left side. joining by "Site.ID".

right_join(T1, T2) ## will lose what was on the left side that does not match right side 

### Inner Join only keeps data complete in both data sets (NAs dropped)
### full join keeps everything (NA included) 

inner_join(T1, T2)
full_join(T1, T2)

### Semi join keeps rows from first data set where there are matching values in 2nd data. keeps columns from just first data set 
### anti join keeps missing data 

semi_join(T1, T2)
anti_join(T1, T2) ## this is the only site missing from this data set 
