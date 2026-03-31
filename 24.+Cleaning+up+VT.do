clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_vt.dta", clear
merge m:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_vt.dta",
drop if _merge ==3
gen discharge= dofc(DischargeDateTime)
gen dpp4 = cofd(dpp4filltime)
gen dof= dofc(dpp4)
drop if discharge - dof < 8
*** blanking period of 1 week post drug initiation
by scrssn discharge, sort: gen scrssn_n = _n
keep if scrssn_n == 1
duplicates drop scrssn, force
gen treatment = 1 if dpp4filltime ==.
replace treatment = 0 if treatment ==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hf_dpp4glp1_glp1_vt.dta", replace