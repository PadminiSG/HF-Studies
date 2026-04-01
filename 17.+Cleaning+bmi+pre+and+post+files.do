
***DPP4i 

*** STEP 1: Cleaning BMI files at baseline 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi.dta"
rename ScrSSN scrssn
drop patientsid HeightTime heightresult
gen bmipre = round(bmi,1)
gen weightpre = round(weightresult,1)
drop bmi weightresult
format %td WeightTime
rename WeightTime wttimepre
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_pre.dta", replace

*** STEP 2: Cleaning BMI files post drug initiation 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_after.dta"
rename ScrSSN scrssn
drop patientsid HeightTime heightresult
gen bmipost = round(bmi,1)
gen weightpost = round(weightresult,1)
drop bmi weightresult
format %td WeightTime
rename WeightTime wttimepost
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_post.dta", replace


*** STEP 3: Merging BMI files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_pre.dta"
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_post.dta"
drop if _merge==2
drop _merge
drop if weightpost < 50
drop if weightpost < 100
drop if weightpost > 500
bysort scrssn weightpost: keep if _n ==1
duplicates drop scrssn, force
gen wtchange = 100*(weightpre- weightpost)/ weightpost
gen treatment =0
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_change.dta", replace 


*** GLPi


*** STEP 4: Cleaning BMI files at baseline 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi.dta"
rename ScrSSN scrssn
drop patientsid HeightTime heightresult
gen bmipre = round(bmi,1)
gen weightpre = round(weightresult,1)
drop bmi weightresult
format %td WeightTime
rename WeightTime wttimepre
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_pre.dta", replace

*** STEP 5: Cleaning BMI files post drug initiation 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_after.dta"
rename ScrSSN scrssn
drop patientsid HeightTime heightresult
gen bmipost = round(bmi,1)
gen weightpost = round(weightresult,1)
drop bmi weightresult
format %td WeightTime
rename WeightTime wttimepost
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_post.dta", replace


*** STEP 6: Merging BMI files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_pre.dta"
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_post.dta"
drop if _merge ==2
drop _merge
drop if weightpost < 50
drop if weightpost < 100
drop if weightpost >500
bysort scrssn weightpost: keep if _n ==1
duplicates drop scrssn, force
gen wtchange = 100*(weightpre- weightpost)/ weightpost
gen treatment = 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_change.dta", replace

*** STEP 7: Merging DPP4i and GLPi files 
clear all 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_bmi_change.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bmi_change.dta"
drop if _merge ==3
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_bmi_change.dta", replace 




**** STEP 8: Imputation of missing data
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_bmi_change.dta"
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta",
drop if _merge ==1
drop _merge
mi set wide
mi register imputed wtchange
drop if age ==.
mi impute regress wtchange age treatment sex year ACE BB insulin metformin LD AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse schizo spiro, add(20) rseed(1234) force
replace wtchange = ( _1_wtchange + _2_wtchange + _3_wtchange + _4_wtchange + _5_wtchange + _6_wtchange + _7_wtchange + _8_wtchange + _9_wtchange + _10_wtchange + _11_wtchange + _12_wtchange + _13_wtchange + _14_wtchange + _15_wtchange + _16_wtchange + _17_wtchange + _18_wtchange + _19_wtchange + _20_wtchange)/20 if wtchange ==.
summarize wtchange if treatment ==1
summarize wtchange if treatment ==0
ttest wtchange, by (treatment)

***Another attempt
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_bmi_change.dta"
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta"
drop if _merge ==1
drop _merge
drop outcome failure
replace admission=. if admission>follow_up
replace dod=. if dod>follow_up
gen outcome = min(admission, dod, follow_up)
gen failure =0 if admission==. & dod==.
replace failure = 1 if failure ==.

drop wtchange
gen wtchange=100*(weightpost- weightpre)/ weightpre
mi set wide
mi register imputed wtchange
mi register regular scrssn treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
mi impute regress wtchange age treatment sex year ACE BB insulin metformin LD AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse schizo spiro, add(20) rseed(1234) force

mi estimate: regress wtchange treatment
mi estimate: mean wtchange, over(treatment)
mi estimate: qreg wtchange treatment

*Subgroup analysis with wtchange
mi stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30jun2022)) scale(365.25)
*including wtchange in Cox model
mi estimate, hr: stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year wtchange weight2

mi passive: gen wtchangecat=.
mi passive: replace wtchangecat=1 if wtchange < -15
mi passive: replace wtchangecat=2 if wtchange >=-15 & wtchange < -7.5
mi passive: replace wtchangecat=3 if wtchange >=-7.5 & wtchange < 0
mi passive: replace wtchangecat=4 if wtchange >= 0

mi estimate, hr: stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year wtchangecat weight2

mi estimate, hr: stcox i.treatment##i.wtchangecat agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2
testparm i.treatment#i.wtchangecat 

mi estimate, hr: stcox i.treatment##c.wtchange agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2



