**** STEP 1: Merging dod files of GLP1 and DPP4
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_dod.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_dod.dta"
drop if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\diabetes_hfief_dpp4_glp1_dod_final.dta", replace

**** STEP 2:  Merging final GLP1 and DPP4 combined files to heart failure hospitalization file 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\diabetes_hfief_final_glp1_dpp4.dta"
gen year= year(dof)
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\diabetes_hfief_dpp4glp1_glp1_hf_admission.dta"
drop if _merge==2
drop _merge

*******************************************************************************************************************************************

**** STEP 3
*** Splitting continous variables (age and BMI) into categorical variables for regression 
gen bmi2 = round(bmi,1)
**rounding bmi values to nearest number 
replace bmi2=. if bmi2>60
*** 24 changes made
drop bmi


** Splitting age into clinically relevant groups
gen agegp=age
recode agegp (18/35=1) (36/45=2) (46/55=3) (56/65=4) (66/75=5) (76/85=6) (86/100=7)
tab agegp

*******************************************************************************************************************************************

*** STEP 4: gen outcome date variable (composite of HFH or mortality; whichever comes first)
gen follow_up =.
replace follow_up= mdy(07,30,2025)

** final date of follow up Decem 30, 2023
gen outcome = min(admission, dod, follow_up)
gen failure =0 if admission==. & dod==.
replace failure = 1 if failure ==.

*******************************************************************************************************************************************
*** STEP 5: Merging with file with entire age and dof information 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_age_dof.dta"
keep if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\bmi_linear_regression.dta", replace

************************************************************************************************************************************************************************************************************************************************************
*** STEP 6: Linear regression 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\bmi_linear_regression.dta"
gen obesity=bmi2
recode obesity (16/30=1) (30.1/34.9=2) (35.0/39.9=3) (40/60=4)
logistic failure agegp i.obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year
regress failure agegp bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
stcox treatment agegp i.obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year 



************************************************************************************************************************************************************************************************************************************************************
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
*** BMI

preserve
keep if obesity ==1
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
di 545/2361
restore
preserve
keep if obesity ==2
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
di 384/2070
restore
preserve
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
keep if obesity ==3
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
di 448/2522
restore
preserve
keep if obesity ==4

di 462/2727

***
Overall event rate = 19.0 per 100 patient years of follow up
BMI < 30 = 23.08 per 100 patient years of follow up
BMI 30.1-35 = 18.6 per 100 patient years of follow up 
BMI 35.1-40 = 17.8 per 100 patient years of follow up
BMI > 40.1 = 17.0 per 100 patient years of follow up

ST cox hazard
BMI < 30 = 1 reference 
BMI 30.1-35 = 0.85  0.74-0.98
BMI 35.1-40 = 0.90  0.79-1.03
BMI > 40.1 =  0.96  0.83-1.01

Linear regression      bmi2 |  -.0012489   .0012921    -0.97   0.334    -.0037825    .0012847

logistic regression  OR 
|2|   .8130886   .1068293    -1.57   0.115     .6284938    1.051901  
|3|   .8745049   .1130923    -1.04   0.300      .678709    1.126785  
|4|   .915072    .1209249    -0.67   0.502     .7062699    1.185605
			
			
			



