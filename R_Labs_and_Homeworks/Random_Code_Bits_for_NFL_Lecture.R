# Read in NFL kick data from 2005-15
nfl_kick <- read.csv("https://raw.githubusercontent.com/statsbylopez/StatsSports/master/Data/nfl_fg.csv") %>% 
  mutate(success = factor(Success, labels = c("Missed", "Made")))


# fit_0 <- lm(Success ~ Distance, data = nfl_kick) 

nfl_kick %>% 
  mutate(for_plot = case_when(Success == 1 ~ Success - 0.1,
                              TRUE ~ Success + 0.1)) %>% 
ggplot(aes(x = Distance, y = for_plot)) + 
  geom_jitter(width = 0, height = 0.1, alpha = 0.1) +
  theme(legend.position = "none") +
  labs(y = "Field Goal Made?",
       title = "NFL Field Goal Makes by Distance, 2005-15") +
  scale_y_continuous(breaks=c(0, 1), labels = c(0, 1)) +
  theme(axis.title = element_text(size = 16),
        plot.title = element_text(size = 20))
  
m1 <- glm(Success ~ Distance, data = nfl_kick, family = binomial(link = "logit")) 

nfl_kick$pred <- predict(m1, type = "response")

nfl_kick %>% 
  mutate(for_plot = case_when(Success == 1 ~ Success - 0.1,
                              TRUE ~ Success + 0.1)) %>% 
ggplot(aes(x = Distance, y = for_plot)) + 
  geom_jitter(width = 0, height = 0.1, alpha = 0.1) +
  theme(legend.position = "none") +
  labs(y = "Field Goal Made?",
       title = "NFL Field Goal Makes by Distance, 2005-15") +
  geom_smooth(aes(x = Distance, y = pred)) +
  scale_y_continuous(breaks=c(0, 0.5, 1), labels = c(0, 0.5, 1)) +
  theme(axis.title = element_text(size = 16),
        plot.title = element_text(size = 20))


nfl_kick %>% 
  mutate(buckets3yd = round(Distance/3)*3) %>%
  group_by(buckets3yd) %>% 
  summarize(pct_made = sum(Success)/n()) %>% 

  ggplot(aes(x = buckets3yd, y = pct_made)) + 
  geom_point() +
  labs(y = "Field Goal Made Pct",
       x = "Distance",
       title = "NFL Field Goal Makes by Distance, 2005-15") +
  geom_smooth(data = nfl_kick, aes(x = Distance, y = pred)) +
  scale_y_continuous(breaks=c(0, 0.5, 1), labels = c(0, 0.5, 1)) +
  theme(axis.title = element_text(size = 16),
        plot.title = element_text(size = 20))

df <- load_pbp(2021)
df2 <- df %>% 
  filter(home_team == "MIN", down == 3, ydstogo == 4, drive == 10)
