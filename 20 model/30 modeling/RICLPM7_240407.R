library(haven)
library(tidyverse)
library(lavaan)
library(magrittr)

TYPSleepHappy <- read_dta("10 data/TYPSleepHappy7_analysis.dta")

TYPSleepHappy %<>% ## %>% : pipe 將R_practice_row2(資料)連結到mutate()函數
  transform( 
    male = factor( 
      male,
      levels = c(0, 1), 
      labels = c("女", "男")
    )
  )
# RICLPM1 ----
RICLPM1 <- '
  # Create between components (random intercepts)
  RIx =~ 1*x1 + 1*x2 + 1*x3 + 1*x4 + 1*x5 + 1*x6 + 1*x7
  RIy =~ 1*y1 + 1*y2 + 1*y3 + 1*y4 + 1*y5 + 1*y6 + 1*y7
  
  # Create within-person centered variables
  wx1 =~ 1*x1
  wx2 =~ 1*x2
  wx3 =~ 1*x3 
  wx4 =~ 1*x4
  wx5 =~ 1*x5
  wx6 =~ 1*x6
  wx7 =~ 1*x7 
  wy1 =~ 1*y1
  wy2 =~ 1*y2
  wy3 =~ 1*y3
  wy4 =~ 1*y4
  wy5 =~ 1*y5
  wy6 =~ 1*y6
  wy7 =~ 1*y7

  # Estimate lagged effects between within-person centered variables
  wx2 + wy2 ~ wx1 + wy1
  wx3 + wy3 ~ wx2 + wy2
  wx4 + wy4 ~ wx3 + wy3
  wx5 + wy5 ~ wx4 + wy4
  wx6 + wy6 ~ wx5 + wy5
  wx7 + wy7 ~ wx6 + wy6
  
  # Estimate covariance between within-person centered variables at first wave
  wx1 ~~ wy1 # Covariance
  
  # Estimate covariances between residuals of within-person centered variables 
  # (i.e., innovations)
  wx2 ~~ wy2
  wx3 ~~ wy3
  wx4 ~~ wy4
  wx5 ~~ wy5
  wx6 ~~ wy6
  wx7 ~~ wy7
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy

  # Estimate (residual) variance of within-person centered variables
  wx1 ~~ wx1 # Variances
  wy1 ~~ wy1 
  wx2 ~~ wx2 # Residual variances
  wy2 ~~ wy2 
  wx3 ~~ wx3 
  wy3 ~~ wy3 
  wx4 ~~ wx4 
  wy4 ~~ wy4 
  wx5 ~~ wx5
  wy5 ~~ wy5
  wx6 ~~ wx6
  wy6 ~~ wy6 
  wx7 ~~ wx7
  wy7 ~~ wy7
'
RICLPM.m1 <- lavaan(RICLPM1, 
                      data = TYPSleepHappy, 
                      missing = 'ML', 
                      meanstructure = T, 
                      int.ov.free = T
) 

# RICLPM2 ----
RICLPM2 <- '
  # Create between components (random intercepts)
  RIx =~ 1*x1 + 1*x2 + 1*x3 + 1*x4 + 1*x5 + 1*x6 + 1*x7
  RIz =~ 1*z1 + 1*z2 + 1*z3 + 1*z4 + 1*z5 + 1*z6 + 1*z7
  
  # Create within-person centered variables
  wx1 =~ 1*x1
  wx2 =~ 1*x2
  wx3 =~ 1*x3 
  wx4 =~ 1*x4
  wx5 =~ 1*x5
  wx6 =~ 1*x6
  wx7 =~ 1*x7 
  wz1 =~ 1*z1
  wz2 =~ 1*z2
  wz3 =~ 1*z3
  wz4 =~ 1*z4
  wz5 =~ 1*z5
  wz6 =~ 1*z6
  wz7 =~ 1*z7

  # Estimate lagged effects between within-person centered variables
  wx2 + wz2 ~ wx1 + wz1
  wx3 + wz3 ~ wx2 + wz2
  wx4 + wz4 ~ wx3 + wz3
  wx5 + wz5 ~ wx4 + wz4
  wx6 + wz6 ~ wx5 + wz5
  wx7 + wz7 ~ wx6 + wz6
  
  # Estimate covariance between within-person centered variables at first wave
  wx1 ~~ wz1 # Covariance
  
  # Estimate covariances between residuals of within-person centered variables 
  # (i.e., innovations)
  wx2 ~~ wz2
  wx3 ~~ wz3
  wx4 ~~ wz4
  wx5 ~~ wz5
  wx6 ~~ wz6
  wx7 ~~ wz7
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIz ~~ RIz
  RIx ~~ RIz

  # Estimate (residual) variance of within-person centered variables
  wx1 ~~ wx1 # Variances
  wz1 ~~ wz1 
  wx2 ~~ wx2 # Residual variances
  wz2 ~~ wz2 
  wx3 ~~ wx3 
  wz3 ~~ wz3 
  wx4 ~~ wx4 
  wz4 ~~ wz4 
  wx5 ~~ wx5
  wz5 ~~ wz5
  wx6 ~~ wx6
  wz6 ~~ wz6 
  wx7 ~~ wx7
  wz7 ~~ wz7
'
RICLPM.m2 <- lavaan(RICLPM2, 
                    data = TYPSleepHappy, 
                    missing = 'ML', 
                    meanstructure = T, 
                    int.ov.free = T
) 

# summary ----
summary(RICLPM.m1, standardized = T, fit.measures=TRUE)
summary(RICLPM.m2, standardized = T, fit.measures=TRUE)


