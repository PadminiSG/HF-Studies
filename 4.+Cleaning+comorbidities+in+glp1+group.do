*** cleaning comorbidity files in glp1

*** STEP 1: Identifying patients with AF
*** Cleaning AF 
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1"
use diabetes_hf_glp1_af
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_af.dta", replace
*** 430 patients with AF

*** Cleaning patients with ablation for AF
clear
use diabetes_hf_glp1_ablation
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ablation.dta", replace
*** 4 patients with AF ablation 

*** Merging AF diagnosis codes with ablation 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ablation.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_af.dta"
duplicates drop scrssn, force
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_final_af.dta", replace
*** 431 patients with AF including procedure and diagnosis codes 

*** Cleaning patients with cardioversion 
clear 
use diabetes_hf_glp1_cardioversion
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_final_af.dta"
duplicates drop scrssn, force
keep scrssn
gen AF=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_final_af_1.dta", replace
*** 432 patients with AF including procedure and diagnosis codes 

*************************************************************************************************************************

*** STEP 2: Identifying patients with COPD
clear
use diabetes_hf_glp1_copd
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen copd=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_copd.dta", replace
*** 604 patients with COPD

*************************************************************************************************************************

*** STEP 3: Identifying patients with depression 
clear
use diabetes_hf_glp1_depression
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen depression=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_depression.dta", replace
*** 485 patients with depression 

*************************************************************************************************************************

*** STEP 4: Identifying patients with ESRD
clear
use diabetes_hf_glp1_esrd
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen esrd=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_esrd.dta", replace
*** 19 patients with ESRD  

*************************************************************************************************************************

*** STEP 5: Identifying patients with alcohol abuse
clear
use diabetes_hf_glp1_alcoholabuse
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen alcohol=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_alcoholabuse.dta", replace
*** 20 patients with alcohol abuse  

*************************************************************************************************************************

*** STEP 6: Identifying patients with hypothyroidism 
clear
use diabetes_hf_glp1_hypothyroidism
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen hypothyroidism=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hypothyroidism.dta", replace
*** 195 patients with hypothyroidism

*************************************************************************************************************************

*** STEP 7: Identifying patients with hypertension
clear
use diabetes_hf_glp1_hypertension
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen hypertension=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hypertension.dta", replace
*** 603 patients with hypertension

*************************************************************************************************************************

*** STEP 8: Identifying patients with CAD
clear
use diabetes_hf_glp1_cad
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen CAD= 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_cad.dta", replace
*** 772 patients with stable CAD 

*************************************************************************************************************************
*** STEP 9: Identifying patients with prior MI
clear
use diabetes_hf_glp1_mi
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen MI=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_mi.dta", replace
*** 209 patients with MI

*************************************************************************************************************************
*** STEP 10: Identifying patients with CKD 
clear
use diabetes_hf_glp1_kidneydisease
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ckd=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_kidneydisease.dta", replace
*** 702 patients with ckd

*************************************************************************************************************************
*** STEP 11: Identifying patients with liver disease 
clear
use diabetes_hf_glp1_liverdisease
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen cld=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_liverdisease.dta", replace
*** 136 patients with cld

*************************************************************************************************************************
*** STEP 12: Identifying patients with malignancy
clear
use diabetes_hf_glp1_malignancy
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen cancer=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_malignancy.dta", replace
*** 4 patients with malignancy


*************************************************************************************************************************
*** STEP 14: Identifying patients with pad
clear
use diabetes_hf_glp1_pad
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen pad=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_pad.dta", replace
*** 172 patients with pad


*************************************************************************************************************************
*** STEP 15: Identifying patients with polysubstance abuse
clear
use diabetes_hf_glp1_polyabuse
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen polyabuse=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_polyabuse.dta", replace
***49 patients with polysubstance abuse

*************************************************************************************************************************
*** STEP 16: Identifying patients with prior pacemaker 
clear
use diabetes_hf_glp1_priorpmdc
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ppm=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_priorpmdc.dta", replace
*** 74 patients with pacemaker 

*************************************************************************************************************************
*** STEP 17: Identifying patients with schizophrenia 
clear
use diabetes_hf_glp1_schizodisorder
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen schizo=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_schizodisorder.dta", replace
*** 23 patients with szchiphrenia 


*************************************************************************************************************************
*** STEP 18: Identifying patients with stroke 
clear
use diabetes_hf_glp1_stroke
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen stroke=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_stroke.dta", replace
*** 39 patients with stroke

*************************************************************************************************************************

*** STEP 19: Identifying patients with pneumonia
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\hfpef_glp1_pneumonia.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen pneumonia=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\hfpef_glp1_pneumonia.dta", replace
*** 56 patients with pneumonia

*************************************************************************************************************************

*** STEP 20: Identifying patients with copd excerbation
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\hfpef_glp1_copdexacerbation.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen copdexa=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\hfpef_glp1_copdexacerbation.dta", replace
*** 33 patients with copd excerbation

*************************************************************************************************************************

*** STEP 21: Identifying patients with cholecystitis/cholecystectomy 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\hfpef_glp1_cholecyst.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen cholecyst=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\hfpef_glp1_cholecyst.dta", replace
*** 15 patients with cholecystitis/cholecystectomy

*************************************************************************************************************************
*** STEP 22: Merging all comorbidities 

clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_final_af_1.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_copd.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_depression.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_esrd.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_alcoholabuse.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hypothyroidism.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_hypertension.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_cad.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_mi.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_kidneydisease.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_liverdisease.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_malignancy.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_pad.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_polyabuse.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_priorpmdc.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_schizodisorder.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_stroke.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\hfpef_glp1_pneumonia.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\hfpef_glp1_copdexacerbation.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\hfpef_glp1_cholecyst.dta"
drop _merge

replace AF=0 if AF==.
replace copd = 0 if copd==.
replace depression = 0 if depression==.
replace esrd = 0 if esrd ==.
replace alcohol = 0 if alcohol ==.
replace hypothyroidism = 0 if hypothyroidism ==.
replace hypertension = 0 if hypertension ==.
replace CAD = 0 if CAD ==.
replace MI = 0 if MI ==.
replace ckd = 0 if ckd ==.
replace cld = 0 if cld ==.
replace cancer = 0 if cancer ==.
replace pad = 0 if pad ==.
replace polyabuse = 0 if polyabuse ==.
replace ppm = 0 if ppm ==.
replace schizo = 0 if schizo ==.
replace stroke = 0 if stroke ==.
replace pneumonia = 0 if pneumonia ==.
replace copdexa = 0 if copdexa ==.
replace cholecyst = 0 if cholecyst ==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_final_comorbidities_merged.dta", replace 
*** 1128 patients 





