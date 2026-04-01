*** Cleaning new comorbitites ***
*** GLP1 ***

*** STEP 1: Identifying patients with pneumonia
clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\hfpef_glp1_pneumonia.dta"
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
keep scrssn
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\glp1\diabetes_hf_glp1_ace.dta", replace
