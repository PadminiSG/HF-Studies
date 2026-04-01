
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_age.dta"
gen dpp4 = cofd(DPP4Filltime)
gen dof= dofc(dpp4)
drop dpp4
drop DPP4Filltime
duplicates drop ScrSSN, force
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_glp1_age.dta"
drop if _merge ==3
duplicates drop scrssn, force
rename ScrSSN scrssn
gen glp1= cofd(glp1Filltime)
gen glp1new =dofc(glp1)
replace dof= glp1new if dof==.
count if dof==.
count if age ==.
keep scrssn age dof
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\final_age_dof.dta", replace
