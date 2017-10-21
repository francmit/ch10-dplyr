# Exercise 2: Data Frame Practice with `dplyr`.
# Use a different appraoch to accomplish the same tasks as exercise-1

# Install devtools package: allows installations from GitHub
install.packages('devtools')

# Install "fueleconomy" package from GitHub
devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package
library(fueleconomy)

# Install (if you haven't already) and load the `dplyr`package
install.packages("dplyer")
library(dplyr)

# You should have have access to the `vehicles` data.frame


# Create a data.frame of vehicles from 1997
v.df <- filter(vehicles, year == 1997)

# Use the `unique` function to verify that there is only 1 value in the `year` column of your new data.frame
unique(select(v.df, year))

# Create a data.frame of 2-Wheel Drive vehicles that get more than 20 miles/gallon in the city
twdv.df <- filter(vehicles, year==1997)

# Of those vehicles, what is the vehicle ID of the vehicle with the worst hwy mpg?
id.worst <- select(filter(twdv.df, min(hwy) == hwy), id)

# Write a function that takes a `year` and a `make` as parameters, and returns 
# The vehicle that gets the most hwy miles/gallon of vehicles of that make in that year
GetIt <- function(y, m) {
  return (filter(vehicles, year==y, make==m) %>% filter(hwy==max(hwy)))
}

# What was the most efficient honda model of 1995?
GetIt("1995", "Honda")


