**** STEP 1: Cleaning admission diagnosis with HF hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\glp1_hfddhospi.dta"
gen glp1 = cofd(glp1filltime)
gen dof= dofc(glp1)
drop glp1
gen admission= dofc(AdmitDateTime)
drop if admission - dof < 8
duplicates drop admission, force
sort scrssn admission
bysort scrssn(admission): gen scrssn_n=_n
keep scrssn admission scrssn_n
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hf_admission_repeat.dta", replace 
*** 231 recurrent hospitalizations for AF

**** STEP 2: Cleaning admission diagnosis with HF hospitalization file for FPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\dpp4glp1_hfddhospi.dta"
gen dpp4 = cofd(dpp4filltime)
gen dof= dofc(dpp4)
drop dpp4
gen admission= dofc(AdmitDateTime)
drop if admission - dof < 8
duplicates drop admission, force
sort scrssn admission
bysort scrssn(admission): gen scrssn_n=_n
keep scrssn admission scrssn_n
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hf_admission_repeat.dta", replace 


**** STEP 3: Merging  GLP1 and DPP4i HF hospitalizations 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hf_admission_repeat.dta",
gen treatment =1
merge m:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hf_admission_repeat.dta"
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_finalhf_admission_repeat.dta", replace 
**** 2037 repeating events  





