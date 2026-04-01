
**** Cleaning glp1 prior HF hospitalization files 

**** STEP 1: Identifying those with HF hospitalization 12 months prior to DPP4 initiation 
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFiEF GLP1"
use hfief_glp1_priorhfhospi.dta
gen dof= dofc(glp1filltime)
gen admin= dofc(AdmitDateTime)
gen HFH = 1
keep scrssn dof admin HFH
keep if HFH ==1
keep scrssn dof admin HFH
duplicates drop scrssn, force 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_HFH_12_months.dta", replace 
**** 91 patients with HFH within 12 months prior to glp1 initiation 

**** STEP 2: Identifying total number of HFH for each patient on DPP4 
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFiEF GLP1"
use hfief_glp1_priorhfhospi.dta
gen dof= dofc(glp1filltime)
gen admin= dofc(AdmitDateTime)
by scrssn, sort: gen scrssn_n = _n
bysort scrssn:egen THFH = max(scrssn_n)
bysort scrssn(scrssn_n):keep if _n==_N
keep scrssn THFH
summarize THFH, detail
gen glp1 =1 
replace glp1 = 0 if glp1==.
**** 106 patients with prior HFH
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\glp1\diabetes_hfief_glp1_prior_HFH.dta", replace
**** Mean HFH 1.2, 
