##### R Script Example - Baseball Data #####
##### Zachary Binney, PhD              #####
##### August 6, 2021                   #####

# Install and load necessary packages
pacman::p_load(Lahman, tidyverse)

### Investigate Data

# Let's take a look at the Teams data frame provided by the Lahman package
# Start by printing first 6 rows
head(Teams)

# Then check structure of data frame for dimensions, variable types
str(Teams)



### Add a Plot

# Plot of run differential vs. wins
# Don't worry about what this code means too much for now

Teams %>% # Take Teams data
  filter(yearID >= 2001, yearID <= 2019) %>% # Only use team data from 2001-2019
  mutate(rundiff = R - RA) %>% # Create a new variable for run differential
  ggplot(aes(x = rundiff, y = W)) + # Plot wins on the x-axis and rundiff on the y-axis
  geom_point() + # Create a scatterplot
  geom_smooth() + # Add a smooth line of best fit
  labs(title = "Run Differential vs. Wins in MLB, 2001-19",
       x = "Run Differential", y = "Wins") # Add overall title and better labels for X and Y axes
