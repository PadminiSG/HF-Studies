**** STEP 1:  Merging final GLP1 and DPP4 combined files to heart failure hospitalization file 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_final_glp1_dpp4.dta"
gen year= year(dof)
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_glp1_hfh.dta"
drop if _merge==2
drop _merge

*******************************************************************************************************************************************

**** STEP 2
*** Splitting continous variables (age and BMI) into categorical variables for regression 
gen bmi2 = round(bmi,1)
**rounding bmi values to nearest number 
replace bmi2=. if bmi2>70
drop if bmi2<30 | bmi==.
*** 24 changes made
drop bmi

** Splitting age into clinically relevant groups
gen agegp=age
recode agegp (18/49=1) (50/60=2) (61/70=3) (71/80=4) ( 80/100=5)
tab agegp

** Splitting BMI into clinically relevant groups
gen obesity = bmi2
recode obesity (30/34.9=1) (35.0/39.9=2) (40/max=3)


*******************************************************************************************************************************************
**** STEP 3: IPTW

** STEP 3A: Checking standardized difference prior to matching 
pbalchk treatment age bmi2 sex hypertension CAD stroke MI pad AF ckd copd cld hypothyroidism depression alcohol polyabuse cancer BB ACEARB ARNI spiro LD antiarr insulin metformin SGLT2 hct creatinine hba1c year


** STEP 3B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 2998/3040; some missing values)
logistic treatment age bmi2 sex hypertension CAD stroke MI pad AF ckd copd cld hypothyroidism depression alcohol polyabuse cancer BB ACEARB ARNI spiro LD antiarr insulin metformin SGLT2 hct creatinine hba1c year


** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 3C: Checking balance post matching 
pbalchk treatment age bmi2 sex hypertension CAD stroke MI pad AF ckd copd cld hypothyroidism depression alcohol polyabuse cancer BB ACEARB ARNI spiro LD antiarr insulin metformin SGLT2 hct creatinine hba1c year, wt(weight)
** < 10% difference for all variables except hypertension (0.107), schizo (-0.101), stroke (-0.116), LD (-0.133), SGLT2 (0.113)

graph tw kdensity p if treatment ==0||kdensity p if treatment ==1
graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight]
sum weight,de
sum p if treatment ==1,de
sum p if treatment ==0, de

** STEP 3D: Residual imbalance post matching; removing extreme weights
gen p2=p if p>0.05 & p<0.95
gen q2=q if q>0.05 & q<0.95

gen weight2=.

replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2 sex hypertension CAD stroke MI pad AF ckd copd cld hypothyroidism depression alcohol polyabuse cancer BB ACEARB ARNI spiro LD antiarr insulin metformin SGLT2 hct creatinine hba1c year, wt(weight2)
** No residual imbalance after excluding extreme weights (except SGLT2 - 0.118; but seems to be an error in data presentation?)

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]

*******************************************************************************************************************************************

*** STEP 4: gen outcome date variable (composite of HFH or mortality; whichever comes first)
gen follow_up =.
replace follow_up= mdy(12,31,2023)

** final date of follow up Decem 30, 2023
gen outcome = min(discharge, dod, follow_up)
gen failure =0 if discharge>follow_up & dod>follow_up
replace failure = 1 if failure ==.

*******************************************************************************************************************************************
*** STEP 5: Merging with file with entire age and dof information 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\final_age_dof.dta"
keep if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\final_survival_analysis_data.dta", replace

************************************************************************************************************************************************************************************************************************************************************
*** STEP 7: Survival analyses 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\final_survival_analysis_data.dta"
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year

stcox treatment weight2 

sts graph, by(treatment)

*** Median follow up 2.6 years 

*generating outcome components as binary variables
gen death=0 if dod==.
recode death .=1
gen HFHafter=0 if discharge==.
recode HFHafter .=1


*** STEP 8 Competing risk analyses

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\final_survival_analysis_data.dta"
gen follow_up2 =.
replace follow_up2= mdy(12,31,2023)
replace discharge=. if discharge>=follow_up2
replace dod=. if dod>=follow_up2
gen event = 0 if follow_up2~=.
replace event = 2 if dod ~=.
replace event = 1 if discharge ~=. 
replace outcome = min(discharge,dod, follow_up2)
gen time = outcome-dof
stset outcome, id(scrssn) origin(dof) failure(event==1) scale(365.25)
stcrreg treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year, compete(event==2)
stcurve, cif at(treatment=(0 1) age obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year) range (0 3)





