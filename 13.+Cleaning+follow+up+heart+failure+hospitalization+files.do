**** STEP 1: Cleaning discharge diagnosis with HF hospitalization file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFiEF GLP1\hfief_dpp4glp1_hfhospitalization.dta"
gen admission= dofc(DischargeDateTime)
gen dof = dofc(dpp4filltime)
drop if admission - dof < 8
*** blanking period of 1 week post drug initiation
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn ICD9Code admission dof
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_hf_admission.dta", replace 
***379

**** STEP 2: Cleaning discharge diagnosis with HF hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFiEF GLP1\hfief_glp1_hfhospitalization.dta"
gen admission= dofc(DischargeDateTime)
gen dof= dofc(glp1filltime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn ICD9Code admission dof
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_hf_admission.dta", replace 
***443

/***** STEP 3: Cleaning admission diagnosis with HF hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFiEF GLP1\hfief_glp1_hfddhospi.dta"
gen glp1 = cofd(glp1filltime)
gen dof= dofc(glp1)
drop glp1
gen admission= dofc(AdmitDateTime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn dof admission 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_hf_admission.dta", replace 
*** 452 hospitalizations for HF

**** STEP 4: Cleaning admission diagnosis with HF hospitalization file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\dpp4glp1_hfddhospi.dta"
gen dpp4 = cofd(dpp4filltime)
gen dof= dofc(dpp4)
drop dpp4
gen admission= dofc(AdmitDateTime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn dof admission 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hf_admission.dta", replace 
*** 410 hospitalizations for HF 

*** STEP 5: Merging admission and discharge diagnosis heart failure hospitalization files in DPP4i patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_fhfh.dta"
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hf_admission.dta"
gen dischargeonly = 1 if _merge ==1
drop _merge
replace dischargeonly = 0 if dischargeonly==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hf_admission_discharge.dta", replace 
*** 570 hospitalizations 

*** STEP 6:  Merging admission and discharge diagnosis heart failure hospitalization files in GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_fhfh.dta"
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hf_admission.dta"
gen dischargeonly = 1 if _merge ==1
drop _merge
replace dischargeonly = 0 if dischargeonly==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hf_admission_discharge.dta", replace 
*** 622 hospitalizations 

**** STEP 7: Merging GLP1 and DPP4 admission/discharge hospitalization files (only from admission files )
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hf_admission.dta",
gen treatment =1
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hf_admission.dta"
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\diabetes_hf_dpp4glp1_glp1_hf_discharge.dta", replace 
**** 862 patients */

**** STEP 8: MErging admission and discharge diagnosis for GLP1 and DPP4i
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_hf_admission.dta",
gen treatment =1
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_hf_admission.dta"
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\diabetes_hfief_dpp4glp1_glp1_hf_admission.dta", replace 
**** 814 patients




