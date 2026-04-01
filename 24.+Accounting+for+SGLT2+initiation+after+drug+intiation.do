

*** STEP 1: Cleaning SGLT initiation after in DPP4 files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_sglt2_after.dta", replace
gen treatment =0
gen sglt_after =1 
keep scrssn treatment sglt_after
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_sglt2_after_cleaned.dta", replace

*** STEP 2: Cleaning SGLT initiation after in GLP1 files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_sglt2_after.dta", replace
gen treatment =1
gen sglt_after = 1 
keep scrssn treatment sglt_after
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_sglt2_after_cleaned.dta", replace

*** STEP 3: Merging these two files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_sglt2_after_cleaned.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_sglt2_after_cleaned.dta"
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_sglt2_after_cleaned.dta", replace 

*** STEP 4: Survival analysis 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta",
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_sglt2_after_cleaned.dta"
drop if _merge ==2
drop _merge
replace sglt_after = 0 if sglt_after==.
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30jun2022)) scale(365.25)
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year sglt_after weight2
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year sglt_after

**** Interaction between SGLT2 and GLP1
stcox i.treatment##i.sglt_after agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

