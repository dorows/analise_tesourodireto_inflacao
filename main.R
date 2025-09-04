base1 <- read.csv2("precotaxatesourodireto.csv")

library(dplyr)
library(lubridate)

base1 <- base1 %>%
  mutate(Data.Base = dmy(Data.Base)) %>% 
  filter(year(Data.Base) >= 2022)       

head(base1)

