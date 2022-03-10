### This is my script for using Maps II
### Created by Ashlee Ochoa 
### Created on 2022-03-10

### loading libraries 
library(ggmap)
library(tidyverse)
library(here)
library(ggsn)

register_google(key = "OUR KEY HERE", write = TRUE) ### use own API key. key removed to upload onto Git 

### Load Data
ChemData <- read.csv(here("Week_7", "Data", "chemicaldata_maunalua.csv"))

glimpse(ChemData)

Oahu <- get_map("Oahu") ### pull map from Oahu 
ggmap(Oahu) ### View Oahu 

## Make a data frame of Lon and Lat coordinates 
WP <- data.frame(lon = -157.7621, lat = 21.27427) ## coordinates for Wailupe 

Map1 <- get_map(WP) ## naming map

ggplot(Map1) # view map 

Map1 <-get_map(WP, zoom =17) # zoom into map 
ggmap(Map1) # view map 

Map1<-get_map(WP,zoom = 17, maptype = "satellite") ## create satellite map 

ggmap(Map1) +
  geom_point(data = ChemData, ## plotting on the map 
             aes(x= Long, y = Lat, color = Salinity),
             size =4) +
  scale_color_viridis_c()


### can geo code to get exact location 
geocode("the white house")

geocode("California State University, Northridge")
