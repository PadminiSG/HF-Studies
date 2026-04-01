clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\diabetes_hf_final_glp1_dpp4.dta"

*** STEP 1: Multiple imputation of missing variables (BMI and creatinine)

summ
** BMI 48 missing values, creatinine 81  values, Hb 228 missing values, albumin 636 missing values 
gen bmi2 = round(bmi,1)
**rounding bmi values to nearest number 
replace bmi2=. if bmi2>60
*** 24 changes made
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

*** STEP 3: Propensity matching IPTW

** STEP 3A: Checking standardized difference prior to matching 
pbalchk treatment age bmi sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year



** STEP 3B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 4,808/5597; some missing values)
logistic treatment i.agegp i.obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

logistic treatment age bmi2 sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year


** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 3C: Checking balance post matching 
pbalchk treatment age sex bmi2 AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin year HFH THFH, wt(weight)

** < 10% difference for all variables 

** Graph the propensity scores 



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

pbalchk treatment age bmi2  sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year, wt(weight2)
** No residual imbalance after excluding extreme weights 

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]



**** Final balance diagnositics 

**** Prematching 




               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           70.55              70.87               -0.038
        bmi2 |           38.94              35.90                0.403
         sex |            1.03               1.04               -0.046
          AF |            0.38               0.43               -0.104
        copd |            0.53               0.57               -0.078
  depression |            0.42               0.38                0.081
     alcohol |            0.02               0.04               -0.127
hypertension |            0.53               0.57               -0.082
         CAD |            0.68               0.58                0.205
          MI |            0.18               0.14                0.099
         ckd |            0.62               0.44                0.370
         cld |            0.12               0.12               -0.008
      cancer |            0.00               0.00               -0.028
         pad |            0.15               0.14                0.033
   polyabuse |            0.05               0.08               -0.153
         ppm |            0.07               0.06                0.017
      schizo |            0.02               0.02               -0.026
      stroke |            0.03               0.03               -0.032
  creatinine |            1.67               1.44                0.247
       hba1c |            8.71               8.20                0.319
         ACE |            0.37               0.32                0.102
          BB |            0.43               0.37                0.114
     antiarr |            1.93               1.85                0.192
     insulin |            1.34               1.76               -0.796
          LD |            0.89               0.82                0.212
   metformin |            0.20               0.26               -0.141
       spiro |            0.10               0.07                0.115
         TZD |            0.00               0.00                0.029
      statin |            0.85               0.73                0.291
         HFH |            0.34               0.38               -0.081
        THFH |            1.73               1.39                0.173
        year |         2019.20            2018.15                0.584
----------------------------------------------------------------------



*** Matching with all weights



               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           70.34              69.64                0.082
         sex |            1.03               1.04               -0.015
        bmi2 |           37.88              37.41                0.062
          AF |            0.42               0.35                0.151
        copd |            0.55               0.55               -0.004
  depression |            0.40               0.42               -0.038
     alcohol |            0.02               0.03               -0.022
hypertension |            0.55               0.58               -0.059
         CAD |            0.62               0.63               -0.006
          MI |            0.15               0.14                0.048
         ckd |            0.53               0.59               -0.118
         cld |            0.11               0.13               -0.065
      cancer |            0.00               0.00               -0.008
         pad |            0.14               0.13                0.030
   polyabuse |            0.05               0.06               -0.023
         ppm |            0.06               0.05                0.029
      schizo |            0.02               0.02               -0.021
      stroke |            0.03               0.04               -0.050
  creatinine |            1.58               1.66               -0.094
       hba1c |            8.56               8.63               -0.040
         ACE |            0.34               0.34               -0.002
          BB |            0.41               0.42               -0.031
     antiarr |            1.88               1.90               -0.060
     insulin |            1.54               1.51                0.059
          LD |            0.86               0.86               -0.005
   metformin |            0.25               0.23                0.059
       spiro |            0.09               0.09               -0.005
         TZD |            0.00               0.00                0.020
      statin |            0.83               0.81                0.036
        year |         2018.87            2018.84                0.015
         HFH |            0.38               0.38               -0.011
        THFH |            1.61               1.62               -0.005
----------------------------------------------------------------------


**** Matching after removing extreme weights


               Mean in treated   Mean in Untreated   Standardised diff.
----------------------------------------------------------------------
         age |           70.35              70.41               -0.007
        bmi2 |           37.32              37.03                0.038
         sex |            1.04               1.04                0.029
          AF |            0.38               0.41               -0.057
        copd |            0.53               0.52                0.020
  depression |            0.38               0.37                0.027
     alcohol |            0.03               0.03               -0.003
hypertension |            0.54               0.54               -0.013
         CAD |            0.63               0.61                0.052
          MI |            0.15               0.15                0.015
         ckd |            0.52               0.51                0.004
         cld |            0.12               0.11                0.035
      cancer |            0.00               0.01               -0.021
         pad |            0.14               0.14               -0.021
   polyabuse |            0.06               0.06               -0.000
         ppm |            0.06               0.06                0.010
      schizo |            0.02               0.02                0.021
      stroke |            0.03               0.03                0.036
  creatinine |            1.56               1.53                0.034
       hba1c |            8.54               8.57               -0.019
         ACE |            0.33               0.33                0.010
          BB |            0.40               0.37                0.059
     antiarr |            1.88               1.89               -0.014
     insulin |            1.60               1.63               -0.043
          LD |            0.84               0.84                0.013
   metformin |            0.21               0.22               -0.024
       spiro |            0.08               0.08                0.010
         TZD |            0.00               0.00               -0.006
      statin |            0.80               0.80               -0.010
         HFH |            0.35               0.36               -0.017
        THFH |            1.47               1.52               -0.024
        year |         2018.78            2018.71                0.035
----------------------------------------------------------------------


