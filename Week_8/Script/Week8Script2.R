### Today we will be working on functional programming  
### Created by Ashlee Ochoa
### Created on 2022-03-17

### loading libraries 
library(tidyverse)
library(palmerpenguins)
library(PNWColors) 


## practice with functions 
df<- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

head(df)

df <- df %>% 
  mutate(a = (a-min(a, na.rm = TRUE))/ max(a, na.rm = TRUE) -min(a, na.rm = TRUE))

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}


## creating functions 

# calculation for F to C?
temp_C <- (temp_F - 32) * 5/9

# Step 1: Name function
FtoC <- function(temp_F) {  ## function F to C
  temp_C <- (temp_F - 32) * 5/9
  return(temp_C)
}

FtoC(32)

FtoC(212)

temp_K <- (temp_C + 273.15)

CtoK<- function(temp_C) {  ## function Celsius to Kelvin 
  temp_K <- (temp_C + 273.15)
  return(temp_K)
}

CtoK(10)

### Making Plots into a function 
myplot <- function(data = penguins, x, y) { ### creating the plot a function. can add defaults ex) data = penguins 
pal <- pnw_palette("Lake", 3, type= "discrete") # my color palette

ggplot(penguins, aes(x = {{x}}, y = {{y}}, color = island))+ ### Need to add curly-curly bc associated with data in data frame 
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()

}

myplot(x = body_mass_g, y= flipper_length_mm) +
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")

a <- 4
b <- 5

if (a >b) { ### always open and close our questions with brackets 
  f <- 20 
} else {
  f <- 10
}

f

## plotting with if else 
myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines. lines there or not 
  pal<-pnw_palette("Lake",3, type = "discrete")
 
if (lines == TRUE) {   
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}
else {
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}
}

myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE)

