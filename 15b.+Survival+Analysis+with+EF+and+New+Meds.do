*** Refining survival analysis

*** STEP 1: merge final medications with last analysis file, clean med values, clean BMI
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_glp1_dpp4_medwithoutfilter.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",
drop if _merge==1
drop _merge

replace BB1=0 if BB1==.
replace AASAC=0 if AASAC==.
replace spiro1=0 if spiro1==.
drop if bmi==. | bmi>60
drop if dof>=follow_up

*** STEP 2: merge with EF file
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_efbefore_cleaned_merged.dta"
keep if _merge==3
drop _merge

*** STEP 3: IPTW 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year

logistic treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year

drop p q p2 q2 weight weight2

predict p
gen q=1-p if treatment ==0
gen weight=.
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year, wt(weight)

gen p2=p if p>0.1 & p<0.9
gen q2=q if q>0.1 & q <0.9
gen weight2=.
replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year, wt(weight2)

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]

*** STEP 4: outcome variables
replace follow_up= mdy(12,31,2023)
 gen failure=1 if admission <= follow_up | dod <= follow_up
recode failure .=0
gen outcome = min(admission, dod, follow_up)
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta", replace

*** STEP 5: survival analysis
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)

stcox treatment

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2

sts graph, by(treatment) risktable tmax(5)

*** STEP 6 Competing risk analyses

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"
replace follow_up=mdy(12,31,2023)
replace admission=. if admission>=follow_up
replace dod=. if dod>=follow_up
gen event = 0 if follow_up~=.
replace event = 2 if dod ~=.
replace event = 1 if admission ~=. 
replace outcome = min(admission, dod,follow_up)
stset outcome, id(scrssn) origin(dof) failure(event==1) exit(event ==1 time follow_up) scale(365.25)
 
stcrreg treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2, compete(event == 2)
