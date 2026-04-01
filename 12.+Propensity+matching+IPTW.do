clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\diabetes_hfief_final_glp1_dpp4.dta"

*** STEP 1: Multiple imputation of missing variables (BMI and creatinine)

summ
** BMI  missing values, creatinine   values, Hb  missing values, albumin  missing values 
gen bmi2 = round(bmi,1)
**rounding bmi values to nearest number 
replace bmi2=. if bmi2>60
*** 14 changes made
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
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI year

** STEP 3B: Calculating logistic regression, probability of treatment assignment for each patient (total observations; some missing values)
logistic treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI year


** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 3C: Checking balance post matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year, wt(weight)
** < 10% difference for all variables 

** Graph the propensity scores 

sysuse auto, clear
psmatch2 foreign mpg, out(price)

* Before

twoway (kdensity _pscore if _treated==1) (kdensity _pscore if _treated==0 , lpattern (dash)), legend(label( 1 "GLP-1 RA") label(2 "DPP4i/SU")) xtitle("Propensity Scores BEFORE Matching") name(before, replace)

*After
 twoway (kdensity _pscore if _treated==1 [aweight=_weight]) (kdensity _pscore if _treated==0 [aweight=_weight], lpattern (dash)), legend(label( 1 "GLP-1 RA") label(2 "DPP4i/SU")) xtitle("Propensity Scores AFTER Matching") name(after, replace)
 
grc1leg before after, ycommon

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

pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year, wt(weight2)
** No residual imbalance after excluding extreme weights 

** Graph the propensity scores 

sysuse auto, clear
psmatch2 foreign mpg, out(price)

* Before

twoway (kdensity _pscore if _treated==1) (kdensity _pscore if _treated==0 , lpattern (dash)), legend(label( 1 "GLP-1 RA") label(2 "DPP4i/SU")) xtitle("Propensity Scores BEFORE Matching") name(before, replace)

*After
 twoway (kdensity _pscore if _treated==1 [aweight=_weight]) (kdensity _pscore if _treated==0 [aweight=_weight], lpattern (dash)), legend(label( 1 "GLP-1 RA") label(2 "DPP4i/SU")) xtitle("Propensity Scores AFTER Matching") name(after, replace)
 
grc1leg before after, ycommon


**** Final balance diagnositics 

**** Prematching 



               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           68.97              68.57                0.048
        bmi2 |           38.56              37.08                0.251
         sex |            1.03               1.02                0.032
          AF |            0.51               0.57               -0.121
        copd |            0.48               0.51               -0.058
  depression |            0.45               0.36                0.187
     alcohol |            0.02               0.05               -0.202
hypothyroi~m |            0.16               0.14                0.064
hypertension |            0.68               0.74               -0.123
         CAD |            0.82               0.72                0.246
          MI |            0.33               0.24                0.216
         ckd |            0.64               0.47                0.334
         cld |            0.12               0.12                0.002
      cancer |            0.00               0.01               -0.030
         pad |            0.20               0.18                0.051
   polyabuse |            0.07               0.11               -0.164
         ppm |            0.18               0.17                0.041
      schizo |            0.02               0.02               -0.010
      stroke |            0.03               0.03                0.002
         HFH |            0.06               0.09               -0.121
        THFH |            0.07               0.12               -0.126
         ACE |            0.55               0.48                0.140
          BB |            0.68               0.60                0.164
     antiarr |            0.07               0.10               -0.116
       sglt2 |            0.08               0.02                0.258
     insulin |            0.60               0.10                1.218
          LD |            0.86               0.81                0.157
   metformin |            0.19               0.24               -0.119
       spiro |            0.22               0.20                0.058
      statin |            0.86               0.76                0.269
        ARNI |            0.02               0.01                0.086
        year |         2019.20            2018.12                0.606



*** Matching with all weights



               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           68.63              68.42                0.025
        bmi2 |           38.14              37.92                0.039
         sex |            1.03               1.03               -0.024
          AF |            0.51               0.47                0.079
        copd |            0.49               0.53               -0.076
  depression |            0.40               0.43               -0.049
     alcohol |            0.03               0.03               -0.010
hypothyroi~m |            0.14               0.18               -0.112
hypertension |            0.73               0.75               -0.038
         CAD |            0.77               0.77                0.016
          MI |            0.29               0.31               -0.062
         ckd |            0.56               0.60               -0.086
         cld |            0.11               0.14               -0.088
      cancer |            0.00               0.00               -0.002
         pad |            0.19               0.18                0.040
   polyabuse |            0.08               0.08                0.010
         ppm |            0.16               0.14                0.047
      schizo |            0.02               0.04               -0.137
      stroke |            0.03               0.09               -0.297
         HFH |            0.08               0.06                0.053
        THFH |            0.09               0.08                0.025
         ACE |            0.51               0.53               -0.045
          BB |            0.63               0.61                0.044
     antiarr |            0.08               0.06                0.064
       sglt2 |            0.06               0.04                0.092
     insulin |            0.39               0.39               -0.015
          LD |            0.81               0.82               -0.022
   metformin |            0.20               0.18                0.057
       spiro |            0.20               0.22               -0.055
      statin |            0.81               0.81               -0.004
        ARNI |            0.02               0.01                0.057
        year |         2018.80            2018.79                0.001
----------------------------------------------------------------------




**** Matching after removing extreme weights


               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           68.62              68.78               -0.020
        bmi2 |           37.82              37.75                0.010
         sex |            1.02               1.02               -0.001
          AF |            0.52               0.53               -0.010
        copd |            0.51               0.52               -0.010
  depression |            0.39               0.41               -0.047
     alcohol |            0.03               0.03               -0.007
hypothyroi~m |            0.15               0.17               -0.053
hypertension |            0.74               0.73                0.018
         CAD |            0.75               0.76               -0.016
          MI |            0.27               0.29               -0.054
         ckd |            0.54               0.54                0.005
         cld |            0.12               0.12                0.002
      cancer |            0.00               0.00                0.004
         pad |            0.19               0.20               -0.007
   polyabuse |            0.09               0.10               -0.020
         ppm |            0.16               0.18               -0.036
      schizo |            0.02               0.01                0.083
      stroke |            0.03               0.03                0.008
         HFH |            0.06               0.06               -0.001
        THFH |            0.08               0.08                0.003
         ACE |            0.49               0.49               -0.005
          BB |            0.64               0.63                0.007
     antiarr |            0.06               0.07               -0.027
       sglt2 |            0.04               0.04               -0.022
     insulin |            0.23               0.21                0.036
          LD |            0.80               0.81               -0.032
   metformin |            0.21               0.23               -0.038
       spiro |            0.20               0.20               -0.002
      statin |            0.81               0.82               -0.031
        ARNI |            0.02               0.02               -0.006
        year |         2018.73            2018.73               -0.000
----------------------------------------------------------------------





