library(readr)
library(tidyverse)
library(here)
library(janitor)
raw_decathlon_data <- read_rds(here("raw_data/decathlon.rds"))
head(raw_decathlon_data)
dim(raw_decathlon_data)
names(raw_decathlon_data)
raw_decathlon_data <- rowid_to_column(raw_decathlon_data) %>% head()
names(raw_decathlon_data)

raw_decathlon_data <- raw_decathlon_data %>% 
  clean_names()

                                           # Duplicate example data
raw_decathlon_data <- tibble::rownames_to_column(raw_decathlon_data, "row_names") # Apply rownames_to_column
raw_decathlon_data

raw_decathlon_data <- rename(raw_decathlon_data, athlete_name = row_names)

raw_decathlon_data


names(raw_decathlon_data)
glimpse(raw_decathlon_data)
head(raw_decathlon_data)
dim(raw_decathlon_data)

decathlon_data_long <- raw_decathlon_data %>%
  pivot_longer(cols = 2:11, 
               names_to = "event", 
               values_to = "score")

glimpse(decathlon_data_long)
dim(decathlon_data_long)
head(decathlon_data_long)
has_rownames(decathlon_data_long)
