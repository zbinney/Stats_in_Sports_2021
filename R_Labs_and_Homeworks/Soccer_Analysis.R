library(tidyverse)
library(StatsBombR)

# List of data available

comps <- FreeCompetitions()

Matches <- comps %>% 
  filter(competition_name == "NWSL") %>% 
  FreeMatches()
  

StatsBombData <- StatsBombFreeEvents(MatchesDF = head(Matches, 1))

example_event <- StatsBombData %>% 
  select(period, minute:duration, location:counterpress, type.name, possession_team.name, play_pattern.name, team.name,
         player.name, position.name:substitution.replacement.name)

example_event <- example_event %>% 
  select(period:possession, possession_team.name, player.name, type.name, position.name, duration, location, everything())
