### Todays lecture will cover Intro to Maps 
### Created by Ashlee Ochoa 
### Created on 03/08/2022

### loading libraries 
library(tidyverse)
library(here)
library(tidyverse)
library(maps)
library(mapdata)
library(mapproj)


### loading data 
popdata<-read.csv(here("Week_7","Data","CApopdata.csv"))
stars<- read.csv(here("Week_7","Data","stars.csv"))

### get data 
world <- map_data("world")

head(world)

usa <- map_data("usa")
head(usa)

states <- map_data("state")
head(state)

counties <- map_data("county")

### Plotting
ggplot() +
  geom_polygon(data = world, aes(x =long, y= lat, group = group, fill = region), ### fill fills in the polygons. fill is related to the region 
               color = "black") + ### Color is the outlines 
  guides(fill = FALSE) +
  theme(panel.background = element_rect(fill = "lightblue"))+ ### creates ocean "blue"
  coord_map(projection = "sinusoidal",
            xlim = c(-180, 180)) ### a vector so requires "c"

### use the states dataset 
CA_data <- states %>% 
  filter(region == "california") 

CA_data %>% 
  ggplot()+
  geom_polygon(aes(x= long, y=lat, group=group), ## group = group always required for mapping 
               color = "black") +
  coord_map() + ## fits entire map
  theme_void() ## takes away long and lat information 

CApop_county <- popdata %>% 
  select("subregion" = County, Population) %>% 
  inner_join(counties) %>% 
  filter(region == "california")

ggplot() +  ### plotting CApop 
  geom_polygon(data = CApop_county, 
               aes(x= long, 
                   y= lat, 
                   group = group,
                   fill = Population),
               color = "black") +
  geom_point(data = stars, ### add a point using the data sea stars 
             aes(x= long,
                 y=lat,
                 size = star_no))+ ## adding points for size of stars 
  coord_map()+ 
  theme_void() +
  scale_fill_gradient(trans = "log10") +
  labs(size = '# stars/m2')


ggsave(here("Week_7", "Output", "CApop.pdf"))
  
