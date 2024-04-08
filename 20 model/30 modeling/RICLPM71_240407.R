library(haven)
library(tidyverse)
library(lavaan)
library(magrittr)

TYPSleepHappy <- read_dta("10 data/TYPSleepHappy7_analysis.dta")

TYPSleepHappy %<>% 
  transform( 
    male = factor( 
      male,
      levels = c(0, 1), 
      labels = c("女", "男")
    )
  )

# RICLPM.f1 ----
RICLPM.f1 <- '
  # Create between components (random intercepts)
  RIx =~ 1*x1 + 1*x2 + 1*x3 + 1*x4 + 1*x5 + 1*x6 + 1*x7
  RIy =~ 1*y1 + 1*y2 + 1*y3 + 1*y4 + 1*y5 + 1*y6 + 1*y7
  
  # Create within-components with freely estimated factor loadings
  wx1 =~ NA*x1
  wx2 =~ NA*x2
  wx3 =~ NA*x3 
  wx4 =~ NA*x4
  wx5 =~ NA*x5
  wx6 =~ NA*x6
  wx7 =~ NA*x7
  wy1 =~ NA*y1
  wy2 =~ NA*y2
  wy3 =~ NA*y3
  wy4 =~ NA*y4
  wy5 =~ NA*y5
  wy6 =~ NA*y6
  wy7 =~ NA*y7

  # Estimate lagged effects between within-person centered variables 
  # (constrained)
  wx2 ~ a*wx1 + b*wy1 
  wy2 ~ c*wx1 + d*wy1
  wx3 ~ a*wx2 + b*wy2
  wy3 ~ c*wx2 + d*wy2
  wx4 ~ a*wx3 + b*wy3
  wy4 ~ c*wx3 + d*wy3
  wx5 ~ a*wx4 + b*wy4
  wy5 ~ c*wx4 + d*wy4
  wx6 ~ a*wx5 + b*wy5
  wy6 ~ c*wx5 + d*wy5
  wx7 ~ a*wx6 + b*wy6
  wy7 ~ c*wx6 + d*wy6

  # Label residual covariances
  wx2 ~~ rcov2*wy2
  wx3 ~~ rcov3*wy3
  wx4 ~~ rcov4*wy4 
  wx5 ~~ rcov5*wy5
  wx6 ~~ rcov6*wy6 
  wx7 ~~ rcov7*wy7
  
  # Estimate correlation between within-components at first wave
  wx1 ~~ cor1*wy1 
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIy ~~ RIy
  RIx ~~ RIy
  
  # Set variances of within-components at first wave to 1
  wx1 ~~ 1*wx1
  wy1 ~~ 1*wy1
  
  # Label residual variances
  wx2 ~~ rvx2*wx2 
  wy2 ~~ rvy2*wy2 
  wx3 ~~ rvx3*wx3 
  wy3 ~~ rvy3*wy3 
  wx4 ~~ rvx4*wx4 
  wy4 ~~ rvy4*wy4 
  wx5 ~~ rvx5*wx5
  wy5 ~~ rvy5*wy5
  wx6 ~~ rvx6*wx6
  wy6 ~~ rvy6*wy6 
  wx7 ~~ rvx7*wx7
  wy7 ~~ rvy7*wy7

  # Constrain grand means over time
  x1 + x2 + x3 + x4 + x5 + x6 + x7 ~ mx*1
  y1 + y2 + y3 + y4 + y5 + y6 + y7 ~ my*1
  
  # Compute correlations of within-components at each wave
  cor2 := a*c + b*d + a*d*cor1 + b*c*cor1 + rcov2
  cor3 := a*c + b*d + a*d*cor2 + b*c*cor2 + rcov3
  cor4 := a*c + b*d + a*d*cor3 + b*c*cor3 + rcov4
  cor5 := a*c + b*d + a*d*cor4 + b*c*cor4 + rcov5
  cor6 := a*c + b*d + a*d*cor5 + b*c*cor5 + rcov6
  
  # Contrain residual variances of within-components such that variance of each 
  # within-component equals 1
  rvx2 == 1 - (a*a + b*b + 2*a*b*cor1)
  rvy2 == 1 - (c*c + d*d + 2*c*d*cor1)
  rvx3 == 1 - (a*a + b*b + 2*a*b*cor2)
  rvy3 == 1 - (c*c + d*d + 2*c*d*cor2)
  rvx4 == 1 - (a*a + b*b + 2*a*b*cor3)
  rvy4 == 1 - (c*c + d*d + 2*c*d*cor3)
  rvx5 == 1 - (a*a + b*b + 2*a*b*cor4)
  rvy5 == 1 - (c*c + d*d + 2*c*d*cor4)
  rvx6 == 1 - (a*a + b*b + 2*a*b*cor5)
  rvy6 == 1 - (c*c + d*d + 2*c*d*cor5)
  rvx7 == 1 - (a*a + b*b + 2*a*b*cor6)
  rvy7 == 1 - (c*c + d*d + 2*c*d*cor6)
'
RICLPM.f1.m <- lavaan(RICLPM.f1, 
                      data = TYPSleepHappy, 
                      missing = 'ML', 
                      meanstructure = T, 
                      int.ov.free = T
) 

# RICLPM.f2 ----
RICLPM.f2 <- '
  # Create between components (random intercepts)
  RIx =~ 1*x1 + 1*x2 + 1*x3 + 1*x4 + 1*x5 + 1*x6 + 1*x7
  RIz =~ 1*z1 + 1*z2 + 1*z3 + 1*z4 + 1*z5 + 1*z6 + 1*z7
  
  # Create within-components with freelz estimated factor loadings
  wx1 =~ NA*x1
  wx2 =~ NA*x2
  wx3 =~ NA*x3 
  wx4 =~ NA*x4
  wx5 =~ NA*x5
  wx6 =~ NA*x6
  wx7 =~ NA*x7
  wz1 =~ NA*z1
  wz2 =~ NA*z2
  wz3 =~ NA*z3
  wz4 =~ NA*z4
  wz5 =~ NA*z5
  wz6 =~ NA*z6
  wz7 =~ NA*z7

  # Estimate lagged effects between within-person centered variables 
  # (constrained)
  wx2 ~ a*wx1 + b*wz1 
  wz2 ~ c*wx1 + d*wz1
  wx3 ~ a*wx2 + b*wz2
  wz3 ~ c*wx2 + d*wz2
  wx4 ~ a*wx3 + b*wz3
  wz4 ~ c*wx3 + d*wz3
  wx5 ~ a*wx4 + b*wz4
  wz5 ~ c*wx4 + d*wz4
  wx6 ~ a*wx5 + b*wz5
  wz6 ~ c*wx5 + d*wz5
  wx7 ~ a*wx6 + b*wz6
  wz7 ~ c*wx6 + d*wz6

  # Label residual covariances
  wx2 ~~ rcov2*wz2
  wx3 ~~ rcov3*wz3
  wx4 ~~ rcov4*wz4 
  wx5 ~~ rcov5*wz5
  wx6 ~~ rcov6*wz6 
  wx7 ~~ rcov7*wz7
  
  # Estimate correlation between within-components at first wave
  wx1 ~~ cor1*wz1 
  
  # Estimate variance and covariance of random intercepts
  RIx ~~ RIx
  RIz ~~ RIz
  RIx ~~ RIz
  
  # Set variances of within-components at first wave to 1
  wx1 ~~ 1*wx1
  wz1 ~~ 1*wz1
  
  # Label residual variances
  wx2 ~~ rvx2*wx2 
  wz2 ~~ rvz2*wz2 
  wx3 ~~ rvx3*wx3 
  wz3 ~~ rvz3*wz3 
  wx4 ~~ rvx4*wx4 
  wz4 ~~ rvz4*wz4 
  wx5 ~~ rvx5*wx5
  wz5 ~~ rvz5*wz5
  wx6 ~~ rvx6*wx6
  wz6 ~~ rvz6*wz6 
  wx7 ~~ rvx7*wx7
  wz7 ~~ rvz7*wz7

  # Constrain grand means over time
  x1 + x2 + x3 + x4 + x5 + x6 + x7 ~ mx*1
  z1 + z2 + z3 + z4 + z5 + z6 + z7 ~ mz*1
  
  # Compute correlations of within-components at each wave
  cor2 := a*c + b*d + a*d*cor1 + b*c*cor1 + rcov2
  cor3 := a*c + b*d + a*d*cor2 + b*c*cor2 + rcov3
  cor4 := a*c + b*d + a*d*cor3 + b*c*cor3 + rcov4
  cor5 := a*c + b*d + a*d*cor4 + b*c*cor4 + rcov5
  cor6 := a*c + b*d + a*d*cor5 + b*c*cor5 + rcov6
  
  # Contrain residual variances of within-components such that variance of each 
  # within-component equals 1
  rvx2 == 1 - (a*a + b*b + 2*a*b*cor1)
  rvz2 == 1 - (c*c + d*d + 2*c*d*cor1)
  rvx3 == 1 - (a*a + b*b + 2*a*b*cor2)
  rvz3 == 1 - (c*c + d*d + 2*c*d*cor2)
  rvx4 == 1 - (a*a + b*b + 2*a*b*cor3)
  rvz4 == 1 - (c*c + d*d + 2*c*d*cor3)
  rvx5 == 1 - (a*a + b*b + 2*a*b*cor4)
  rvz5 == 1 - (c*c + d*d + 2*c*d*cor4)
  rvx6 == 1 - (a*a + b*b + 2*a*b*cor5)
  rvz6 == 1 - (c*c + d*d + 2*c*d*cor5)
  rvx7 == 1 - (a*a + b*b + 2*a*b*cor6)
  rvz7 == 1 - (c*c + d*d + 2*c*d*cor6)
'
RICLPM.f2.m <- lavaan(RICLPM.f2, 
                      data = TYPSleepHappy, 
                      missing = 'ML', 
                      meanstructure = T, 
                      int.ov.free = T
) 

# summary ----
summary(RICLPM.f1.m, standardized = T, fit.measures=TRUE)

summary(RICLPM.f2.m, standardized = T, fit.measures=TRUE)



