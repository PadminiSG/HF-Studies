



clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_age.dta", clear
gen dpp4 = cofd(DPP4Filltime)
gen dof= dofc(dpp4)
drop dpp4
drop DPP4Filltime
drop dob
duplicates drop ScrSSN, force
merge 1:m ScrSSN using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_age.dta"
drop if _merge ==3
duplicates drop ScrSSN, force
rename ScrSSN scrssn
gen glp1= cofd(glp1Filltime)
gen glp1new =dofc(glp1)
replace dof= glp1new if dof==.
count if dof==.
count if age ==.
keep scrssn age dof
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_age_dof.dta", replace
