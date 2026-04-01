*** Cleaning medication files in glp1 group

*** STEP 1: Identifying patients on ACEI and or ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_ace.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_ace.dta", replace
*** 415 patients on ACEI

*** ARB
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_arb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arb.dta", replace
*** 353 patients on ARB

*** Merging ACEI and ARB
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_ace.dta",
unique scrssn
drop _merge
duplicates drop scrssn, force
keep scrssn 
gen ACE=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_ace_arb.dta", replace
*** 765 patients on ACEI or ARB
***********************************************************************************************************************************

*** STEP 2: Identifying patients on Betablockers
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_bb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
keep scrssn
gen BB=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_bb.dta", replace
*** 946 patients on BB

***********************************************************************************************************************************

*** STEP 3: Identifying patients on Antiarryhtmics
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_antiarr.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen antiarr=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_antiarr.dta", replace
*** 92 patients 


***********************************************************************************************************************************

*** STEP 4: Identifying patients on SGLT2 analogs
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_sglt2.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen sglt2=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2.dta", replace
*** 117 patients 



***********************************************************************************************************************************

*** STEP 5: Identifying patients on insulin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_insulin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen insulin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_insulin.dta", replace
*** 824 patients 


***********************************************************************************************************************************

*** STEP 6: Identifying patients on loop diuretic
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_loopdiuretic.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen LD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_loopdiuretic.dta", replace
***1195 patients 

***********************************************************************************************************************************

*** STEP 7: Identifying patients on metformin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_metformin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen metformin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_metformin.dta", replace
***269 patients 


***********************************************************************************************************************************

*** STEP 8: Identifying patients on MRA
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_spiroep.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen spiro=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_spiroep.dta", replace
***295 patients 


***********************************************************************************************************************************

*** STEP 9: Identifying patients on TZD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_thiazol.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen TZD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_thiazol.dta", replace
*** 7 patients 



***********************************************************************************************************************************

*** STEP 10: Identifying patients on statins
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_statin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen statin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_statin.dta", replace
*** 1192 patients 

***********************************************************************************************************************************


*** STEP 11: Identifying patients on aspirin
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_aspirin.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen aspirin=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_aspirin.dta", replace
***253 patients 

***********************************************************************************************************************************
*** STEP 13: Identifying patients on baseline ARNI 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_sacuval.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ARNI=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arni.dta", replace
*** 36 patients on ARNI at baseline 

***********************************************************************************************************************************

*** STEP 14: Identifying patients on ARNI at follow up
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_glp1_sacuafter.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ARNIfu=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arnifu.dta", replace
*** 189 patients on ARNI at follow up

***********************************************************************************************************************************

*** STEP 15: Merging ARNI at baseline and follow up
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arni.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arnifu.dta"
keep scrssn 
gen ARNIfull=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arnicomplete.dta", replace
*** 195 patinets on ARNI at baseline and follow up 

***********************************************************************************************************************************
*** STEP 16: Identifying SGLT at follow up 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\hfief_glp1sglt2.dta", clear
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen sglt2fu= 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2fu.dta", replace
*** 410 patients initiated on SGLT-2 in follow up 

***********************************************************************************************************************************
*** STEP 17: Merging SGL2i at baseline and follow up
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2fu.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen sglt2full= 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2complete.dta", replace
*** 447 patients initiated on SGLT-2 at baseline and follow up 


*** STEP 18: Merging all medications 

clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_ace_arb.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_bb.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_antiarr.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_insulin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_loopdiuretic.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_metformin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_spiroep.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_thiazol.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_statin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_aspirin.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arni.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arnicomplete.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_arnifu.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2fu.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_sglt2complete.dta"
drop _merge
replace ACE =0 if ACE==.
replace BB =0 if BB==.
replace antiarr =0 if antiarr==.
replace insulin=0 if insulin==.
replace LD=0 if LD==.
replace metformin=0 if metformin==.
replace spiro=0 if spiro==.
replace TZD=0 if TZD==.
replace statin=0 if statin==.
replace aspirin=0 if aspirin==.
replace sglt2=0 if sglt2==.
replace sglt2fu=0 if sglt2fu==.
replace ARNI=0 if ARNI==.
replace sglt2full=0 if sglt2full==.
replace ARNIfull=0 if ARNIfull==.
replace ARNIfu=0 if ARNIfu==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_final_med_merged.dta", replace
** 1397 patients on GLP1



