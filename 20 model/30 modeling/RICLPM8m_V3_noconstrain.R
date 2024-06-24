library(haven)
library(tidyverse)
library(lavaan)
library(magrittr)
library(lavaanPlot)

TYPSleepHappy <- read_dta("10 data/TYPSleepHappy9m_analysis.dta")

TYPSleepHappy %<>%
  transform( 
    male = factor( 
      male,
      levels = c(0, 1), 
      labels = c("女", "男")
    )
  )
# RICLPM1 ----
RICLPM.nc <- '
  # Create between components (random intercepts)
  RIx =~ 1*x1 + 1*x2 + 1*x3 + 1*x5 + 1*x6 + 1*x7 + 1*x8 + 1*x9
  RIy =~ 1*y1 + 1*y2 + 1*y3 + 1*y5 + 1*y6 + 1*y7 + 1*y8 + 1*y9
  RIz =~ 1*z1 + 1*z2 + 1*z3 + 1*z5 + 1*z6 + 1*z7 + 1*z8 + 1*z9
  
  RIx + RIy + RIz ~ male + agey + peduc + urban # Constrained over time. 
  
  # Create within-person centered variables
  wx1 =~ 1*x1
  wx2 =~ 1*x2
  wx3 =~ 1*x3 
  wx5 =~ 1*x5
  wx6 =~ 1*x6
  wx7 =~ 1*x7 
  wx8 =~ 1*x8
  wx9 =~ 1*x9
  
  wy1 =~ 1*y1
  wy2 =~ 1*y2
  wy3 =~ 1*y3
  wy5 =~ 1*y5
  wy6 =~ 1*y6
  wy7 =~ 1*y7
  wy8 =~ 1*y8
  wy9 =~ 1*y9
  
  wz1 =~ 1*z1
  wz2 =~ 1*z2
  wz3 =~ 1*z3
  wz5 =~ 1*z5
  wz6 =~ 1*z6
  wz7 =~ 1*z7
  wz8 =~ 1*z8
  wz9 =~ 1*z9

  # Estimate lagged effects between within-person centered variables
  wx2 + wy2 + wz2 ~ wx1 + wy1 + wz1
  wx3 + wy3 + wz3 ~ wx2 + wy2 + wz2
  wx5 + wy5 + wz5 ~ wx3 + wy3 + wz3
  wx6 + wy6 + wz6 ~ wx5 + wy5 + wz5
  wx7 + wy7 + wz7 ~ wx6 + wy6 + wz6
  wx8 + wy8 + wz8 ~ wx7 + wy7 + wz7
  wx9 + wy9 + wz9 ~ wx8 + wy8 + wz8
  
  # Estimate covariance between within-person centered variables at first wave
  wx1 ~~ wy1 # Covariance
  wx1 ~~ wz1
  wy1 ~~ wz1

  # Estimate covariances between residuals of within-person centered variables 
  # (i.e., innovations)
  wx2 ~~ wy2
  wx3 ~~ wy3
  wx5 ~~ wy5
  wx6 ~~ wy6
  wx7 ~~ wy7
  wx8 ~~ wy8
  wx9 ~~ wy9

  wx2 ~~ wz2
  wx3 ~~ wz3
  wx5 ~~ wz5
  wx6 ~~ wz6
  wx7 ~~ wz7
  wx8 ~~ wz8
  wx9 ~~ wz9
  
  wy2 ~~ wz2
  wy3 ~~ wz3
  wy5 ~~ wz5
  wy6 ~~ wz6
  wy7 ~~ wz7
  wy8 ~~ wz8
  wy9 ~~ wz9
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIy ~~ RIy
  RIz ~~ RIz
  RIx ~~ RIy
  RIx ~~ RIz
  RIy ~~ RIz

  # Estimate (residual) variance of within-person centered variables
  wx1 ~~ wx1 # Variances
  wy1 ~~ wy1 
  wx2 ~~ wx2 # Residual variances
  wy2 ~~ wy2 
  wx3 ~~ wx3 
  wy3 ~~ wy3 
  wx5 ~~ wx5
  wy5 ~~ wy5
  wx6 ~~ wx6
  wy6 ~~ wy6 
  wx7 ~~ wx7
  wy7 ~~ wy7
  wx8 ~~ wx8
  wy8 ~~ wy8 
  wx9 ~~ wx9
  wy9 ~~ wy9
  
  wz1 ~~ wz1 
  wz2 ~~ wz2 
  wz3 ~~ wz3 
  wz5 ~~ wz5
  wz6 ~~ wz6 
  wz7 ~~ wz7
  wz8 ~~ wz8 
  wz9 ~~ wz9 
'
RICLPM.Mnc <- lavaan(RICLPM.nc, 
                     data = TYPSleepHappy, 
                     missing = 'ML', 
                     meanstructure = T, 
                     int.ov.free = T
) 
summary(RICLPM.Mnc, standardized = T, fit.measures=TRUE)
