# Exercise 7: DPLYR practice with NBA data

# Read in the NBA player data into a variable called `team.data` using `read.csv`
team.data <- read.csv("data/teams.csv")
library(dplyr)
# The data.frame team.data should now be accessible to you. 
# View it, and get some basic information about the number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" 
# following the names of teams that made it to the playoffs that year.


# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
team.data <- mutate(team.data, TOV.STL.ratio = TOV / STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest ratio? Ans: Boston Celtics.
team.data <- arrange(team.data, TOV.STL.ratio)

# Using the pipe operator, create a new column of assists per game (AST / G) AND
# sort the data.frame by this new column in DESCENDING order.
team.data <- mutate(team.data, AST.per.game = AST / G) %>% arrange(-AST.per.game)
              
# Create a data.frame called `good.offense` of teams that scored more than 8700 points (PTS)
good.offense <- team.data %>% filter(PTS > 8700)

# Create a data.frame called `good.defense` of teams that had more than 470 blocks (BLK)
good.defense <- team.data %>% filter(BLK > 470)

# Create a data.frame called `defense.stats` that only shows defensive rebounds (DRB), steals (STL),
# and blocks (BLK) along with the team name.
defense.stats <- select(team.data, Team, DRB, STL, BLK)

# Create a data.frame called `offense.stats` that only shows offensive rebounds (ORB), 
# field-goal % (FG.), and assists (AST) along with the team name.
offense.stats <- select(team.data, Team, ORB, FG., AST)

### Bonus ###
# Create a function called `BetterShooters` that takes in two teams and returns
# a data.frame of the team with the better field-goal percentage. The returned 
# data.frame should include the team name, field-goal percentage, and points.
BetterShootersBad <- function(t1, t2) {
  t1.fg.perc <- team.data %>% filter(Team == t1) %>% select(FG.)
  t2.fg.perc <- team.data %>% filter(Team == t2) %>% select(FG.)
  if (t1.fg.perc > t2.fg.perc) {
    return (team.data %>% filter(Team == t1) %>% select(Team, FG., PTS))
  } else {
    return (team.data %>% filter(Team == t2) %>% select(Team, FG., PTS))
  }
}

BetterShooters <- function(t1, t2) {
  better.team <- team.data %>% filter(Team %in% c(t1, t2)) %>% filter(FG. == max(FG.)) %>%
    select(Team, FG., PTS)
  return (better.team)
}
BetterShooters("Sacramento Kings", "Washington Wizards")
