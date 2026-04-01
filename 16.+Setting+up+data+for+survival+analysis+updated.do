**** STEP 1: Merging dod files of GLP1 and DPP4
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_dod.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_dod.dta"
drop if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_dod_final.dta", replace



**** STEP 2:  Merging final GLP1 and DPP4 combined files to heart failure hospitalization file 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\diabetes_hf_final_glp1_dpp4.dta"
gen year= year(dof)
drop if bmi < 30
drop dod
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\diabetes_hf_dpp4glp1_glp1_hf_discharge.dta",
drop if _merge==2
drop _merge


**** STEP 3:  Merging with death information file 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_dod_final.dta"
drop if _merge ==2
drop _merge
gen dodnew= cofd(dod)
drop dod
gen dod=dofc(dodnew)
drop dodnew

**** STEP 4: IPTW 

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

** STEP 4A: Checking standardized difference prior to matching 
pbalchk treatment age bmi sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

** STEP 4B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 4,808/5597; some missing values)
logistic treatment i.agegp i.obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 4C: Checking balance post matching 
pbalchk treatment age sex bmi2 AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin year HFH THFH, wt(weight)
** < 10% difference for all variables 

** STEP 4D: Residual imbalance post matching; removing extreme weights
gen p2=p if p>0.1 & p<0.9
gen q2=q if q>0.1 & q <0.9

gen weight2=.

replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2  sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year, wt(weight2)

*** STEP 5: gen outcome date variable (composite of HFH or mortality; whichever comes first)
gen follow_up =.
replace follow_up= mdy(06,30,2022)

** final date of follow up June 30, 2022
replace admission=. if admission>follow_up
replace dod=. if dod>follow_up
gen outcome = min(admission, dod, follow_up)
gen failure =0 if admission==. & dod==.
replace failure = 1 if failure ==.


*** STEP 6: Merging with file with entire age and dof information 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_age_dof.dta"
keep if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta", replace


*** STEP 7: Survival analyses 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta",
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30jun2022)) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year 

sts graph, by(treatment) adjustfor(bmi agegp sex AF ckd cld copd HFH THFH CAD MI ACE BB antiarr insulin LD metformin spiro HFH THFH ppm)

** HR 0.81 (0.68-0.98) p =0.03 with weights 
** HR 0.82 (0.70-0.97)  p = 0.02 without weights 


*** STEP 8: Competing risk
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta",
drop outcome
gen follow_up2 =.
replace follow_up2= mdy(06,30,2022)
replace admission=. if admission>=follow_up2
replace dod=. if dod>=follow_up2
gen event = 0 if follow_up2~=.
replace event = 2 if dod ~=.
replace event = 1 if admission ~=. 
gen outcome = min(admission, dod,follow_up2)
gen time = outcome-dof
stset outcome, id(scrssn) origin(dof) failure(event==1) scale(365.25)
stcrreg treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year ,compete(event==2)

*** HR 0.70 (0.54-0.92) for HFH, p 0.01 with weights, HR 0.77 (0.61-0.96) P 0.02 without weights 
** 464 hospitalizations, 615 deaths 

*** STEP 8: Interaction 

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta",
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30jun2022)) scale(365.25)
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment i.treatment##i.ckd agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

*** HFpEF ABA score

gen aba = -7.788751 + 0.062564*age + 0.135149*bmi2 + 2.040806*AF
gen abas = 2.71828182845904*aba
gen ABA = abas/(1+abas)
gen hABA = 1 if ABA >0.80
replace hABA = 0 if hABA==.
preserve
keep if hABA == 1
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
restore
preserve
keep if hABA == 0
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
restore

*** ABA > 0.80 = 0.85 0.96 - 1.04 n= 1,431
*** ABA < 0.80 = 0.91 0.59 - 1.40 n = 391
stcox treatment i.treatment##i.hABA ckd agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
*** Interaction p value 0.9

*** re-do HFpEF ABA score (1/24/2026)

gen aba = -7.788751 + 0.062564*age + 0.135149*bmi2 + 2.040806*AF
gen abas = exp(aba)
gen ABA = abas/(1+abas)
*median ABA: 0.93 [0.83-0.98]
gen hABA = 1 if ABA >0.80
replace hABA = 0 if hABA==.
preserve
keep if hABA == 1
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
restore
preserve
keep if hABA == 0
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
restore

stcox treatment i.treatment##i.hABA ckd agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

