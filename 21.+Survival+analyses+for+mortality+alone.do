**** STEP 1:  Merging final GLP1 and DPP4 combined files to heart failure hospitalization file 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_final_glp1_dpp4.dta"
gen year= year(dof)
drop if bmi < 30
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hf_dpp4glp1_glp1_hfh.dta"
drop if _merge==2
drop _merge

*******************************************************************************************************************************************

**** STEP 2
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

** Splitting BMI into clinically relevant groups
gen obesity = bmi2
recode obesity (0/18.4=1) (18.5/24.9=2) (25.0/29.9=3) (30/34.9=4) (35.0/39.9=5) (40/60=6)


*******************************************************************************************************************************************
**** STEP 4: IPTW

** STEP 4A: Checking standardized difference prior to matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin ARNI year

** STEP 4B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 4,808/5597; some missing values)
logistic treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin ARNI year


** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 4C: Checking balance post matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year, wt(weight)
** < 10% difference for all variables 

graph tw kdensity p if treatment ==0||kdensity p if treatment ==1
graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight]
sum weight,de
sum p if treatment ==1,de
sum p if treatment ==0, de

** STEP 4D: Residual imbalance post matching; removing extreme weights
gen p2=p if p>0.1 & p<0.9
gen q2=q if q>0.1 & q <0.9

gen weight2=.

replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year, wt(weight2)
** No residual imbalance after excluding extreme weights 

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]

*******************************************************************************************************************************************

*** STEP 5: gen outcome date variable (composite of HFH or mortality; whichever comes first)
gen follow_up =.
replace follow_up= mdy(12,30,2023)

** final date of follow up Decem 30, 2023
gen outcome = min(dod, follow_up)
gen failure =0 if dod==.
replace failure = 1 if failure ==.

*******************************************************************************************************************************************
*** STEP 6: Merging with file with entire age and dof information 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_age_dof.dta"
keep if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_mortality.dta", replace

************************************************************************************************************************************************************************************************************************************************************
*** STEP 7: Survival analyses 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_mortality.dta",
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30December2023)) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year weight2

sts graph, by(treatment)

*** HR 0.89 95CI (0.74-1.06) p value 0.18