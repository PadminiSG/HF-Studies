
*** STEP 1: Cleaning baseline EF files for GLP1
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_efbefore.dta"
gen dof =dofc(glp1filltime)
gen efdate_before = dofc(ValueDateTime)
drop fillnumber patientsid ValueDateTime glp1filltime
gsort dof Low_Value
duplicates drop scrssn, force
gen treatment = 1
rename Low_Value ef
summarize ef, detail
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_efbefore_cleaned.dta", replace


*** STEP 2: Cleaning baseline EF files for DPP4
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_efbefore.dta"
gen dof =dofc(dpp4filltime)
gen efdate_before = dofc(ValueDateTime)
drop fillnumber patientsid ValueDateTime dpp4filltime
gsort dof low_Value
duplicates drop scrssn, force
gen treatment = 0
rename low_Value ef
summarize ef, detail
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4_efbefore_cleaned.dta", replace

*** STEP 3: merge EF files
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_efbefore_cleaned.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4_efbefore_cleaned.dta"
drop if _merge==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_efbefore_cleaned_merged.dta", replace