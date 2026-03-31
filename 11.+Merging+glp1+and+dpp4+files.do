
*** Merging both GLP1 and DPP4 files
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfref_dpp4glp1_final_merged.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\glp1\diabetes_hfref_glp1_final_merged.dta"
drop if _merge ==3
order scrssn dpp4 glp1
gen treatment =1 if glp1==1
replace treatment =0 if dpp4==1
order scrssn dpp4 glp1 treatment
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_final_glp1_dpp4.dta", replace
** 3797