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


# GCLM1  ----
GCLM1 <- '
#unit effects
eta_x =~ x7 + x6 + x5 + x4 + x3 + x2 + x1
eta_y =~ y7 + y6 + y5 + y4 + y3 + y2 + y1

#impulses
u_x1 =~ x1
x1 ~~ 0*x1
u_x2 =~ x2
x2 ~~ 0*x2
u_x3 =~ x3
x3 ~~ 0*x3
u_x4 =~ x4
x4 ~~ 0*x4
u_x5 =~ x5
x5 ~~ 0*x5
u_x6 =~ x6
x6 ~~ 0*x6
u_x7 =~ x7
x7 ~~ 0*x7
u_y1 =~ y1
y1 ~~ 0*y1
u_y2 =~ y2
y2 ~~ 0*y2
u_y3 =~ y3
y3 ~~ 0*y3
u_y4 =~ y4
y4 ~~ 0*y4
u_y5 =~ y5
y5 ~~ 0*y5
u_y6 =~ y6
y6 ~~ 0*y6
u_y7 =~ y7
y7 ~~ 0*y7

#regressions
x7 ~ a*x6 + b*y6 + c*u_x6 + d*u_y6
x6 ~ a*x5 + b*y5 + c*u_x5 + d*u_y5 
x5 ~ a*x4 + b*y4 + c*u_x4 + d*u_y4 
x4 ~ a*x3 + b*y3 + c*u_x3 + d*u_y3 
x3 ~ a*x2 + b*y2 + c*u_x2 + d*u_y2 
x2 ~ a*x1 + b*y1 + c*u_x1 + d*u_y1 
y7 ~ f*x6 + g*y6 + h*u_x6 + i*u_y6
y6 ~ f*x5 + g*y5 + h*u_x5 + i*u_y5 
y5 ~ f*x4 + g*y4 + h*u_x4 + i*u_y4 
y4 ~ f*x3 + g*y3 + h*u_x3 + i*u_y3 
y3 ~ f*x2 + g*y2 + h*u_x2 + i*u_y2 
y2 ~ f*x1 + g*y1 + h*u_x1 + i*u_y1 

#co-movements
u_x1 ~~ u_y1
u_x2 ~~ u_y2
u_x3 ~~ u_y3
u_x4 ~~ u_y4
u_x5 ~~ u_y5
u_x6 ~~ u_y6
u_x7 ~~ u_y7

#restrictions
u_x1 ~~ 0*eta_x + 0*eta_y + 0*u_x2 + 0*u_x3 + 0*u_x4 + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_y2 + 0*u_y3 + 0*u_y4 + 0*u_y5 + 0*u_y6+ 0*u_y7
u_x2 ~~ 0*eta_x + 0*eta_y +  0*u_x3 + 0*u_x4 + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_y1 + 0*u_y3 + 0*u_y4 + 0*u_y5 + 0*u_y6 + 0*u_y7
u_x3 ~~ 0*eta_x + 0*eta_y +  0*u_x4 + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_y1 + 0*u_y2 + 0*u_y4 + 0*u_y5 + 0*u_y6 + 0*u_y7
u_x4 ~~ 0*eta_x + 0*eta_y + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_y1 + 0*u_y2 + 0*u_y3 + 0*u_y5 + 0*u_y6 + 0*u_y7
u_x5 ~~ 0*eta_x + 0*eta_y + 0*u_x6 + 0*u_x7 +
  0*u_y1 + 0*u_y2 + 0*u_y3 + 0*u_y4 + 0*u_y6 + 0*u_y7
u_x6 ~~ 0*eta_x + 0*eta_y + 0*u_x7
  + 0*u_y1 + 0*u_y2 + 0*u_y3 + 0*u_y4 + 0*u_y5 + 0*u_y7
u_x7 ~~ 0*eta_x + 0*eta_y + 0*u_y1 + 0*u_y2 + 0*u_y3 + 0*u_y4 + 0*u_y5 + 0*u_y6

u_y1 ~~ 0*eta_x + 0*eta_y + 0*u_y2 + 0*u_y3 + 0*u_y4 + 0*u_y5 + 0*u_y6 + 0*u_y7
u_y2 ~~ 0*eta_x + 0*eta_y + 0*u_y3 + 0*u_y4 + 0*u_y5 + 0*u_y6 + 0*u_y7
u_y3 ~~ 0*eta_x + 0*eta_y + 0*u_y4 + 0*u_y5 + 0*u_y6 + 0*u_y7
u_y4 ~~ 0*eta_x + 0*eta_y + 0*u_y5 + 0*u_y6 + 0*u_y7 
u_y5 ~~ 0*eta_x + 0*eta_y + 0*u_y6 + 0*u_y7 
u_y6 ~~ 0*eta_x + 0*eta_y + 0*u_y7 
u_y7 ~~ 0*eta_x + 0*eta_y
'

#fit the model and show output:
GCLM.m1<-sem(GCLM1, data = TYPSleepHappy)

# GCLM2  ----
GCLM2 <- '
#unit effects
eta_x =~ x7 + x6 + x5 + x4 + x3 + x2 + x1
eta_z =~ z7 + z6 + z5 + z4 + z3 + z2 + z1

#impulses
u_x1 =~ x1
x1 ~~ 0*x1
u_x2 =~ x2
x2 ~~ 0*x2
u_x3 =~ x3
x3 ~~ 0*x3
u_x4 =~ x4
x4 ~~ 0*x4
u_x5 =~ x5
x5 ~~ 0*x5
u_x6 =~ x6
x6 ~~ 0*x6
u_x7 =~ x7
x7 ~~ 0*x7
u_z1 =~ z1
z1 ~~ 0*z1
u_z2 =~ z2
z2 ~~ 0*z2
u_z3 =~ z3
z3 ~~ 0*z3
u_z4 =~ z4
z4 ~~ 0*z4
u_z5 =~ z5
z5 ~~ 0*z5
u_z6 =~ z6
z6 ~~ 0*z6
u_z7 =~ z7
z7 ~~ 0*z7

#regressions
x7 ~ a*x6 + b*z6 + c*u_x6 + d*u_z6
x6 ~ a*x5 + b*z5 + c*u_x5 + d*u_z5 
x5 ~ a*x4 + b*z4 + c*u_x4 + d*u_z4 
x4 ~ a*x3 + b*z3 + c*u_x3 + d*u_z3 
x3 ~ a*x2 + b*z2 + c*u_x2 + d*u_z2 
x2 ~ a*x1 + b*z1 + c*u_x1 + d*u_z1 
z7 ~ f*x6 + g*z6 + h*u_x6 + i*u_z6
z6 ~ f*x5 + g*z5 + h*u_x5 + i*u_z5 
z5 ~ f*x4 + g*z4 + h*u_x4 + i*u_z4 
z4 ~ f*x3 + g*z3 + h*u_x3 + i*u_z3 
z3 ~ f*x2 + g*z2 + h*u_x2 + i*u_z2 
z2 ~ f*x1 + g*z1 + h*u_x1 + i*u_z1 

#co-movements
u_x1 ~~ u_z1
u_x2 ~~ u_z2
u_x3 ~~ u_z3
u_x4 ~~ u_z4
u_x5 ~~ u_z5
u_x6 ~~ u_z6
u_x7 ~~ u_z7

#restrictions
u_x1 ~~ 0*eta_x + 0*eta_z + 0*u_x2 + 0*u_x3 + 0*u_x4 + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_z2 + 0*u_z3 + 0*u_z4 + 0*u_z5 + 0*u_z6+ 0*u_z7
u_x2 ~~ 0*eta_x + 0*eta_z +  0*u_x3 + 0*u_x4 + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_z1 + 0*u_z3 + 0*u_z4 + 0*u_z5 + 0*u_z6 + 0*u_z7
u_x3 ~~ 0*eta_x + 0*eta_z +  0*u_x4 + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_z1 + 0*u_z2 + 0*u_z4 + 0*u_z5 + 0*u_z6 + 0*u_z7
u_x4 ~~ 0*eta_x + 0*eta_z + 0*u_x5 + 0*u_x6 + 0*u_x7 +
  0*u_z1 + 0*u_z2 + 0*u_z3 + 0*u_z5 + 0*u_z6 + 0*u_z7
u_x5 ~~ 0*eta_x + 0*eta_z + 0*u_x6 + 0*u_x7 +
  0*u_z1 + 0*u_z2 + 0*u_z3 + 0*u_z4 + 0*u_z6 + 0*u_z7
u_x6 ~~ 0*eta_x + 0*eta_z + 0*u_x7
  + 0*u_z1 + 0*u_z2 + 0*u_z3 + 0*u_z4 + 0*u_z5 + 0*u_z7
u_x7 ~~ 0*eta_x + 0*eta_z + 0*u_z1 + 0*u_z2 + 0*u_z3 + 0*u_z4 + 0*u_z5 + 0*u_z6

u_z1 ~~ 0*eta_x + 0*eta_z + 0*u_z2 + 0*u_z3 + 0*u_z4 + 0*u_z5 + 0*u_z6 + 0*u_z7
u_z2 ~~ 0*eta_x + 0*eta_z + 0*u_z3 + 0*u_z4 + 0*u_z5 + 0*u_z6 + 0*u_z7
u_z3 ~~ 0*eta_x + 0*eta_z + 0*u_z4 + 0*u_z5 + 0*u_z6 + 0*u_z7
u_z4 ~~ 0*eta_x + 0*eta_z + 0*u_z5 + 0*u_z6 + 0*u_z7 
u_z5 ~~ 0*eta_x + 0*eta_z + 0*u_z6 + 0*u_z7 
u_z6 ~~ 0*eta_x + 0*eta_z + 0*u_z7 
u_z7 ~~ 0*eta_x + 0*eta_z
'

#fit the model and show output:
GCLM.m2<-sem(GCLM2, data = TYPSleepHappy)


# summary ----
summary(GCLM.m1, standardized = T, fit.measures=TRUE)
summary(GCLM.m2, standardized = T, fit.measures=TRUE)

