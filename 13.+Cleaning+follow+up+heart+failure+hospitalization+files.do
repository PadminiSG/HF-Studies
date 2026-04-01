**** STEP 1: Cleaning admission diagnosis with HF hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\hfref_glp1_hfhospitalization.dta"
gen dof= dofc(glp1filltime)
gen admission= dofc(DischargeDateTime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn admission 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_hf_admission.dta", replace 
*** 304 hospitalizations for HF

**** STEP 2: Cleaning admission diagnosis with HF hospitalization file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\hfref_dpp4glp1_hfhospitalization.dta", clear
gen dof= dofc(dpp4filltime)
gen admission= dofc(DischargeDateTime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn admission
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_hf_admission.dta", replace 
*** 550 hospitalizations for HF 

**** STEP 3: Merging  GLP1 and DPP4i HF hospitalizations 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_hf_admission.dta",
gen treatment =1
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_hf_admission.dta"
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hf_dpp4glp1_glp1_hfh.dta", replace 
**** 852 hospitalizations 





