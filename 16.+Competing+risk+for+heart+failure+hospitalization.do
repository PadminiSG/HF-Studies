**** STEP 1:  Merging final GLP1 and DPP4 combined files to heart failure hospitalization file 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\diabetes_hf_final_glp1_dpp4.dta"
gen year= year(dof)
drop if bmi < 30
drop dod
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\diabetes_hf_dpp4glp1_glp1_hf_discharge.dta"
drop if _merge==2
drop _merge


**** STEP 3: gen outcome date variable (composite of HFH or mortality; whichever comes first)
gen follow_up =.
replace follow_up= mdy(04,30,2024)

gen compet=1 if admission < dod

replace compet=2 if dod< admission

**gen outcome = min(admission, dod)

gen outcome = admission

gen censor=min(admission,follow_up, dod)

stset censor, origin(dof) failure(compet=1) id(scrssn) scale(365.25)

stcompet CumInc = ci SError = se, compet1(2) 

gen CumInc1= CumInc if compet==1

gen CumInc2= CumInc if compet==2

stcox treatment

sts graph, by(treatment) 

stcox treatment age bmi sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year


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


*** STEP 3: Propensity matching IPTW

** STEP 3A: Checking standardized difference prior to matching 
pbalchk treatment age bmi sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

** STEP 3B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 4,808/5597; some missing values)
logistic treatment i.agegp i.obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

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


stcox treatment age bmi sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight


** STEP 3D: Residual imbalance post matching; removing extreme weights
gen p2=p if p>0.1 & p<0.9
gen q2=q if q>0.1 & q <0.9

gen weight2=.

replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2  sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year, wt(weight2)

stcox treatment age bmi sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

** final date of follow up June 30, 2022

gen failure =0 if admission==. & dod==.
replace failure = 1 if failure ==.


*** STEP 4: Merging with file with entire age and dof information 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_age_dof.dta"
keep if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta", replace