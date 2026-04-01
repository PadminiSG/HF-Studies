*** cleaning comorbidity files in dpp4i


*** STEP 1: Identifying patients with AF
*** Cleaning AF 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_af.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_af.dta", replace
*** 752 patients with AF

*** Cleaning patients with ablation for AF
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_ablation.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ablation.dta", replace
*** 13 patients with AF ablation 

*** Merging AF diagnosis codes with ablation 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_af.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ablation.dta"
duplicates drop scrssn, force
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_final_af.dta", replace
*** 752 patients with AF including procedure and diagnosis codes 

*** Cleaning patients with cardioversion 
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_cv.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_final_af.dta"
duplicates drop scrssn, force
keep scrssn
gen AF=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_final_af_1.dta", replace
*** 757 patients with AF including procedure and diagnosis codes 

*************************************************************************************************************************

*** STEP 2: Identifying patients with COPD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_copd.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen copd=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_copd.dta", replace
*** 675 patients with COPD

*************************************************************************************************************************

*** STEP 3: Identifying patients with depression 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_dep.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen depression=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_dep.dta", replace
*** 484 patients with depression 

*************************************************************************************************************************

*** STEP 4: Identifying patients with ESRD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_esrd.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen esrd=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_esrd.dta", replace
*** 23 patients with ESRD  

*************************************************************************************************************************

*** STEP 5: Identifying patients with alcohol abuse
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_alcohol.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen alcohol=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_alcoholabuse.dta", replace
*** 80 patients with alcohol abuse  

*************************************************************************************************************************

*** STEP 6: Identifying patients with hypothyroidism 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_hypo.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen hypothyroidism=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_hypo.dta", replace
*** 190 patients with hypothyroidism

*************************************************************************************************************************

*** STEP 7: Identifying patients with hypertension
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_hyper.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen hypertension=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_hyper.dta", replace
*** 1020 patients with hypertension

*************************************************************************************************************************

*** STEP 8: Identifying patients with CAD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_cad.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen CAD= 1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_cad.dta", replace
*** 997 patients with stable CAD 

*************************************************************************************************************************
*** STEP 9: Identifying patients with prior MI
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_mi.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen MI=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_mi.dta", replace
*** 350 patients with MI

*************************************************************************************************************************
*** STEP 11: Identifying patients with CKD 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_kd.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ckd=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_kd.dta", replace
*** 663 patients with ckd

*************************************************************************************************************************
*** STEP 12: Identifying patients with liver disease 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_ld.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen cld=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ld.dta", replace
*** 173 patients with cld

*************************************************************************************************************************
*** STEP 13: Identifying patients with malignancy
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_malig.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen cancer=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_malig.dta", replace
*** 9 patients with malignancy


*************************************************************************************************************************
*** STEP 14: Identifying patients with PAD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_pad.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen pad=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_pad.dta", replace
*** 264 patients with pad


*************************************************************************************************************************
*** STEP 15: Identifying patients with polysubstance abuse
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_pa.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen polyabuse=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_polyabuse.dta", replace
*** 158 patients with polysubstance abuse

*************************************************************************************************************************
*** STEP 16: Identifying patients with prior pacemaker 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_ppmdc.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ppm=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ppmdc.dta", replace
*** 231 patients with pacemaker 

*************************************************************************************************************************
*** STEP 17: Identifying patients with schizophrenia 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_schizo.dta"
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen schizo=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_schizo.dta", replace
*** 26 patients with schizophrenia 


*************************************************************************************************************************
*** STEP 18: Identifying patients with stroke 
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_stroke.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen stroke=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_stroke.dta", replace
*** 47 patients with stroke

*************************************************************************************************************************
*** STEP 19: Identifying patients with CRT
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_crtnf.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_lvpnf.dta" 
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen CRT=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_crt.dta", replace
*** 243 patients with CRT


*************************************************************************************************************************

*** STEP 20: Identifying patients with ICD
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\hfief GLP1\diabetes_hfief_dpp4glp1_icdnf.dta" 
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
gen ICD=1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfief_dpp4glp1_icd.dta", replace
*** 460 patients with ICD

*************************************************************************************************************************
*** STEP 19: Merging all comorbidities 

clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_final_af_1.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_copd.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_dep.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_esrd.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_alcoholabuse.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_hypo.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_hyper.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_cad.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_mi.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_kd.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ld.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_malig.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_pad.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_polyabuse.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_ppmdc.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_schizo.dta"
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_stroke.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfief_dpp4glp1_crt.dta"
drop _merge 
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\dpp4\diabetes_hfief_dpp4glp1_icd.dta"
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
replace CRT=0 if CRT==.
replace ICD=0 if ICD==.
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\dpp4\diabetes_hfief_dpp4glp1_final_comorbidities_merged.dta", replace 
***1345 patients 