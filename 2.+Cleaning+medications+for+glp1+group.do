*** Cleaning medication files in glp1 group

*** STEP 1: Identifying patients on ACEI and or ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_ace.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ace.dta", replace
*** 216 patients on ACEI

*** ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_arb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_arb.dta", replace
*** 207 patients on ARB

*** Merging ACEI and ARB
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ace.dta",
unique scrssn
drop _merge
duplicates drop scrssn, force
keep scrssn 
gen ACE=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ace_arb.dta", replace
*** 422 patients on ACEI or ARB
***********************************************************************************************************************************

*** STEP 2: Identifying patients on Betablockers
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_bb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
keep scrssn
gen BB=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_bb.dta", replace
*** 491 patients on BB

***********************************************************************************************************************************

*** STEP 3: Identifying patients on Antiarryhtmics
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_antiarr.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen antiarr=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_antiarr.dta", replace
*** 43 patients 


***********************************************************************************************************************************

*** STEP 4: Identifying patients on SGLT2 analogs
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_sglt2.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen SGLT2=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_sglt2.dta", replace
*** 85 patients 



***********************************************************************************************************************************

*** STEP 5: Identifying patients on insulin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_insulin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen insulin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_insulin.dta", replace
*** 703 patients 


***********************************************************************************************************************************

*** STEP 6: Identifying patients on loop diuretic
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_loopdiuretic.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen LD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_loopdiuretic.dta", replace
***1018 patients 

***********************************************************************************************************************************

*** STEP 7: Identifying patients on metformin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_metformin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen metformin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_metformin.dta", replace
***227 patients 


***********************************************************************************************************************************

*** STEP 8: Identifying patients on MRA
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_spiroep.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen spiro=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_spiroep.dta", replace
***115 patients 


***********************************************************************************************************************************

*** STEP 9: Identifying patients on TZD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_thiazol.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen TZD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_thiazol.dta", replace
*** 5 patients 



***********************************************************************************************************************************

*** STEP 10: Identifying patients on statins
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_statin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen statin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_statin.dta", replace
*** 968 patients 

***********************************************************************************************************************************


*** STEP 11: Identifying patients on aspirin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_aspirin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen aspirin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_aspirin.dta", replace
***196 patients 

***********************************************************************************************************************************

*** STEP 12: Merging all medications 

clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ace_arb.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_bb.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_antiarr.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_sglt2.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_insulin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_loopdiuretic.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_metformin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_spiroep.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_thiazol.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_statin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_aspirin.dta"
drop _merge
replace ACE =0 if ACE==.
replace BB =0 if BB==.
replace antiarr =2 if antiarr==.
replace SGLT2 =0 if SGLT2==.
replace insulin=2 if insulin==.
replace LD=0 if LD==.
replace metformin=0 if metformin==.
replace spiro=0 if spiro==.
replace TZD=0 if TZD==.
replace statin=0 if statin==.
replace aspirin=0 if aspirin==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_final_med_merged.dta", replace
** 1122 patients on GLP1



