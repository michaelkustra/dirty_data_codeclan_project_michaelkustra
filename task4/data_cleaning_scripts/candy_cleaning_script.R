library(readxl)
library(tidyverse)
library(here)


#clean 2015 data only
candy_2015_data <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")
library(janitor)
candy_2015_data <- clean_names(candy_2015_data)
names(candy_2015_data)

#remove unneccesary columns

remove_cols_candy_2015 <- candy_2015_data[-c(1, 18, 23, 26, 27, 28, 30, 34, 37,
                                             41, 59, 88:90, 97:99, 
                                             100:114, 116:124)]

#rename columns for ease of analysis later

remove_cols_candy_2015 <- rename(remove_cols_candy_2015, age = how_old_are_you)

# create year column
remove_cols_candy_2015 <- remove_cols_candy_2015 %>% 
  mutate(year = 2015, .before = 1)

#fix age anomalies, place upper limit on age.
options(scipen = 999)
fix_age_and_cols_candy_2015 <- remove_cols_candy_2015 %>% 
  mutate(age = as.numeric(age), age = if_else(
    age > 105, NA_real_, age
  ),
  if_else(
    age < 5, NA_real_, age
  ))




#clean 2016 data only
candy_2016_data <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")

#clean column names
candy_2016_data <- clean_names(candy_2016_data)

#remove unnecessary columns from data
remove_cols_candy_2016 <- candy_2016_data[-c(1, 6, 15, 21, 22, 27, 31, 38, 43,
                                             78:79, 102, 104:105, 107:123)]

#rename columns
remove_cols_candy_2016 <- rename(remove_cols_candy_2016, age = how_old_are_you)

#create year columns
remove_cols_candy_2016 <- remove_cols_candy_2016 %>% 
  mutate(year = 2016, .before = 1)

#fix age anomalies and change to numeric
fix_age_and_cols_candy_2016 <- remove_cols_candy_2016 %>% 
  mutate(age = as.numeric(age), age = if_else(
    age > 105, NA_real_, age
  ),
  if_else(
    age < 5, NA_real_, age)
  )


#clean 2017 data only
candy_2017_data <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")

#clean column names
candy_2017_data <- clean_names(candy_2017_data)

#remove unnecessary columns
remove_cols_candy_2017 <- candy_2017_data[-c(1, 6, 15, 21:22, 27, 31:32, 38,
                                             43, 49, 79, 81, 105, 107:108,
                                             110:120)]

#remove q# prefix on column names
remove_cols_candy_2017 <- remove_cols_candy_2017 %>% 
  rename_with(str_remove, pattern = "q[0-9]+_")

#add year column
remove_cols_candy_2017 <- remove_cols_candy_2017 %>% 
  mutate(year = 2017, .before = 1)

#fix age anomalies and change age to numeric column
fix_age_and_cols_candy_2017 <- remove_cols_candy_2017 %>% 
  mutate(age = as.numeric(age), age = if_else(
    age > 105, NA_real_, age
  ),
  if_else(
    age < 5, NA_real_, age)
  )



#combine three data sets
#combined_candy_data <- bind_rows(candy_2015_data, candy_2016_data, 
#                                 candy_2017_data)

#combined_candy_data %>% 
#write_csv(here("clean_data/combined_candy_data.csv"))


