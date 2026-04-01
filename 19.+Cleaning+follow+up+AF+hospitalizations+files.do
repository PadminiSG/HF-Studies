**** STEP 1: Cleaning Afib file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_afibaf.dta"
rename ScrSSN scrssn
gen admission_af = dofc( comorbidity_Dischargedatetime)
keep scrssn admission_af
gen af_after=1
by scrssn admission_af, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
duplicates drop scrssn, force
gen treatment=0
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_afibaf.dta", replace 


**** STEP 2: Cleaning Afib file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_afafter.dta"
rename ScrSSN scrssn
gen admission_af = dofc( comorbidity_Dischargedatetime)
keep scrssn admission_af
gen af_after=1
by scrssn admission_af, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
duplicates drop scrssn, force
gen treatment=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_afafter.dta", replace 


**** STEP 3: Merging Afib GLP1 and DPP4 files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_afibaf.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_afafter.dta"
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_dpp4_af_after.dta",replace


