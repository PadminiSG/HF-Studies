clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_final_glp1_dpp4.dta"

*** STEP 1: Multiple imputation of missing variables (BMI and creatinine)

summ
** BMI 31 missing values, creatinine 66 missing values, Hb 208 missing values, albumin 766 missing values 
gen bmi2 = round(bmi,1)
**rounding bmi values to nearest number 
replace bmi2=. if bmi2>60
*** 9 changes made
drop bmi

*** STEP 2 Splitting continous variables (age and BMI) into categorical variables for regression 
** Splitting age into clinically relevant groups
gen agegp=age
recode agegp (18/50=1) (50/60=2) (61/70=3) (71/80=4) (80/100=5)
tab agegp

** Splitting BMI into clinically relevant groups
gen obesity = bmi2
recode obesity (0/18.4=1) (18.5/24.9=2) (25.0/29.9=3) (30/34.9=4) (35.0/39.9=5) (40/60=6)

gen year= year(dof)

drop if bmi2 <30


*** STEP 3: Propensity matching IPTW

** STEP 3A: Checking standardized difference prior to matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year

** STEP 3B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 2252/3040; some missing values)
logistic treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year


** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 3C: Checking balance post matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year, wt(weight)
** < 10% difference for all variables except COPD and schizo

graph tw kdensity p if treatment ==0||kdensity p if treatment ==1
graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight]
sum weight,de
sum p if treatment ==1,de
sum p if treatment ==0, de

** STEP 3D: Residual imbalance post matching; removing extreme weights
gen p2=p if p>0.1 & p<0.9
gen q2=q if q>0.1 & q <0.9

gen weight2=.

replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year, wt(weight2)
** No residual imbalance after excluding extreme weights 

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]



**** Final balance diagnositics 

**** Prematching 




               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           69.76              68.00                0.215
        bmi2 |           38.41              36.83                0.270
         sex |            1.02               1.03               -0.015
          AF |            0.51               0.52               -0.025
        copd |            0.46               0.51               -0.093
  depression |            0.44               0.33                0.219
     alcohol |            0.01               0.05               -0.213
hypothyroi~m |            0.17               0.13                0.113
hypertension |            0.62               0.65               -0.048
         CAD |            0.79               0.71                0.191
          MI |            0.31               0.24                0.153
         ckd |            0.75               0.58                0.377
         cld |            0.14               0.11                0.084
      cancer |            0.01               0.01                0.012
         pad |            0.19               0.17                0.054
   polyabuse |            0.06               0.10               -0.138
         ppm |            0.16               0.17               -0.016
      schizo |            0.02               0.02                0.003
      stroke |            0.06               0.05                0.062
         HFH |            0.07               0.07                0.015
        THFH |            0.09               0.08                0.044
      ACEARB |            0.54               0.53                0.022
          BB |            0.68               0.63                0.113
     antiarr |            0.07               0.09               -0.076
       SGLT2 |            0.11               0.02                0.349
     insulin |            0.61               0.12                1.198
          LD |            0.87               0.81                0.173
   metformin |            0.19               0.23               -0.087
       spiro |            0.21               0.20                0.041
      statin |            0.87               0.77                0.264
        ARNI |            0.03               0.02                0.066
        year |         2019.63            2018.11                0.782
----------------------------------------------------------------------





*** Matching with all weights



               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           68.60              68.93               -0.040
        bmi2 |           37.63              37.18                0.077
         sex |            1.02               1.02                0.017
          AF |            0.52               0.48                0.063
        copd |            0.46               0.53               -0.122
  depression |            0.37               0.40               -0.061
     alcohol |            0.04               0.03                0.032
hypothyroi~m |            0.16               0.18               -0.074
hypertension |            0.67               0.63                0.089
         CAD |            0.75               0.77               -0.030
          MI |            0.26               0.29               -0.082
         ckd |            0.66               0.66               -0.003
         cld |            0.11               0.12               -0.032
      cancer |            0.00               0.01               -0.006
         pad |            0.17               0.19               -0.052
   polyabuse |            0.08               0.08                0.016
         ppm |            0.16               0.15                0.041
      schizo |            0.02               0.04               -0.136
      stroke |            0.05               0.08               -0.109
         HFH |            0.06               0.06                0.000
        THFH |            0.07               0.07                0.007
      ACEARB |            0.51               0.56               -0.096
          BB |            0.63               0.64               -0.037
     antiarr |            0.09               0.07                0.088
       SGLT2 |            0.06               0.08               -0.080
     insulin |            0.34               0.37               -0.074
          LD |            0.79               0.82               -0.078
   metformin |            0.19               0.21               -0.054
       spiro |            0.20               0.21               -0.032
      statin |            0.81               0.81               -0.009
        ARNI |            0.02               0.02                0.048
        year |         2018.94            2018.99               -0.024
----------------------------------------------------------------------




**** Matching after removing extreme weights


               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           69.07              69.02                0.006
        bmi2 |           37.51              37.63               -0.020
         sex |            1.01               1.03               -0.078
          AF |            0.52               0.51                0.015
        copd |            0.50               0.47                0.054
  depression |            0.39               0.39                0.009
     alcohol |            0.01               0.02               -0.074
hypothyroi~m |            0.16               0.16                0.006
hypertension |            0.64               0.66               -0.039
         CAD |            0.77               0.76                0.020
          MI |            0.29               0.28                0.014
         ckd |            0.71               0.69                0.039
         cld |            0.12               0.12               -0.007
      cancer |            0.01               0.01               -0.022
         pad |            0.18               0.18                0.011
   polyabuse |            0.07               0.08               -0.031
         ppm |            0.17               0.17                0.003
      schizo |            0.02               0.02                0.029
      stroke |            0.06               0.05                0.073
         HFH |            0.05               0.05                0.014
        THFH |            0.06               0.06                0.005
      ACEARB |            0.52               0.52               -0.001
          BB |            0.64               0.66               -0.041
     antiarr |            0.07               0.07               -0.008
       SGLT2 |            0.05               0.04                0.043
     insulin |            0.33               0.31                0.047
          LD |            0.83               0.82                0.027
   metformin |            0.21               0.20                0.010
       spiro |            0.19               0.19               -0.006
      statin |            0.84               0.82                0.075
        ARNI |            0.02               0.02                0.001
        year |         2019.15            2019.17               -0.011
----------------------------------------------------------------------





