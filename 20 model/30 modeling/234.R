library(lavaan)

TYPSleep_analysis <- read_dta("10 data/TYPSleep_analysis.dta")

#specify the model:
swb.mod <- '
#unit effects
eta_x =~ happy_w12 + happy_w9 + happy_w6 + happy_w5 + happy_w3 + happy_w2
eta_y =~ sleepP_w12 + sleepP_w9 + sleepP_w6 + sleepP_w5 + sleepP_w3 + sleepP_w2

#impulses
u_happy_w2 =~ happy_w2
happy_w2 ~~ 0*happy_w2
u_happy_w3 =~ happy_w3
happy_w3 ~~ 0*happy_w3
u_happy_w5 =~ happy_w5
happy_w5 ~~ 0*happy_w5
u_happy_w6 =~ happy_w6
happy_w6 ~~ 0*happy_w6
u_happy_w9 =~ happy_w9
happy_w9 ~~ 0*happy_w9
u_happy_w12 =~ happy_w12
happy_w12 ~~ 0*happy_w12
u_sleepP_w2 =~ sleepP_w2
sleepP_w2 ~~ 0*sleepP_w2
u_sleepP_w3 =~ sleepP_w3
sleepP_w3 ~~ 0*sleepP_w3
u_sleepP_w5 =~ sleepP_w5
sleepP_w5 ~~ 0*sleepP_w5
u_sleepP_w6 =~ sleepP_w6
sleepP_w6 ~~ 0*sleepP_w6
u_sleepP_w9 =~ sleepP_w9
sleepP_w9 ~~ 0*sleepP_w9
u_sleepP_w12 =~ sleepP_w12
sleepP_w12 ~~ 0*sleepP_w12

#regressions
happy_w12 ~ a*happy_w9 + b*sleepP_w9 + c*u_happy_w9 + d*u_sleepP_w9 
happy_w9 ~ a*happy_w6 + b*sleepP_w6 + c*u_happy_w6 + d*u_sleepP_w6 
happy_w6 ~ a*happy_w5 + b*sleepP_w5 + c*u_happy_w5 + d*u_sleepP_w5 
happy_w5 ~ a*happy_w3 + b*sleepP_w3 + c*u_happy_w3 + d*u_sleepP_w3 
happy_w3 ~ a*happy_w2 + b*sleepP_w2 + c*u_happy_w2 + d*u_sleepP_w2 
sleepP_w12 ~ f*happy_w9 + g*sleepP_w9 + h*u_happy_w9 + i*u_sleepP_w9 
sleepP_w9 ~ f*happy_w6 + g*sleepP_w6 + h*u_happy_w6 + i*u_sleepP_w6 
sleepP_w6 ~ f*happy_w5 + g*sleepP_w5 + h*u_happy_w5 + i*u_sleepP_w5 
sleepP_w5 ~ f*happy_w3 + g*sleepP_w3 + h*u_happy_w3 + i*u_sleepP_w3 
sleepP_w3 ~ f*happy_w2 + g*sleepP_w2 + h*u_happy_w2 + i*u_sleepP_w2 

#co-movements
u_happy_w2 ~~ u_sleepP_w2
u_happy_w3 ~~ u_sleepP_w3
u_happy_w5 ~~ u_sleepP_w5
u_happy_w6 ~~ u_sleepP_w6
u_happy_w9 ~~ u_sleepP_w9
u_happy_w12 ~~ u_sleepP_w12

#restrictions
u_happy_w2 ~~ 0*eta_x + 0*eta_y + 0*u_happy_w3 + 0*u_happy_w5 + 0*u_happy_w6 + 0*u_happy_w9 + 0*u_happy_w12 +
      0*u_sleepP_w3 + 0*u_sleepP_w5 + 0*u_sleepP_w6 + 0*u_sleepP_w9 + 0*u_sleepP_w12 
u_happy_w3 ~~ 0*eta_x + 0*eta_y +  0*u_happy_w5 + 0*u_happy_w6 + 0*u_happy_w9 + 0*u_happy_w12 +
        0*u_sleepP_w2 + 0*u_sleepP_w5 + 0*u_sleepP_w6 + 0*u_sleepP_w9 + 0*u_sleepP_w12
u_happy_w5 ~~ 0*eta_x + 0*eta_y +  0*u_happy_w6 + 0*u_happy_w9 + 0*u_happy_w12 +
       0*u_sleepP_w2 + 0*u_sleepP_w3 + 0*u_sleepP_w6 + 0*u_sleepP_w9 + 0*u_sleepP_w12
u_happy_w6 ~~ 0*eta_x + 0*eta_y + 0*u_happy_w9 + 0*u_happy_w12 +
        0*u_sleepP_w2 + 0*u_sleepP_w3 + 0*u_sleepP_w5 + 0*u_sleepP_w9 + 0*u_sleepP_w12
u_happy_w9 ~~ 0*eta_x + 0*eta_y + 0*u_happy_w12 +
        0*u_sleepP_w2 + 0*u_sleepP_w3 + 0*u_sleepP_w5 + 0*u_sleepP_w6 + 0*u_sleepP_w12
u_happy_w12 ~~ 0*eta_x + 0*eta_y + 0*u_sleepP_w2 + 0*u_sleepP_w3 + 0*u_sleepP_w5 + 0*u_sleepP_w6 + 0*u_sleepP_w9
u_sleepP_w2 ~~ 0*eta_x + 0*eta_y + 0*u_sleepP_w3 + 0*u_sleepP_w5 + 0*u_sleepP_w6 + 0*u_sleepP_w9 + 0*u_sleepP_w12 
u_sleepP_w3 ~~ 0*eta_x + 0*eta_y + 0*u_sleepP_w5 + 0*u_sleepP_w6 + 0*u_sleepP_w9 + 0*u_sleepP_w12
u_sleepP_w5 ~~ 0*eta_x + 0*eta_y + 0*u_sleepP_w6 + 0*u_sleepP_w9 + 0*u_sleepP_w12
u_sleepP_w6 ~~ 0*eta_x + 0*eta_y + 0*u_sleepP_w9 + 0*u_sleepP_w12
u_sleepP_w9 ~~ 0*eta_x + 0*eta_y + 0*u_sleepP_w12 
u_sleepP_w12 ~~ 0*eta_x + 0*eta_y '

#fit the model and show output:
RICLPM.ext1.fit <- lavaan(swb.mod, 
                          data = TYPSleep_analysis, 
                          missing = 'ML', 
                          meanstructure = T, 
                          int.ov.free = T
) 

summary(swb.fit)
