# Exercise 4: DPLYR and flights data

# Install the nycflights13 package and read it in.  Require the dplyr package
install.packages("dpylr")
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data.frame flights should now be accessible to you.  View it, 
# and get some basic information about the number of rows/columns
View(flights)

# Add a column that is the amount of time gained in the air (`arr_delay` - `dep_delay`)
newcol <- mutate(flights, time_gained = arr_delay - dep_delay)

# Sort your data.frame desceding by the column you just created
sorted <- arrange(newcol, -time_gained)

# Try doing the last 2 steps in a single operation using the pipe operator
flights <- mutate(flights, time_gained = arr_delay - dep_delay) %>% arrange(-time_gained)

# Make a histogram of the amount of gain using the `hist` command
hist(flights$time_gained)

# On average, did flights gain or lose time?
#fuck off

# Create a data.frame that is of flights headed to seatac ('SEA'), 
to.seatac.df <- flights %>% select(dest, time_gained) %>% filter(dest == "SEA")

# On average, did flights to seatac gain or loose time?
avg.seatac <- mean(to.seatac.df$time_gained, na.rm = TRUE)

### Bonus ###
# Write a function that allows you to specify an origin, a destination, and a column of interest
# that returns a data.frame of flights from the origin to the destination and only the column of interest
## Hint: see chapter 11 section on standard evaluation
GetFlightInfo <- function(org, dst, col) {
  return (filter(flights, origin == org, dest == dst) %>% select(col))
}


# Retireve the air_time column for flights from JFK to SEA
airtime.jfk.sea <- GetFlightInfo("JFK", "SEA", "air_time")

# What was the average air time of those flights (in hours)?  
avg.airtime <- mean(airtime.jfk.sea$air_time, na.rm = TRUE) / 60

# What was the min/max average air time for the JFK to SEA flights?
