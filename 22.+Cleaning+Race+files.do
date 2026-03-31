*** Cleaning Race files
*** DPP4
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_race.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn Race 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_race.dta", replace
***2339 patients

*** GLP1
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_race.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn Race 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_race.dta", replace
***1470 patients

*** Cleaning ACE files
*** DPP4
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_ace.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
gen ACE2=1
keep scrssn ACE2
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_ace.dta", replace
*** 750 patients on ACE

*** GLP1
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_ace.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
gen ACE2=1
keep scrssn ACE2
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_ace.dta", replace
*** 381 patients

***ARB Files
*** DPP4
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_arb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
gen ARB=1
keep scrssn ARB
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_arb.dta", replace
*** 467 Patients

*** GLP1
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_arb.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
gen ARB=1
keep scrssn ARB
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hfref_glp1_arb.dta", replace
*** 397 patients on ARB

*** Merge race files
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_race.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_race.dta"
drop if _merge ==3
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_final_glp1_dpp4.dta"
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_glp1_dpp4_race.dta",replace

*** Merge ACEand ARB Files
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_ace.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_arb.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_ace.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hfref_glp1_arb.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_final_glp1_dpp4.dta"
drop if _merge==1
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_glp1_dpp4_acearb.dta", replace