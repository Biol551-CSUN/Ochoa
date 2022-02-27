### Todays lecture will cover lubridate dates and times
### Created by Ashlee Ochoa 
### Created on 2022-02-24

### load libraries 
library(tidyverse)
library(here)
library(lubridate)


### load data
CondData <- read_csv(here("Week_5", "Data", "CondData.csv"))

now() ### what time is it now? 
now(tzone = "EST") ## ask for time in diff time zones
now(tzone = "GMT")

today() ## what is the date? 
today(tzone = "GMT")

am(now()) ### ask if it is am or pm
leap_year(now()) ## ask if we are in a leap year 

### Will always give ISO format 
ymd("2021-02-24") ### year month day
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")
## y= year, m= month, d= day 

ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")
### h= hours, m= minutes, s= seconds

## make a character string 
datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:21:10",
               "02/26/2021 8:01:52")

### convert to datetimes
datetimes <- mdy_hms(datetimes)

month(datetimes, label = TRUE, abbr = FALSE) ### label = true for month abbr. Abbr = FALSE for entire month spelled out 

### extracts information from dataset 
day(datetimes) ### extracts dates
wday(datetimes, label = TRUE) ### Extracts week day. TRUE will give you exact day of the week it was 
hour(datetimes)
minute(datetimes)
second(datetimes)

datetimes + hours(4) ## hours with S adds hours. just hour extracts 
datetimes +days(2) ## anything with S can add/sub/divide 

round_date(datetimes, "minute") ## round to nearest minute 
round_date(datetimes, "5 minutes")

CondData %>% 
  mutate(datetime = mdy_hms(depth)) %>% 
  drop_na()
  

