library(readr)
library(tidyverse)
library(here)
library(janitor)
raw_decathlon_data <- read_rds(here("raw_data/decathlon.rds"))
head(raw_decathlon_data)
dim(raw_decathlon_data)
names(raw_decathlon_data)
has_rownames(raw_decathlon_data)
names(raw_decathlon_data)

raw_decathlon_data <- raw_decathlon_data %>% 
  clean_names()


raw_decathlon_data <- tibble::rownames_to_column(raw_decathlon_data, "row_names") # Apply rownames_to_column
raw_decathlon_data


raw_decathlon_data


names(raw_decathlon_data)
glimpse(raw_decathlon_data)
head(raw_decathlon_data)
dim(raw_decathlon_data)

raw_decathlon_data <- rename(raw_decathlon_data, athlete_name = row_names)

decathlon_data_long <- raw_decathlon_data %>%
  pivot_longer(cols = 2:11, 
               names_to = "event", 
               values_to = "score")

glimpse(decathlon_data_long)
dim(decathlon_data_long)
head(decathlon_data_long)
names(decathlon_data_long)
has_rownames(decathlon_data_long)

decathlon_data_long <- rename(decathlon_data_long, final_position = rank)
decathlon_data_long <- rename(decathlon_data_long, ind_event_score = score)

names(decathlon_data_long)
head(decathlon_data_long)
