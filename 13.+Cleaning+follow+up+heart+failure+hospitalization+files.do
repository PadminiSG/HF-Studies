**** STEP 1: Cleaning discharge diagnosis with HF hospitalization file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\hfmref_dpp4glp1_hfhosp.dta"

gen discharge= dofc(DischargeDateTime)
gen dpp4 = cofd(dpp4filltime)
gen dof= dofc(dpp4)
drop dpp4
drop if discharge - dof < 8
*** blanking period of 1 week post drug initiation
by scrssn discharge, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn ICD9Code discharge dof
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_fhfh.dta", replace 
***459
***checked on 9/21/25 --> no changes to event counts, last discharge on August 2024

**** STEP 2: Cleaning discharge diagnosis with HF hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\hfmref_glp1_hfhosp.dta"
gen discharge= dofc(DischargeDateTime)
gen glp1 = cofd(glp1filltime)
gen dof= dofc(glp1)
drop glp1
drop if discharge - dof < 8
by scrssn discharge, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn ICD9Code discharge dof
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_fhfh.dta" 
***253

*** Step 2a:

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_fhfh.dta" 
gen treatment =1
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_fhfh.dta"
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_glp1_hfh.dta", replace

**** STEP 3: Cleaning admission diagnosis with HF hospitalization file for GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\hfmref_glp1_allddhospi.dta"
gen glp1 = cofd(glp1filltime)
gen dof= dofc(glp1)
drop glp1
gen admission= dofc(AdmitDateTime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn dof admission 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_hf_admission.dta", replace 
*** 767 hospitalizations for HF

**** STEP 4: Cleaning admission diagnosis with HF hospitalization file for DPP4 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\hfmref_dpp4glp1_allddhospi.dta"
gen dpp4 = cofd(dpp4filltime)
gen dof= dofc(dpp4)
drop dpp4
gen admission= dofc(AdmitDateTime)
drop if admission - dof < 8
by scrssn admission, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
keep scrssn dof admission 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_hf_admission.dta", replace 
*** 1340 hospitalizations for HF 
*** not exactly sure what the "allddhospi" database contains. I see lots of ICD codes for non-HF diagnoses

**STOPPED HERE ON 5/2/2025

*** STEP 5: Merging admission and discharge diagnosis heart failure hospitalization files in DPP4i patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_fhfh.dta"
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_hf_admission.dta"
gen dischargeonly = 1 if _merge ==1
drop _merge
replace dischargeonly = 0 if dischargeonly==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_hf_admission_discharge.dta", replace 
*** 1341 hospitalizations 

*** STEP 6:  Merging admission and discharge diagnosis heart failure hospitalization files in GLP1 patients
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_fhfh.dta" 
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_hf_admission.dta"
gen dischargeonly = 1 if _merge ==1
drop _merge
replace dischargeonly = 0 if dischargeonly==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_hf_admission_discharge.dta", replace 
*** 767 hospitalizations 

**** STEP 7: Merging GLP1 and DPP4 admission/discharge hospitalization files (only from admission files)
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_hf_admission.dta"
gen treatment =1
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_hf_admission.dta"
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_glp1_hf_discharge.dta", replace 
**** 2101 patients 

**** STEP 8: Merging admission and discharge diagnosis for GLP1 and DPP4i
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_hf_admission_discharge.dta", 
gen treatment =1
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_glp1_hf_admission_discharge.dta", 
drop if _merge ==3
replace treatment = 0 if treatment ==.
drop _merge 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hf_dpp4glp1_glp1_hf_admission_discharge.dta", replace 
**** 2103 patients




