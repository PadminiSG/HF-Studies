*** Cleaning medication files in DPP4 group
**Change directory
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1"

*** STEP 1a: Identifying patients on ACEI and or ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_ace.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_ace.dta"
*** 595 patients on ACEI

*** STEP 1b: ARB
clear
 use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_arb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_arb.dta"
*** 369 patients on ARB

*** Merging ACEI and ARB
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_ace.dta",
unique scrssn
drop _merge
duplicates drop scrssn, force
keep scrssn 
gen ACEARB=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_acearb.dta"
*** 954 patients on ACEI or ARB
***********************************************************************************************************************************

*** STEP 2: Identifying patients on Betablockers
clear
 use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_bb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
keep scrssn
gen BB=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bb.dta"
*** 1156 patients on BB

***********************************************************************************************************************************

*** STEP 3: Identifying patients on Antiarryhtmics
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_antiarr.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen antiarr=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_antiarr.dta"
*** 168 patients 


***********************************************************************************************************************************

*** STEP 4: Identifying patients on SGLT-2 analogs
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_sglt2.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen SGLT2=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_sglt2.dta", replace
***45 patients 



***********************************************************************************************************************************

*** STEP 5: Identifying patients on insulin
clear
use use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_insulin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen insulin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_insulin.dta", replace
***222 patients 


***********************************************************************************************************************************

*** STEP 6: Identifying patients on loop diuretic
clear
use use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_loop.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen LD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_loop.dta"
***1463 patients on loop diuretic 

***********************************************************************************************************************************

*** STEP 7: Identifying patients on metformin
clear
 use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_metfor.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen metformin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_metfor.dta"
***422 patients 


***********************************************************************************************************************************

*** STEP 8: Identifying patients on MRA
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_spiroep.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen spiro=1
 save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_spiroep.dta"
*** 349 patients on mra


***********************************************************************************************************************************

*** STEP 9: Identifying patients on SU
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_su.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen SU=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_su.dta"
***13 patients 
*** From SQL extraction of individual meds, we filtered medications that needed >1 Refill and put a stop date filter from date of prescription of DPP4/SU, so this number is not accurate.
*** From Drgdose table: there are 1,441 patients on SU
*** Same problem when finding patients on DPP4i


***********************************************************************************************************************************

*** STEP 10: Identifying patients on TZD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_thiazol.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen TZD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_thiazol.dta"
***4 patients 



***********************************************************************************************************************************

*** STEP 11: Identifying patients on statins
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_statin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen statin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_statin.dta"
***1458 patients 

***********************************************************************************************************************************



*** STEP 12: Identifying patients on Aspirin
clear
 use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_aspirin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen aspirin=1
 save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_aspirin.dta"
***250 patients 

***********************************************************************************************************************************

*** STEP 13: Identifying patients on Entresto
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_sacuval.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen entresto=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_sacuval.dta"
***41 patients

*** STEP 14: Identifying patients on ARNI at follow up
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files\diabetes_hfmref_dpp4glp1_sacuaf.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ARNIfu=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_glp1_sacuafter.dta"
*** 289 patients on ARNI at follow up

*** STEP 15: Merging ARNI at baseline and follow up
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_sacuval.dta"
 merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_sacuafter.dta"
keep scrssn 
gen ARNIfull=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_arnicomplete.dta", replace
*** 292 patinets on ARNI at baseline and follow up 

*** STEP 16: Merging all medications 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_acearb.dta"
_drop merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bb.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_antiarr.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_sglt2.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_insulin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_loop.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_metfor.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_spiroep.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_su.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_thiazol.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_statin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_aspirin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_sacuval.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_sacuafter.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_arnicomplete.dta"
drop _merge

replace ACEARB=0 if ACEARB==.
replace BB=0 if BB==.
replace antiarr=0 if antiarr==.
replace insulin=0 if insulin==.
replace SGLT2=0 if SGLT==.
replace LD=0 if LD==.
replace metformin=0 if metformin==.
replace spiro=0 if spiro==.
replace SU=0 if SU==.
replace TZD=0 if TZD==.
replace statin=0 if statin==.
replace aspirin=0 if aspirin==.
replace entresto=0 if entresto==.
replace ARNIfu=0 if ARNIfu==.
replace ARNIfull=0 if ARNIfull==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_med_merged.dta"
***1835 Patients
