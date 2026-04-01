**** STEP 1: Cleaning discharge diagnosis with MI hospitalization file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_miafter.dta"
gen admission_mi = dofc( comorbidity_Dischargedatetime)
keep scrssn admission_mi
gen mi_after=1
by scrssn admission_mi, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_miafter.dta", replace 


**** STEP 2: Cleaning discharge diagnosis with MI hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_miafter.dta"
gen admission_mi = dofc( comorbidity_Dischargedatetime)
keep scrssn admission_mi
gen mi_after=1
by scrssn admission_mi, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_miafter.dta", replace 


**** STEP 3: Cleaning admission diagnosis with revascularization in DPP4 patients 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_cpafter.dta"
gen admission_mi = dofc(surgdate)
keep scrssn admission_mi
gen mi_after=1
by scrssn admission_mi, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_cpafter.dta", replace 

**** STEP 4: Cleaning admission diagnosis with revascularization in GLP1 patients 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_cabgpciafter.dta"
gen admission_mi = dofc(surgdate)
keep scrssn admission_mi
gen mi_after=1
by scrssn admission_mi, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_cpafter.dta", replace 


**** STEP 5: merging MI CABG PCI for DPP4i
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_miafter.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_cpafter.dta",
drop _merge
gen treatment=0
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_mi_revasc.dta",replace 

**** STEP 6: merging MI CABG PCI for GLP1
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_miafter.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_cpafter.dta",
drop _merge
gen treatment=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_mi_revasc.dta",replace 

**** STEP 7: Merging MI CABG PCI GLP1 and DPP4 files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_mi_revasc.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_mi_revasc.dta"
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_dpp4_mi_revasc.dta",replace