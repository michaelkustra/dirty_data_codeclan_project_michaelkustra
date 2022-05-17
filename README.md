---
title: "Dirty Data Project"
author: "MK"
date: "16/05/2022"
output: html_document
---

# Description

The aim of this project was to take three years worth of halloween candy data and decathlong data to clean it to a _tidy_ format. Once cleaned, I was set tasks to solve using the clean data in the most efficient way possible.

# Technologies Used

All cleaning was done within an __R-script__ using mainly _tidyverse_ functions. Data wrangling and analysis was complete in __R-Studio__ to ensure all analysis and interpretation could be completed simultaneously.

# Task 1 - Decathlon Data

The first task was completed using data from two recent decathlon competitions: an Olympic competition and the World Championships.

# Task 4 - Halloween Data

The next task was done using three years of halloween candy data collected by survey participants while they potentially went trick-or-treating. 

# Code Examples

Example of case_when() to recode categorical variables to numerical rating in order to summarise numerically the highest rated candy in following questions:

![](images/case_when.png)

Example of using several tidyverse verbs together to aggregate a large subset of data into one measurable metric that will return the highest rated candy by gender:

![](images/summarise.png)
