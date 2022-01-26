# Load necessary packages
pacman::p_load(tidyverse, Lahman)

# Load data
data(Teams)

# A shorter way to code the same selection
teams_2019 %>% 
  select(yearID, teamID, W, L, R:H, X2B, X3B, HR) %>%  # `R:H` selects all columns between R and H, inclusive
  head() 


