library(here)
library(tidyverse)
library(rstatix)

df6 <- read.csv(here("BIF4.20.csv"))
df7 <- read.csv(here("experimentData.csv"))

df6 <- df6 %>% 
  mutate(BIF1 = case_when(Q1 == 1 ~ 1, Q1 == 2 ~ 0)) %>%
  mutate(BIF2 = case_when(Q2 == 2 ~ 1, Q2 == 1 ~ 0)) %>%
  mutate(BIF3 = case_when(Q3 == 1 ~ 1, Q3 == 2 ~ 0)) %>%
  mutate(BIF4 = case_when(Q4 == 1 ~ 1, Q4 == 2 ~ 0)) %>%
  mutate(BIF5 = case_when(Q5 == 1 ~ 1, Q5 == 2 ~ 0)) %>%
  mutate(BIF6 = case_when(Q6 == 2 ~ 1, Q6 == 1 ~ 0)) %>%
  mutate(BIF7 = case_when(Q7 == 1 ~ 1, Q7 == 2 ~ 0)) %>%
  mutate(BIF8 = case_when(Q8 == 1 ~ 1, Q8 == 2 ~ 0)) %>%
  mutate(BIF9 = case_when(Q9 == 2 ~ 1, Q9 == 1 ~ 0)) %>%
  mutate(BIF10 = case_when(Q10 == 1 ~ 1, Q10 == 2 ~ 0)) %>%
  mutate(BIF11 = case_when(Q11 == 2 ~ 1, Q11 == 1 ~ 0)) %>%
  mutate(BIF12 = case_when(Q12 == 2 ~ 1, Q12 == 1 ~ 0)) %>%
  mutate(BIF13 = case_when(Q13 == 1 ~ 1, Q13 == 2 ~ 0)) %>%
  mutate(BIF14 = case_when(Q14 == 1 ~ 1, Q14 == 2 ~ 0)) %>%
  mutate(BIF15 = case_when(Q15 == 2 ~ 1, Q15 == 1 ~ 0)) %>%
  mutate(BIF16 = case_when(Q16 == 1 ~ 1, Q16 == 2 ~ 0)) %>%
  mutate(BIF17 = case_when(Q17 == 2 ~ 1, Q17 == 1 ~ 0)) %>%
  mutate(BIF18 = case_when(Q18 == 2 ~ 1, Q18 == 1 ~ 0)) %>%
  mutate(BIF19 = case_when(Q19 == 2 ~ 1, Q19 == 1 ~ 0)) %>%
  mutate(BIF20 = case_when(Q20 == 1 ~ 1, Q20 == 2 ~ 0)) %>%
  mutate(BIF21 = case_when(Q21 == 2 ~ 1, Q21 == 1 ~ 0)) %>%
  mutate(BIF22 = case_when(Q22 == 2 ~ 1, Q22 == 1 ~ 0)) %>%
  mutate(BIF23 = case_when(Q23 == 1 ~ 1, Q23 == 2 ~ 0)) %>%
  mutate(BIF24 = case_when(Q24 == 1 ~ 1, Q24 == 2 ~ 0)) %>%
  mutate(BIF25 = case_when(Q25 == 2 ~ 1, Q25 == 1 ~ 0)) 

dfBIF <- df6%>%
  mutate(BIF = rowSums(df6[,c('BIF1','BIF2','BIF3','BIF4','BIF5',
                                'BIF6','BIF7','BIF8','BIF9','BIF10',
                                'BIF11','BIF12','BIF13','BIF14','BIF15',
                                'BIF16','BIF17','BIF18','BIF19','BIF20',
                                'BIF21','BIF22','BIF23','BIF24','BIF25')], na.rm=TRUE)) %>% 
  convert_as_factor(ID)

df7 <- df7 %>% 
  mutate(gender = case_when(Gender == 1 ~ 'Female', Gender == 2 ~ 'Male')) %>% 
  mutate(med = case_when(Media == 1 ~ 'Paper', Media == 2 ~ 'iPad')) %>% 
  mutate(fre = case_when(Frequency == 1 ~ 'High', Frequency == 2 ~ 'Low')) %>% 
  gather(key = "Condition", value = "TrialRoute",LL,LM,LR,ML,MM,MR,RL,RM,RR) %>% 
  convert_as_factor(Condition, ID)

dflong <- df7 %>% 
  mutate(Second = case_when(Condition == 'LL' ~ 'L', 
                            Condition == 'LM' ~ 'L',
                            Condition == 'LR' ~ 'L',
                            Condition == 'ML' ~ 'M',
                            Condition == 'MM' ~ 'M',
                            Condition == 'MR' ~ 'M',
                            Condition == 'RL' ~ 'R',
                            Condition == 'RM' ~ 'R',
                            Condition == 'RR' ~ 'R')) %>%
  mutate(Region = case_when(Condition == 'LL' ~ 'L', 
                            Condition == 'ML' ~ 'L',
                            Condition == 'RL' ~ 'L',
                            Condition == 'LM' ~ 'M',
                            Condition == 'MM' ~ 'M',
                            Condition == 'RM' ~ 'M',
                            Condition == 'LR' ~ 'R',
                            Condition == 'MR' ~ 'R',
                            Condition == 'RR' ~ 'R')) %>% 
  convert_as_factor(fre, med, Second, Region)

df1 <-  dfBIF %>% 
  select(ID, BIF)

df2 <- dflong %>% 
  select(ID, fre, med, Second, Region, 
         gender, GameAdd, Effort, SATdetail, SATabstract,
         TrialRoute, SAT, Age, EnglishCET, EnglishGK, GameTime)

df <- left_join(df2, df1, by = "ID")

class(df$fre)
#compare the iPad group with paper group regarding SAT scores
t.test(SATdetail ~ Media, data = df)
t.test(SATabstract ~ Media, data = df)
t.test(SAT ~ Media, data = df)

dfsum <- df %>% 
  group_by(Second, Region) %>% 
  get_summary_stats(TrialRoute, type = "mean_sd")

#two-way repeated measure ANOVA
data1 <- df %>% 
  filter(!is.na(TrialRoute))

debug1 <- data1 %>% 
  filter(!is.na(TrialRoute)) %>% 
  group_by(fre,med) %>% 
  summarise(N=n())

debug2 <- data2 %>% 
  filter(!is.na(BIF)) %>% 
  group_by(fre, med) %>% 
  summarise(N=n())

data2 <- df %>% 
  filter(!is.na(BIF)) 

data3 <- df %>% 
  filter(!is.na(SAT)) %>% 
  group_by(fre,med) %>% 
  summarise(N=n())


aov1 <- aov(TrialRoute ~ med * fre * Second, data = data1)
summary(aov1)



aov2 <- aov(SAT ~ med * fre, data = data1)
summary(aov2)

aov3 <- aov(SATdetail ~ med * fre, data = data1)
summary(aov3)

aov4 <- aov(SATabstract ~ med * fre, data = data1)
summary(aov4)

#graph the fre*med on TrialRoute interaction effect
with(aov0, interaction.plot(dfanova$fre, dfanova$med, dfanova$TrialRoute,
                               ylim = c(0,1), 
                               ylab = "reading medium",
                               xlab = "Percentage of choosing the right route",
                               trace.label = "Frequency"))
