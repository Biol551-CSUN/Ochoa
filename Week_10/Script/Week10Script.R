### Today I will be working on getting help in R using reprex
### Created by Ashlee Ochoa 
### Created on 2022-04-05

# Loading libraries
library(tidyverse)

mpg %>%  
  ggplot(aes(x = displ, y =hwy)) %>% 
  geom_point(aes(color = class))
 ### Error: Did you use %>%  instead of +? 
## go to Addins > Render Reprex 

tibble::tribble(
    ~lat,    ~long, ~star_no,
  33.548, -117.805,      10L,
  35.534, -121.083,       1L,
  39.503, -123.743,      25L,
  32.863,  -117.24,      22L,
   33.46, -117.671,       8L
  )
## Addins > paste as tibble, etc 