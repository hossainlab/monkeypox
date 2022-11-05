library(tidyverse)
library(httr)
library(plotly)

# Loading data 
# df_monkeypox <- read.csv("https://raw.githubusercontent.com/owid/monkeypox/main/owid-monkeypox-data.csv")

df_monkeypox <- read.csv("https://raw.githubusercontent.com/globaldothealth/monkeypox/main/latest.csv")

# Exploring data 
dim(df_monkeypox)

names(df_monkeypox)

glimpse(df_monkeypox)

sum(is.na(df_monkeypox)) 

colSums(is.na(df_monkeypox)) 

nrow(df_monkeypox)

colSums(is.na(df_monkeypox)) / nrow(df_monkeypox) * 100 

sort(round(colSums(is.na(df_monkeypox)) / nrow(df_monkeypox) * 100), decreasing = T)


monkeypox <- df_monkeypox %>% 
  janitor::clean_names() %>% 
  filter(status)



library(maps)



