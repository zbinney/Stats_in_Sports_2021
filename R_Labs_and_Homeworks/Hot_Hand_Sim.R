pacman::p_load(tidyverse)

# Generate sequence of coin flips
set.seed(08252021)

n_players <- 20
n_shots <- 100

flips <- sample(c("Make", "Miss"), replace = TRUE, size = n_shots*n_players)

hothand_df <- tibble(flips, player = rep(1:n_players, each = n_shots))

hothand_df <- hothand_df %>%
  mutate(result = case_when(flips == "Make" ~ 1,
                            TRUE ~ 0),
         change = case_when(flips == lag(flips) & player == lag(player) ~ 0,
                            TRUE ~ 1),
         streak = cumsum(change)) %>%
  group_by(streak) %>%
  mutate(num_Make = cumsum(flips == "Make")) %>%
  ungroup() %>%
  mutate(prior_makes_3 = (lag(num_Make) >= 3) & player == lag(player))

# Percent of all shots made

mean(hothand_df$flips == "Make")

# Percent of shots made conditional on at least 3 prior makes

by_player <- hothand_df %>%
  filter(prior_makes_3 == TRUE) %>%
  group_by(player) %>%
  summarize(prop_make = sum(result)/n()) %>%
  ungroup()

mean(by_player$prop_make)

# What if we treat them all as one player?

mean(filter(hothand_df, prior_makes_3 == TRUE)$flips == "Make")

write.csv(hothand_df, "./coin_data.csv")


# Mathematical sim
n <- 1e4

frac <- rep(1, n)/2^(1:n)
multi <- c(0:(n-1))

data <- tibble(frac, multi) %>%
  mutate(value = frac*multi)

sum(data$value)
