library(haven)
library(tidyverse)
library(lavaan)

TYPSleepHappy <- read_dta("10 data/TYPSleepHappy7_analysis.dta")

CLPM1 <- 
  '
  x2 + y2 ~ x1 + y1
  x3 + y3 ~ x2 + y2
  x4 + y4 ~ x3 + y3
  x5 + y5 ~ x4 + y4
  x6 + y6 ~ x5 + y5
  x7 + y7 ~ x6 + y6


  x1 ~~ y1
  x2 ~~ y2
  x3 ~~ y3
  x4 ~~ y4
  x5 ~~ y5
  x6 ~~ y6
  x7 ~~ y7
'

CLPM.m1 <- sem(CLPM1, data = TYPSleepHappy, missing = "ML")

CLPM2 <- 
  '
  x2 + z2 ~ x1 + z1
  x3 + z3 ~ x2 + z2
  x4 + z4 ~ x3 + z3
  x5 + z5 ~ x4 + z4
  x6 + z6 ~ x5 + z5
  x7 + z7 ~ x6 + z6


  x1 ~~ z1
  x2 ~~ z2
  x3 ~~ z3
  x4 ~~ z4
  x5 ~~ z5
  x6 ~~ z6
  x7 ~~ z7
'

CLPM.m2 <- sem(CLPM2, data = TYPSleepHappy, missing = "ML")

summary(CLPM.m1, standardized = TRUE)
summary(CLPM.m2, standardized = TRUE)
