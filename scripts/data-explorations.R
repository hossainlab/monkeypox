library(tidyverse)
library(httr)
library(plotly)


# Loading data 
# Source https://github.com/owid/monkeypox/tree/main
data <- read.csv("https://raw.githubusercontent.com/owid/monkeypox/main/owid-monkeypox-data.csv")

# data preprocessing 
data$date <- as.Date(data$date)

# Number of Confirmed Cases by Location (Top 15 Countries)
top15_countries_cases <- data |> 
  group_by(location) |> 
  summarise(max_cases = max(total_cases)) |> 
  arrange(desc(max_cases)) |> 
  head(15)

# Create a bar chart for the top 15 countries with the highest total cases
plot_ly(data = top15_countries_cases, x = ~location, y = ~max_cases, 
        type = 'bar', marker = list(color = "#FF5733")) %>%
  layout(title = 'Top 15 Countries with Highest Total Cases',
         xaxis = list(title = 'Country', categoryorder = "total descending"),
         yaxis = list(title = 'Total Cases'))


# Number of Deaths by Location (Top 15 Countries)
top15_countries_deaths <- data |> 
  group_by(location) |> 
  summarise(max_deaths = max(total_deaths)) |> 
  arrange(desc(max_deaths)) |> 
  head(15)

# Create a bar chart for the top 15 countries with the highest total cases
plot_ly(data = top15_countries_deaths, x = ~location, y = ~max_deaths, 
        type = 'bar', marker = list(color = "#FFC300")) %>%
  layout(title = 'Top 15 Countries with Highest Total Death Cases',
         xaxis = list(title = 'Country', categoryorder = "total descending"),
         yaxis = list(title = 'Total Deaths'))


# Create a map using Plotly
plot_ly(data = data, type = "scattergeo", mode = "markers",
               locations = ~iso_code,
               text = ~paste("Country: ", location, "<br>Total Cases: ", total_cases, "<br>Total Deaths: ", total_deaths),
               marker = list(
                 size = ~total_cases / 10000,  # Adjust marker size based on total cases
                 color = ~total_deaths,  # Color markers based on total deaths
                 colorscale = "Viridis",  # Choose a color scale
                 colorbar = list(title = "Total Deaths")
               )) |> 
  layout(
    title = "Monkeypox Map by Total Cases and Total Deaths",
    geo = list(
      showland = TRUE,  # Display land masses
      landcolor = "lightgray"  # Land color
    )
  )
