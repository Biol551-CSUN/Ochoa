### In lab today I will be using the conductivity and Depth data 
### created by Ashlee Ochoa 
### created on 2022-02-24

### load libraries
library(tidyverse)
library(here)
library(lubridate)
library(ggplot2)
library(beyonce)

### load data 
CondData<- read_csv(here("Week_5", "Data", "CondData.csv"))
DepthData <- read_csv(here("Week_5", "Data", "DepthData.csv"))


CD <- CondData %>% 
  mutate(CD = mdy_hms(depth)) %>% ### mutate adds the new column
  drop_na() %>% 
  mutate(Datetime = round_date(CD, "10 sec")) %>% ### add "Dateime" to create the new column name within the data frame
  mutate(date = Datetime) %>% ### creates new column named "date" on "Datetime" data 
  select(date, TempInSitu, SalinityInSitu_1pCal) %>% ### selects the specific data of interest 
  inner_join(DepthData) %>% ## Inner join to join both data sets together 
  mutate(hour = hour(date)) %>% ## creating a column named "hour" using the hour from the date column 
  mutate(minute = minute(date)) %>%  ## Creating a column named "minute" using the minute data from the date coulmn 
  mutate(day = day(date)) %>% ### ^^^
  unite(col = "HourMin", ### Unites the hour and minute column into a column named "HourMin"
        c(hour, minute),
        sep = ":", ### separates the hour and minute by ":"
        remove = TRUE) %>%  ## removes original column 
  group_by(HourMin)%>% ### grouping the HourMin coumn 
  summarise(MeanDepth = mean(Depth, na.rm = TRUE), ## Depth in meters
            MeanSalinity = mean(SalinityInSitu_1pCal, na.rm = TRUE),
            MeanTemp = mean(TempInSitu, na.rm = TRUE), ### Temp in cel
            MeanDate = mean(date, na.rm = TRUE)) 
### calculates the average of each variables listed by HourMin 

### Plotting 
CD %>%
  ggplot(aes(x= MeanDate, y= MeanTemp)) + ### plotting MeanDate vs MeanTemp
  geom_line(color = "red")+ ### line graph 
  labs(x= "Average Time", y= "Average Temperature (C)", title = "Average Temperature Over Time")+ ## Altering titles 
  theme(plot.title = element_text(hjust = 0.5)) ### centers the title 


ggsave(here("Week_5", "Output", "Conductivity_Depth.png"))





