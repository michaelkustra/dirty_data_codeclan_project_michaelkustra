library(readxl)
library(tidyverse)
library(here)

candy_2015_data <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")
candy_2016_data <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")
candy_2017_data <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")

dim(candy_2015_data)
dim(candy_2016_data)
dim(candy_2017_data)

names(candy_2015_data)
names(candy_2016_data)
names(candy_2017_data)

library(janitor)
candy_2015_data <- clean_names(candy_2015_data)
candy_2016_data <- clean_names(candy_2016_data)
candy_2017_data <- clean_names(candy_2017_data)

combined_candy_data <- bind_rows(candy_2015_data, candy_2016_data, 
                                 candy_2017_data)

combined_candy_data %>% 
write_csv(here("clean_data/combined_candy_data.csv"))



