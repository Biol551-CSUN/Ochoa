### This is my script for lab on biogeochemistry data from Hawaii 
### Created by Ashlee Ochoa 
### Created on 2022-02-17

### load libraries 
library(tidyverse)
library(here)
library(viridis)
library(extrafont)

### Load Data 
ChemData <- read_csv(here("Week_4", "Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)


ChemData1 <- ChemData %>% 
filter(complete.cases(.)) %>% 
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = TRUE) %>%
  unite(col = "Site_Zone",
        c(Site,Zone),
        sep = ".",
        remove = TRUE)

View(ChemData1)

ChemData1 <- ChemData1 %>%  ### must "assign" each time 
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")

View(ChemData1)

ChemData2 <- ChemData1 %>% 
  group_by(Variables, Time) %>% 
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            param_sd = sd(Values, na.rm = TRUE)) %>% 
write_csv(here("Week_4", "Output", "LABSTATS.csv"))

View(ChemData1)

ChemData2 %>% 
  ggplot(aes(x= Variables, y = log10(Param_means +1),color=Time)) +
  geom_point()+ 
  ggtitle("Hawai'i Biogeochemistry Data") +
  theme(plot.title= element_text(hjust = 0.5))+
  labs(x = "Variables", y= "Log of mean parameter") +
  theme_light()+
  choose_font(c("sans"), quiet = TRUE)

  
View(ChemData2)

ggsave(here("Week_4", "Output", "Biogeochemgraph.png"))
