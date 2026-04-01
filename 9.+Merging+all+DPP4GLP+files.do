
*** Merging all DPP4 files

******************************************************************************************************************************************
*** STEP 1: Merging all files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_med_merged.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_final_comorbidities_merged.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_final_lab_merged.dta"
drop _merge 
gen dpp4=1
order scrssn 



******************************************************************************************************************************************
*** STEP 2: Replacing missed values in medications to 0 
replace ACEARB = 0 if ACEARB==.
replace BB=0 if BB==.
replace antiarr=0 if antiarr ==.
replace insulin = 0 if insulin ==.
replace LD= 0 if LD ==.
replace metformin = 0 if metformin ==.
replace spiro =0 if spiro ==.
replace statin=0 if statin ==.
replace aspirin=0 if aspirin==.
replace TZD = 0 if TZD==.
replace SU = 0 if SU==.
replace ARNI = 0 if ARNI ==.
replace ARNIfull = 0 if ARNIfull ==.
replace ARNIfu = 0 if ARNIfu ==.
replace SGLT2 = 0 if SGLT2==.
replace device = 0 if device ==.


******************************************************************************************************************************************
*** STEP 3: Replacing missed values in comorbidities to 0
replace AF = 0 if AF==.
replace copd = 0 if copd ==.
replace depression =0 if depression ==.
replace esrd =0 if esrd ==.
replace alcohol = 0 if alcohol ==.
replace hypothyroidism = 0 if hypothyroidism ==.
replace hypertension = 0 if hypertension ==.
replace CAD = 0 if CAD ==.
replace MI =0 if MI ==.
replace ckd =0 if ckd ==.
replace cld =0 if cld ==.
replace cancer =0 if cancer ==.
replace pad =0 if pad ==.
replace polyabuse = 0 if polyabuse ==.
replace ppm =0 if ppm ==.
replace schizo =0 if schizo ==.
replace stroke =0 if stroke ==.
replace CRT = 0 if CRT==.
replace ICD = 0 if ICD ==.
replace device = 0 if device ==.

******************************************************************************************************************************************
**** STEP 4: Merging with prior HFH files\dpp4\diabetes_hf_dpp4_final_comorbidities_merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_HFH_12_months.dta"
drop _merge 
replace HFH=0 if HFH==.
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_prior_HFH.dta"
drop _merge 
replace THFH =0 if THFH==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_final_merged.dta", replace
*** 1914 