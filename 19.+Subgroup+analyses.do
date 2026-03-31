*** STEP 1: repeat primary analysis
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2

sts graph, by(treatment)


***Subgroup analysis 

*** Elderly 

preserve
drop if age <=75
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.99 0.69 - 1.40

preserve
drop if age >75
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore
*** HR 0.93 0.78 - 1.11

gen elderly = 1 if age>75
replace elderly = 0 if elderly ==.

stcox treatment i.treatment##i.elderly obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2

*** p value for interaction 0.61

***************************************************************************************************************************************************************************************************************************************************

*** CAD
preserve
drop if CAD ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.90 0.63 - 1.28

preserve
drop if CAD ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.92 0.77 - 1.09

stcox i.treatment##i.CAD agegp obesity sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
*** p value for interaction 0.90

***************************************************************************************************************************************************************************************************************************************************
*** CKD
preserve
drop if ckd ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 1.05 0.79 - 1.40

preserve
drop if ckd ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.88 0.72 - 1.066

stcox treatment i.treatment##i.ckd agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2

*** p value for interaction 0.18

***************************************************************************************************************************************************************************************************************************************************
*** BMI
*** BMI 30-40
preserve
drop if obesity ==6 
stcox treatment agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.94 0.78-1.14

*** BMI > 40
preserve
keep if obesity ==6 
stcox treatment agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore
*** HR 0.45 0.23 - 0.86


gen obesity1 = bmi2
recode obesity1  (30/39.9=1) (40/60=2)

stcox i.treatment##i.obesity1 agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2

*** p value for interaction 0.11


***************************************************************************************************************************************************************************************************************************************************
*** betablocker 

preserve
drop if BB==1
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.84  0.65-1.09

preserve
drop if BB==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC antiarr insulin LD metformin spiro1 statin  sglt2 year weight2
restore

*** HR 0.94  0.78-1.15


stcox i.treatment##i.BB1 agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC antiarr insulin LD metformin spiro1 statin sglt2 year weight2


*** p value for interaction 0.50


***************************************************************************************************************************************************************************************************************************************************

*** SGLT2 
preserve
drop if sglt2full ==1
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin year weight2
restore

*** HR 0.99 0.46-2.20
preserve
drop if sglt2full ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin year weight2
restore

*** HR 1.09 0.93-1.29


stcox i.treatment##i.sglt2full agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin year weight2


*** p value for interaction 0.89



***************************************************************************************************************************************************************************************************************************************************

*** AF 
preserve
drop if AF ==0
stcox treatment agegp obesity sex copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore

*** HR 0.88  0.71-1.11

preserve
drop if AF ==1
stcox treatment agegp obesity sex copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore

*** HR 0.92  0.74-1.16


stcox i.treatment##i.AF agegp obesity sex copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2


*** p value for interaction 0.6



***************************************************************************************************************************************************************************************************************************************************

*** EF
preserve 
drop if ef >25
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore

preserve 
drop if ef <=25
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore

gen efgroup=ef
recode efgroup 0/25=1 26/40=2

stcox i.treatment##i.efgroup agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
***************************************************************************************************************************************************************************************************************************************************

** Specific GLP1 use 

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_drugdose.dta"
replace DrugNameWithoutDose="EXENATIDE" if regexm( LocalDrugNameWithDose, "EXENATIDE")
replace DrugNameWithoutDose="DULAGLUTIDE" if regexm( LocalDrugNameWithDose, "DULAGLUTIDE")
replace DrugNameWithoutDose="SEMAGLUTIDE" if regexm( LocalDrugNameWithDose, "SEMAGLUTIDE")
replace DrugNameWithoutDose="SEMAGLUTIDE" if regexm( LocalDrugNameWithDose, "Semaglutide")
list if DrugNameWithoutDose=="*Missing*"
gen GLP = 1 if DrugNameWithoutDose =="SEMAGLUTIDE"
replace GLP = 2 if DrugNameWithoutDose =="LIRAGLUTIDE"
replace GLP = 3 if DrugNameWithoutDose =="DULAGLUTIDE"
replace GLP = 4 if DrugNameWithoutDose =="EXENATIDE"
count if GLP==.
keep scrssn GLP
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"
drop if _merge ==1
by scrssn, sort: gen scrssn_n=_n
keep if scrssn_n==1
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)


**** analysing only semgalutide
preserve
drop if treatment==1 & GLP !=1
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore 

*** analysing only liraglutide
preserve
drop if treatment==1 & GLP !=2
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore 

*** analysing only dulaglutide
preserve
drop if treatment==1 & GLP !=3
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore 

*** analysing only exenatide
preserve
drop if treatment==1 & GLP !=4
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2
restore 


***************************************************************************************************************************************************************************************************************************************************
*** Sensitivity analyses excluding ARNI in follow up

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"

drop if ARNIfu ==1

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2


***************************************************************************************************************************************************************************************************************************************************
*** Sensitivity analyses excluding SGLT2 in follow up

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"

drop if sglt2fu ==1

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2

***************************************************************************************************************************************************************************************************************************************************
*** Sensitivity analyses excluding saxagliptin

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_drugdose.dta", clear
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data_medwithoutfilter.dta"
drop if _merge ==1
by scrssn, sort: gen scrssn_n=_n
keep if scrssn_n==1

drop if DrugNameWithoutDose=="SAXAGLIPTIN"
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time follow_up) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ef AASAC BB1 antiarr insulin LD metformin spiro1 statin sglt2 year weight2






**BELOW NOT USED
*** Subgroup Analysis based on EF group
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4_efbefore_cleaned.dta",
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_efbefore_cleaned.dta"
drop if _merge ==3
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta"
keep if _merge ==3
drop _merge
gen severelsd =1 if ef <30
replace severelsd=0 if severelsd==.

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)

preserve
drop if severelsd ==1 
stcox treatment agegp obesity CAD sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB  antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year weight2
restore

*** HR 0.98 0.77 - 1.23

preserve
drop if severelsd ==0
stcox treatment agegp obesity CAD sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB  antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year weight2
restore

*** HR 0.90 0.72-1.13

stcox i.treatment##i.severelsd  BB obesity agegp sex AF copd depression alcohol hypothyroidism CAD hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE  antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2  year weight2

*** Interaction p value is 0.90