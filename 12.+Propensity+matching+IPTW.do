clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_final_glp1_dpp4.dta"

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

** STEP 3B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 4,808/5597; some missing values)
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

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]



**** Final balance diagnositics 

**** Prematching 




               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           69.38              66.98                0.280
        bmi2 |           38.80              36.67                0.361
         sex |            1.03               1.03                0.005
          AF |            0.50               0.49                0.031
        copd |            0.48               0.46                0.055
  depression |            0.43               0.32                0.233
     alcohol |            0.01               0.05               -0.205
hypothyroi~m |            0.16               0.12                0.118
hypertension |            0.60               0.62               -0.040
         CAD |            0.79               0.70                0.192
          MI |            0.30               0.24                0.153
         ckd |            0.60               0.44                0.309
         cld |            0.13               0.10                0.096
      cancer |            0.00               0.01               -0.033
         pad |            0.18               0.15                0.060
   polyabuse |            0.06               0.10               -0.170
         ppm |            0.17               0.21               -0.100
      schizo |            0.02               0.02                0.010
      stroke |            0.04               0.03                0.030
         HFH |            0.07               0.07               -0.006
        THFH |            0.09               0.09                0.003
         ACE |            0.54               0.54               -0.004
          BB |            0.67               0.65                0.055
     antiarr |            0.07               0.11               -0.145
       sglt2 |            0.10               0.02                0.337
     insulin |            0.60               0.11                1.208
          LD |            0.88               0.83                0.157
   metformin |            0.19               0.23               -0.095
       spiro |            0.23               0.23               -0.001
      statin |            0.86               0.76                0.243
        ARNI |            0.04               0.03                0.053
        year |         2019.63            2017.90                0.913
----------------------------------------------------------------------




*** Matching with all weights




               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           67.35              67.89               -0.064
        bmi2 |           38.19              37.34                0.144
         sex |            1.03               1.03                0.052
          AF |            0.46               0.45                0.016
        copd |            0.47               0.50               -0.051
  depression |            0.38               0.38                0.013
     alcohol |            0.05               0.03                0.092
hypothyroi~m |            0.14               0.17               -0.105
hypertension |            0.63               0.64               -0.006
         CAD |            0.74               0.76               -0.031
          MI |            0.27               0.29               -0.056
         ckd |            0.50               0.52               -0.047
         cld |            0.12               0.14               -0.072
      cancer |            0.01               0.01               -0.030
         pad |            0.16               0.17               -0.020
   polyabuse |            0.09               0.08                0.035
         ppm |            0.17               0.18               -0.028
      schizo |            0.02               0.03               -0.023
      stroke |            0.03               0.07               -0.241
         HFH |            0.07               0.06                0.028
        THFH |            0.08               0.08                0.012
         ACE |            0.52               0.54               -0.037
          BB |            0.66               0.64                0.036
     antiarr |            0.06               0.08               -0.060
       sglt2 |            0.06               0.04                0.069
     insulin |            0.34               0.34               -0.009
          LD |            0.84               0.85               -0.005
   metformin |            0.19               0.19               -0.018
       spiro |            0.21               0.26               -0.109
      statin |            0.80               0.80               -0.007
        ARNI |            0.03               0.02                0.045
        year |         2018.73            2018.63                0.054
----------------------------------------------------------------------



**** Matching after removing extreme weights


               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           68.13              68.01                0.014
        bmi2 |           37.77              37.84               -0.012
         sex |            1.03               1.03               -0.020
          AF |            0.47               0.48               -0.015
        copd |            0.47               0.46                0.025
  depression |            0.39               0.37                0.026
     alcohol |            0.02               0.02                0.004
hypothyroi~m |            0.15               0.15                0.021
hypertension |            0.63               0.63               -0.002
         CAD |            0.76               0.73                0.051
          MI |            0.28               0.27                0.007
         ckd |            0.55               0.53                0.034
         cld |            0.11               0.11               -0.007
      cancer |            0.01               0.01               -0.032
         pad |            0.16               0.18               -0.039
   polyabuse |            0.08               0.08               -0.014
         ppm |            0.19               0.19               -0.002
      schizo |            0.03               0.02                0.057
      stroke |            0.03               0.03                0.029
         HFH |            0.04               0.05               -0.016
        THFH |            0.05               0.06               -0.022
         ACE |            0.53               0.53                0.001
          BB |            0.64               0.64                0.019
     antiarr |            0.07               0.07                0.012
       sglt2 |            0.04               0.05               -0.016
     insulin |            0.28               0.30               -0.027
          LD |            0.84               0.83                0.018
   metformin |            0.20               0.21               -0.017
       spiro |            0.23               0.23               -0.003
      statin |            0.82               0.80                0.052
        ARNI |            0.03               0.03                0.003
        year |         2018.95            2019.00               -0.023
----------------------------------------------------------------------




