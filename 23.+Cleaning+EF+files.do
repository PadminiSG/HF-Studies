
*** STEP 1: Cleaning baseline EF files for GLP1
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_efbefore.dta"
gen dof =dofc(glp1filltime)
gen efdate_before = dofc(ValueDateTime)
drop fillnumber patientsid ValueDateTime glp1filltime
gsort dof Low_Value
drop if Low_Value <50
drop if Low_Value >75
duplicates drop scrssn, force
gen treatment = 1
rename Low_Value ef_before
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_efbefore_cleaned.dta", replace

*** STEP 2: Cleaning follow up EF files for GLP1
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_efafter.dta"
gen efdate_after = dofc(ValueDateTime)
drop fillnumber patientsid ValueDateTime glp1filltime
rename Low_value ef_after
gen treatment = 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_efafter_cleaned.dta", replace

*** STEP 3: Merging baseline and follow up ef files for GLP1
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_efbefore_cleaned.dta"
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_efafter_cleaned.dta" 
drop High_Value
drop if efdate_after-dof<90
drop if ef_after <10
gsort scrssn efdate_after
bysort scrssn: gen scrssn_n=_n
drop _merge
bysort scrssn: egen t =max(scrssn_n)
keep if (scrssn_n==t)
count if ef_before-ef_after > 5
*** 301
count if ef_after==.
*** 159
drop scrssn_n t
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_ef_pre_post.dta", replace 


*** STEP 4: Cleaning baseline EF files for DPP4
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_efbefore.dta"
gen dof =dofc(dpp4filltime)
gen efdate_before = dofc(ValueDateTime)
drop fillnumber patientsid ValueDateTime dpp4filltime
gsort dof low_Value
drop if low_Value <50
drop if low_Value >75
duplicates drop scrssn, force
gen treatment = 0
rename low_Value ef_before
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_efbefore_cleaned.dta", replace

*** STEP 5: Cleaning follow up EF files for Dpp4
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4glp1_efafter.dta"
gen efdate_after = dofc(ValueDateTime)
drop fillnumber patientsid ValueDateTime dpp4filltime
rename low_value ef_after
gen treatment = 0
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_efafter_cleaned.dta", replace

*** STEP 6: Merging baseline and follow up ef files for Dpp4
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_efbefore_cleaned.dta"
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_efafter_cleaned.dta" 
drop High_Value
drop if efdate_after-dof<90
drop if ef_after <10
gsort scrssn efdate_after
bysort scrssn: gen scrssn_n=_n
drop _merge
bysort scrssn: egen t =max(scrssn_n)
keep if (scrssn_n==t)
count if ef_before-ef_after > 5
*** 321
count if ef_after==.
*** 143
drop scrssn_n t
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_ef_pre_post.dta", replace 

*** STEP 7: Merging EF files for DPP4 and GLP1
clear all  
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_ef_pre_post.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_ef_pre_post.dta"
drop if _merge ==3
drop _merge
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp_dpp4_ef_pre_post.dta", replace 


*** STEP 8: Imputation of missing data 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp_dpp4_ef_pre_post.dta"
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta",
drop if _merge ==1
drop _merge
mi set wide
mi register imputed ef_after
drop if age ==.
mi impute regress ef_after age treatment sex year ACE BB insulin metformin LD AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse schizo spiro, add(20) rseed(1234) force
replace ef_after = ( _1_ef_after + _2_ef_after + _3_ef_after + _4_ef_after + _5_ef_after + _6_ef_after + _7_ef_after + _8_ef_after + _9_ef_after + _10_ef_after + _11_ef_after + _12_ef_after + _13_ef_after + _14_ef_after + _15_ef_after + _16_ef_after + _17_ef_after + _18_ef_after + _19_ef_after + _20_ef_after)/20 if ef_after ==.
gen efchange = ef_before -ef_after
summarize efchange, detail
summarize efchange if treatment ==1
summarize efchange if treatment ==0
ttest efchange, by (treatment)


