#load relevant libraries
library(readxl)
library(tidyverse)
library(here)
library(janitor)
library(stringr)
library(magrittr)
library(dplyr)


#clean 2015 data only
candy_2015_data <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")

#clean using janitor package
candy_2015_data <- clean_names(candy_2015_data)


#remove unneccesary columns

remove_cols_candy_2015 <- candy_2015_data[-c(1, 7, 18, 23, 26, 27, 28, 30, 34, 35, 
                                             37:38, 41, 59, 63, 80:82, 88:90,
                                             93:95, 97:99, 
                                             100:114, 116:124)]

#rename columns for ease of analysis later

remove_cols_candy_2015 <- rename(remove_cols_candy_2015,
                                 age = how_old_are_you,
                                 going_out = are_you_going_actually_going_trick_or_treating_yourself)

# create year column
remove_cols_candy_2015 <- remove_cols_candy_2015 %>% 
  mutate(year = 2015, .before = 1)

#fix age anomalies, place upper & lower limit on age.
options(scipen = 999)
fix_age_and_cols_candy_2015 <- remove_cols_candy_2015 %>% 
  mutate(age = as.numeric(age), age = if_else(
    age > 105, NA_real_, age
  ),
  age = if_else(
    age < 5, NA_real_, age
  ))


#clean 2016 data only
candy_2016_data <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")

#clean column names
candy_2016_data <- clean_names(candy_2016_data)

#remove unnecessary columns from data
remove_cols_candy_2016 <- candy_2016_data[-c(1, 6, 9, 15, 21, 22, 27, 31:32, 38, 
                                             41, 43, 78:79, 102, 104:105, 
                                             107:123)]

#rename columns
remove_cols_candy_2016 <- rename(remove_cols_candy_2016, age = how_old_are_you,
                                 gender = your_gender,
                                 country = which_country_do_you_live_in,
                                 going_out = are_you_going_actually_going_trick_or_treating_yourself)

#create year columns
remove_cols_candy_2016 <- remove_cols_candy_2016 %>% 
  mutate(year = 2016, .before = 1)

#fix age anomalies and change to numeric
fix_age_and_cols_candy_2016 <- remove_cols_candy_2016 %>% 
  mutate(age = as.numeric(age), age = if_else(
    age > 105, NA_real_, age
  ),
  age = if_else(
    age < 5, NA_real_, age)
  )


#clean 2017 data only
candy_2017_data <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")

#clean column names
candy_2017_data <- clean_names(candy_2017_data)

#remove unnecessary columns
remove_cols_candy_2017 <- candy_2017_data[-c(1, 6, 9, 15, 21:22, 27, 31:32, 38,
                                             43, 49, 79, 81, 105, 107:108,
                                             110:120)]

#remove q# prefix on column names
remove_cols_candy_2017 <- remove_cols_candy_2017 %>% 
  rename_with(str_remove, pattern = "q[0-9]+_")

#add year column
remove_cols_candy_2017 <- remove_cols_candy_2017 %>% 
  mutate(year = 2017, .before = 1)

#fix age anomalies, change age to numeric column and add upper & lower age limit
fix_age_and_cols_candy_2017 <- remove_cols_candy_2017 %>% 
  mutate(age = as.numeric(age), age = if_else(
    age > 105, NA_real_, age
  ),
  age = if_else(
    age < 5, NA_real_, age)
  )

#compare column names using janitor package
compare_df_cols_same(fix_age_and_cols_candy_2015,
                     fix_age_and_cols_candy_2016,
                     fix_age_and_cols_candy_2017)

#combine three data sets since cols are the same
combined_clean_candy_data <- bind_rows(fix_age_and_cols_candy_2015,
                                       fix_age_and_cols_candy_2016,
                                       fix_age_and_cols_candy_2017)

#pivot combined data set longer on the candy bars
long_combined_clean_data <- combined_clean_candy_data %>% 
  pivot_longer(cols = -c(year, age, country, 
                         going_out,
                         gender,
                         ), names_to = "candy_bar",
               values_to = "ratings")

#fix ratings column to change answers to joy & despair
long_combined_clean_data <- long_combined_clean_data %>% 
  mutate(ratings = case_when(
    ratings == "Yes" ~ "JOY",
    ratings == "No" ~ "DESPAIR",
    TRUE ~ ratings
  )
  )

#fix gender column to remove other & I'd rather not say
long_combined_clean_data <- long_combined_clean_data %>% 
  mutate(gender = case_when(
    gender == "Other" ~ "gender not represented",
    gender == "I'd rather not say" ~ "gender not represented",
    TRUE ~ gender
  )
  )

#check distinct responses in gender column
long_combined_clean_data %>% 
  select(gender) %>% 
  distinct()

# start cleaning country column

#initial check on numbers of each country before cleaning
country_count <- long_combined_clean_data %>% 
  group_by(country) %>% 
  summarise(count = n())

#create patterns for USA, GB and Canada
usa_pattern <- c("(?i)^usa.*", "^'merica", "united states", "(?i)^us*",
                 "(?i)^usa+", "^merica", "murrika", "murica", "^USA.*",
                 "trumpistan", "Pittsburgh", "New york", "California",
                 "alaska", "north carolina", "New jersey", "usanited.*",
                 "the usa", "USA of America", "USA of A", 
                 "The Yoo Ess of Aaayyyyyy", "america", "America", "the best one - usa")

uk_pattern <- c("United Kingdom", "United kingdom", "United Kindom", "UK", "uk",
                "Uk", "England", "england", "endland")

canada_pattern <- c("Canae", "Canada'", "CANADA", "canada", "Can")

#create regex for USA, GB and Canada
usa_regex <- str_c(usa_pattern, collapse = "|")
uk_regex <- str_c(uk_pattern, collapse = "|")
canada_regex <- str_c(canada_pattern, collapse = "|")

#use case_when to detect and change according to regex patterns above
clean_country_data <- long_combined_clean_data %>% 
  mutate(
    country = case_when(
      str_detect(country, uk_regex) ~ "GB",
      str_detect(country, usa_regex) ~ "USA",
      str_detect(country, canada_regex) ~ "Canada",
      TRUE ~ "other country"
      
    )
  )

#country count after cleaning of country column to check
country_count_extra <- clean_country_data %>% 
  group_by(country) %>% 
  summarise(count = n())

#write csv file in clean data folder
clean_country_data %>% 
  write_csv(here("clean_data/clean_country_data.csv"))













