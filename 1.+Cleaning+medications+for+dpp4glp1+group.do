*** Cleaning medication files in DPP4 group

*** STEP 1: Identifying patients on ACEI and or ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFiEF GLP1\diabetes_hfief_dpp4glp1_ace.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ace.dta", replace
*** 368 patients on ACE

*** STEP 1: ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_arb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arb.dta", replace
*** 265 patients on ARB

*** Merging ACEI and ARB
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ace.dta",
unique scrssn
drop _merge
duplicates drop scrssn, force
keep scrssn 
gen ACE=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ace_arb.dta", replace
*** 628 patients on ACEI or ARB
***********************************************************************************************************************************

*** STEP 2: Identifying patients on Betablockers
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_bb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
keep scrssn
gen BB=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_bb.dta", replace
*** 795 patients on BB

***********************************************************************************************************************************

*** STEP 3: Identifying patients on Antiarryhtmics
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_antiarr.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen antiarr=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_antiarr.dta", replace
*** 124 patients 

***********************************************************************************************************************************

*** STEP 4: Identifying patients on SGLT-2 analogs
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_sglt2.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen sglt2=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2.dta", replace
***29 patients 



***********************************************************************************************************************************

*** STEP 5: Identifying patients on insulin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_insulin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen insulin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_insulin.dta", replace
***145 patients 


***********************************************************************************************************************************

*** STEP 6: Identifying patients on loop diuretic
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_loop.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen LD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_loop.dta", replace
***1035 patients on loop diuretic 

***********************************************************************************************************************************

*** STEP 7: Identifying patients on metformin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_metfor.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen metformin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_metfor.dta", replace
***292 patients 


***********************************************************************************************************************************

*** STEP 8: Identifying patients on MRA
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_spiroep.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen spiro=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_spiroep.dta", replace
*** 253 patients on mra


***********************************************************************************************************************************

*** STEP 9: Identifying patients on SU
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_su.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen SU=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_su.dta", replace
***10 patients 


***********************************************************************************************************************************

*** STEP 10: Identifying patients on TZD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_thiazol.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen TZD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_thiazol.dta", replace
***4 patients 



***********************************************************************************************************************************

*** STEP 11: Identifying patients on statins
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_statin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen statin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_statin.dta", replace
***1020 patients 

***********************************************************************************************************************************
*** STEP 12: Identifying patients on Aspirin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_aspirin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen aspirin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_aspirin.dta", replace
***182 patients 

***********************************************************************************************************************************

*** STEP 13: Identifying patients on baseline ARNI 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_sacuval.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ARNI=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arni.dta", replace
*** 16 patients on ARNI at baseline 

***********************************************************************************************************************************

*** STEP 14: Identifying patients on ARNI at follow up
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_sacuaf.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ARNIfu=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arnifu.dta", replace
*** 183 patients on ARNI at follow up

***********************************************************************************************************************************

*** STEP 15: Merging ARNI at baseline and follow up
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arni.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arnifu.dta"
keep scrssn 
gen ARNIfull=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arnicomplete.dta", replace
*** 184 patinets on ARNI at baseline and follow up 

***********************************************************************************************************************************
*** STEP 16: Identifying SGLT at follow up 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\hfief_dpp4sglt2.dta", clear
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen sglt2fu= 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2fu.dta", replace
*** 183 patients initiated on SGLT-2 in follow up 

***********************************************************************************************************************************
*** STEP 17: Merging SGL2i at baseline and follow up
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2fu.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen sglt2full= 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2complete.dta", replace
*** 204 patients initiated on SGLT-2 at baseline and follow up 

*** STEP 18: Merging all medications 

clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ace_arb.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_bb.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_antiarr.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_insulin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_loop.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_metfor.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_spiroep.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_su.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_thiazol.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_statin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_aspirin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arni.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arnicomplete.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2complete.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_sglt2fu.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_arnifu.dta"
drop _merge
replace ACE =0 if ACE==.
replace BB =0 if BB==.
replace antiarr =0 if antiarr==.
replace insulin=0 if insulin==.
replace LD=0 if LD==.
replace metformin=0 if metformin==.
replace spiro=0 if spiro==.
replace SU=0 if SU==.
replace TZD=0 if TZD==.
replace statin=0 if statin==.
replace aspirin=0 if aspirin==.
replace sglt2=0 if sglt2==.
replace sglt2fu=0 if sglt2fu==.
replace ARNI=0 if ARNI==.
replace sglt2full=0 if sglt2full==.
replace ARNIfull=0 if ARNIfull==.
replace ARNIfu=0 if ARNIfu==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_final_med_merged.dta", replace
***1293 patients




