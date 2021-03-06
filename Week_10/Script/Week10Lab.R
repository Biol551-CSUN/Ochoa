### For todays lab assignment my group will be creating code including and a bug using datapasta and reprex. 
### Created by Ashlee Ochoa 
### Created on 2022-04-05

# Loading Libraries 
library(tidyverse)
library(reprex)
library(datapasta)
library(styler)

# Loading Data 
tibble::tribble(
  ~Waypoint,        ~Zone,     ~Lat,      ~Long, ~Site,  ~Season, ~Tide_time,    ~Temp_in,   ~Salinity, ~Phosphate, ~Silicate,  ~NN,   ~pH,         ~TA, ~percent_sgd,
         1L, "Transition", 21.27531, -157.76181,   "W", "SPRING",  "Low_Day", 23.75505834,  27.7402879,       0.54,    157.93, 7.92, 7.909,  2161.48229,  20.40439276,
         2L, "Transition", 21.27523, -157.76265,   "W", "SPRING",  "Low_Day", 23.53255956,  30.6119226,       0.36,     92.59, 3.37, 7.965, 2145.827701,   11.9625323,
         3L, "Transition", 21.27504, -157.76328,   "W", "SPRING",  "Low_Day", 22.63449814, 28.37007862,        0.5,     143.6, 7.29, 8.023,  2272.39081,  18.55297158,
         4L, "Transition", 21.27449, -157.76402,   "W", "SPRING",  "Low_Day", 24.01982367, 32.82124424,       0.25,     42.32, 0.79, 7.995, 2219.583262,  5.467700258,
         5L,    "Diffuse", 21.27503,  -157.7617,   "W", "SPRING",  "Low_Day", 23.26102354, 29.12292683,        0.5,    126.47, 7.45, 8.005, 2151.825559,  16.33979328,
         6L,    "Diffuse", 21.27485, -157.76234,   "W", "SPRING",  "Low_Day", 24.00516582,  34.0201759,       0.13,     15.04, 0.46, 8.019,   2216.7581,  1.943152455,
         7L,    "Diffuse", 21.27463, -157.76318,   "W", "SPRING",  "Low_Day", 23.72550249, 32.20639623,       0.28,     56.31, 1.59, 8.003, 2220.335875,  7.275193798,
         8L,    "Diffuse", 21.27436, -157.76364,   "W", "SPRING",  "Low_Day", 24.08231046, 33.66594609,       0.15,      23.1, 0.34, 7.978, 2266.862576,  2.984496124,
         9L,    "Diffuse", 21.27456, -157.76126,   "W", "SPRING",  "Low_Day", 24.61700769, 32.66478542,       0.23,     45.88, 1.91, 7.972, 2189.458388,  5.927648579,
        10L,    "Diffuse", 21.27427, -157.76208,   "W", "SPRING",  "Low_Day",  23.8898623, 34.34759675,       0.11,      7.59, 0.25, 7.959, 2240.714341,  0.980620155
  )

# Creating Reprex
chem %>% 
  ggplot() +
  geom_point(x= Zone, y= Temp_in)
