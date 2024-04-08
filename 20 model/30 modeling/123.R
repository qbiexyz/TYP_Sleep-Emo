library(haven)
library(tidyverse)
library(lavaan)

TYPSleep_analysis <- read_dta("10 data/TYPSleep_analysis.dta")

model <- 
  '
  sleepP_w3 + happy_w3 ~ sleepP_w2 + happy_w2
  sleepP_w5 + happy_w5 ~ sleepP_w3 + happy_w3
  sleepP_w6 + happy_w6 ~ sleepP_w5 + happy_w5
  sleepP_w9 + happy_w9 ~ sleepP_w6 + happy_w6
  sleepP_w12 + happy_w12 ~ sleepP_w9 + happy_w9
  
  sleepP_w3 ~~ happy_w3
  sleepP_w5 ~~ happy_w5
  sleepP_w6 ~~ happy_w6
  sleepP_w9 ~~ happy_w9
  sleepP_w12 ~~ happy_w12
'

model <- 
  '
  sleepP_w3 + dep_w3 ~ sleepP_w2 + dep_w2
  sleepP_w5 + dep_w5 ~ sleepP_w3 + dep_w3
  sleepP_w6 + dep_w6 ~ sleepP_w5 + dep_w5
  sleepP_w9 + dep_w9 ~ sleepP_w6 + dep_w6
  sleepP_w12 + dep_w12 ~ sleepP_w9 + dep_w9
  
  sleepP_w3 ~~ dep_w3
  sleepP_w5 ~~ dep_w5
  sleepP_w6 ~~ dep_w6
  sleepP_w9 ~~ dep_w9
  sleepP_w12 ~~ dep_w12
'
model <- 
  '
  weekdayST_w3 + happy_w3 ~ weekdayST_w2 + happy_w2
  weekdayST_w5 + happy_w5 ~ weekdayST_w3 + happy_w3
  weekdayST_w6 + happy_w6 ~ weekdayST_w5 + happy_w5
  weekdayST_w9 + happy_w9 ~ weekdayST_w6 + happy_w6
  weekdayST_w12 + happy_w12 ~ weekdayST_w9 + happy_w9
  
  weekdayST_w3 ~~ happy_w3
  weekdayST_w5 ~~ happy_w5
  weekdayST_w6 ~~ happy_w6
  weekdayST_w9 ~~ happy_w9
  weekdayST_w12 ~~ happy_w12
'
m1 <- sem(model, data = TYPSleep_analysis, missing = "ML")

summary(m1, standardized = TRUE)