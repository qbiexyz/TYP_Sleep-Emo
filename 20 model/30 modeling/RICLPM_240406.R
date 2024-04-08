

library(haven)
library(tidyverse)
library(lavaan)


TYPSleep_analysis <- read_dta("10 data/TYPSleep_analysis.dta")

RICLPM.ext1 <- '
  # Create between components (random intercepts)
  RIx =~ 1*weekdayST_w2 + 1*weekdayST_w3 + 1*weekdayST_w5 + 1*weekdayST_w6 
       + 1*weekdayST_w9 + 1*weekdayST_w12
  RIy =~ 1*dep_w2 + 1*dep_w3 + 1*dep_w5 + 1*dep_w6 + 1*dep_w9 + 1*dep_w12
  
  # Create within-person centered variables
  wweekdayST_w2 =~ 1*weekdayST_w2
  wweekdayST_w3 =~ 1*weekdayST_w3
  wweekdayST_w5 =~ 1*weekdayST_w5 
  wweekdayST_w6 =~ 1*weekdayST_w6
  wweekdayST_w9 =~ 1*weekdayST_w9
  wweekdayST_w12 =~ 1*weekdayST_w12
  wdep_w2 =~ 1*dep_w2
  wdep_w3 =~ 1*dep_w3
  wdep_w5 =~ 1*dep_w5
  wdep_w6 =~ 1*dep_w6
  wdep_w9 =~ 1*dep_w9
  wdep_w12 =~ 1*dep_w12
  
  # Estimate lagged effects between within-person centered variables
  weekdayST_w3 + dep_w3 ~ weekdayST_w2 + dep_w2
  weekdayST_w5 + dep_w5 ~ weekdayST_w3 + dep_w3
  weekdayST_w6 + dep_w6 ~ weekdayST_w5 + dep_w5
  weekdayST_w9 + dep_w9 ~ weekdayST_w6 + dep_w6
  weekdayST_w12 + dep_w12 ~ weekdayST_w9 + dep_w9

  # Estimate covariance between within-person centered variables at first wave
  weekdayST_w2 ~~ dep_w2 # Covariance
  
  # Estimate covariances between residuals of within-person centered variables 
  # (i.e., innovations)
  weekdayST_w3 ~~ dep_w3
  weekdayST_w5 ~~ dep_w5
  weekdayST_w6 ~~ dep_w6
  weekdayST_w9 ~~ dep_w9
  weekdayST_w12 ~~ dep_w12
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy

  # Estimate (residual) variance of within-person centered variables
  wweekdayST_w2 ~~ wweekdayST_w2 # Variances
  wdep_w2 ~~ wdep_w2 
  wweekdayST_w3 ~~ wweekdayST_w3 # Residual variances
  wdep_w3 ~~ wdep_w3 
  wweekdayST_w5 ~~ wweekdayST_w5 
  wdep_w5 ~~ wdep_w5 
  wweekdayST_w6 ~~ wweekdayST_w6 
  wdep_w6 ~~ wdep_w6 
  wweekdayST_w9 ~~ wweekdayST_w9
  wdep_w9 ~~ wdep_w9
  wweekdayST_w12 ~~ wweekdayST_w12
  wdep_w12 ~~ wdep_w12
'
RICLPM.ext1.fit <- lavaan(RICLPM.ext1, 
                          data = TYPSleep_analysis, 
                          missing = 'ML', 
                          meanstructure = T, 
                          int.ov.free = T
) 

summary(RICLPM.ext1.fit, standardized = T)


RICLPM.happy <- '
  # Create between components (random intercepts)
  RIx =~ 1*TST_w2 + 1*TST_w3 + 1*TST_w5 + 1*TST_w6 + 1*TST_w9 + 1*TST_w12
  RIy =~ 1*happy_w2 + 1*happy_w3 + 1*happy_w5 + 1*happy_w6 + 1*happy_w9 + 1*happy_w12
  
  # Create within-person centered variables
  wTST_w2 =~ 1*TST_w2
  wTST_w3 =~ 1*TST_w3
  wTST_w5 =~ 1*TST_w5 
  wTST_w6 =~ 1*TST_w6
  wTST_w9 =~ 1*TST_w9
  wTST_w12 =~ 1*TST_w12
  whappy_w2 =~ 1*happy_w2
  whappy_w3 =~ 1*happy_w3
  whappy_w5 =~ 1*happy_w5
  whappy_w6 =~ 1*happy_w6
  whappy_w9 =~ 1*happy_w9
  whappy_w12 =~ 1*happy_w12
  
  # Estimate lagged effects between within-person centered variables
  wTST_w3 + whappy_w3 ~ wTST_w2 + whappy_w2
  wTST_w5 + whappy_w5 ~ wTST_w3 + whappy_w3
  wTST_w6 + whappy_w6 ~ wTST_w5 + whappy_w5
  wTST_w9 + whappy_w9 ~ wTST_w6 + whappy_w6
  wTST_w12 + whappy_w12 ~ wTST_w9 + whappy_w9

  # Estimate covariance between within-person centered variables at first wave
  wTST_w2 ~~ whappy_w2 # Covariance
  
  # Estimate covariances between residuals of within-person centered variables 
  # (i.e., innovations)
  wTST_w3 ~~ whappy_w3
  wTST_w5 ~~ whappy_w5
  wTST_w6 ~~ whappy_w6
  wTST_w9 ~~ whappy_w9
  wTST_w12 ~~ whappy_w12
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy

  # Estimate (residual) variance of within-person centered variables
  wTST_w2 ~~ wTST_w2 # Variances
  whappy_w2 ~~ whappy_w2 
  wTST_w3 ~~ wTST_w3 # Residual variances
  whappy_w3 ~~ whappy_w3 
  wTST_w5 ~~ wTST_w5 
  whappy_w5 ~~ whappy_w5 
  wTST_w6 ~~ wTST_w6 
  whappy_w6 ~~ whappy_w6 
  wTST_w9 ~~ wTST_w9
  whappy_w9 ~~ whappy_w9
  wTST_w12 ~~ wTST_w12
  whappy_w12 ~~ whappy_w12
'
RICLPM.happy.fit <- lavaan(RICLPM.happy, 
                          data = TYPSleep_analysis, 
                          missing = 'ML', 
                          meanstructure = T, 
                          int.ov.free = T
) 

summary(RICLPM.happy.fit, standardized = T)


RICLPM1.happy <- '
  # Create between components (random intercepts)
  RIx =~ 1*sleepP_w2 + 1*sleepP_w3 + 1*sleepP_w5 + 1*sleepP_w6 + 1*sleepP_w9 + 1*sleepP_w12
  RIy =~ 1*happy_w2 + 1*happy_w3 + 1*happy_w5 + 1*happy_w6 + 1*happy_w9 + 1*happy_w12
  
  # Create within-person centered variables
  wsleepP_w2 =~ 1*sleepP_w2
  wsleepP_w3 =~ 1*sleepP_w3
  wsleepP_w5 =~ 1*sleepP_w5 
  wsleepP_w6 =~ 1*sleepP_w6
  wsleepP_w9 =~ 1*sleepP_w9
  wsleepP_w12 =~ 1*sleepP_w12
  whappy_w2 =~ 1*happy_w2
  whappy_w3 =~ 1*happy_w3
  whappy_w5 =~ 1*happy_w5
  whappy_w6 =~ 1*happy_w6
  whappy_w9 =~ 1*happy_w9
  whappy_w12 =~ 1*happy_w12
  
  # Estimate lagged effects between within-person centered variables
  sleepP_w3 + happy_w3 ~ sleepP_w2 + happy_w2 
  sleepP_w5 + happy_w5 ~ sleepP_w3 + happy_w3 
  sleepP_w6 + happy_w6 ~ sleepP_w5 + happy_w5 
  sleepP_w9 + happy_w9 ~ sleepP_w6 + happy_w6 
  sleepP_w12 + happy_w12 ~ sleepP_w9 + happy_w9

  # Estimate covariance between within-person centered variables at first wave
  wsleepP_w2 ~~ whappy_w2 # Covariance
  
  # Estimate covariances between residuals of within-person centered variables 
  # (i.e., innovations)
  wsleepP_w3 ~~ whappy_w3
  wsleepP_w5 ~~ whappy_w5
  wsleepP_w6 ~~ whappy_w6
  wsleepP_w9 ~~ whappy_w9
  wsleepP_w12 ~~ whappy_w12
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy

  # Estimate (residual) variance of within-person centered variables
  wsleepP_w2 ~~ wsleepP_w2 # Variances
  whappy_w2 ~~ whappy_w2 
  wsleepP_w3 ~~ wsleepP_w3 # Residual variances
  whappy_w3 ~~ whappy_w3 
  wsleepP_w5 ~~ wsleepP_w5 
  whappy_w5 ~~ whappy_w5 
  wsleepP_w6 ~~ wsleepP_w6 
  whappy_w6 ~~ whappy_w6 
  wsleepP_w9 ~~ wsleepP_w9
  whappy_w9 ~~ whappy_w9
  wsleepP_w12 ~~ wsleepP_w12
  whappy_w12 ~~ whappy_w12
'
RICLPM.happy.fit <- lavaan(RICLPM1.happy, 
                           data = TYPSleep_analysis, 
                           missing = 'ML', 
                           meanstructure = T, 
                           int.ov.free = T
) 

summary(RICLPM.happy.fit, standardized = T)

library(semTools)
monteCarloCI(RICLPM.happy.fit)
