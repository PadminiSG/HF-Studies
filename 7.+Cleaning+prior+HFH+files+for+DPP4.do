


**** Cleaning DPP4 prior HF hospitalization files 

**** STEP 1: Identifying those with HF hospitalization 12 months prior to DPP4 initiation 
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1"
use dpp4glp1_priorhfddhospi.dta
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)
gen admin= dofc(AdmitDateTime)
gen HFH = 1 if dof - admin <365
keep if HFH ==1
keep scrssn dof admin HFH
duplicates drop scrssn, force 
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_HFH_12_months.dta", replace 
*** 391 patients 


**** STEP 2: Identifying total number of HFH for each patient on DPP4 
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1"
use dpp4glp1_priorhfddhospi.dta
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)
gen admin= dofc(AdmitDateTime)
by scrssn, sort: gen scrssn_n = _n
bysort scrssn:egen THFH = max(scrssn_n)
bysort scrssn(scrssn_n):keep if _n==_N
keep scrssn THFH
summarize THFH, detail
gen dpp4 =1 
replace dpp4 = 0 if dpp4==.
**** 746 patients with prior HFH
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_prior_HFH.dta", replace 
**** Mean HFH 2.15, Median 1 (1-2)
