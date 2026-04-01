
*** Subgroup analyses

*Repeat primary analysis
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_survival_analysis_data.dta",
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2

***Subgroup analysis 

*** Elderly 

preserve
drop if age <75
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 0.98 0.71-1.38

preserve
drop if age >75
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore
*** HR 1.08 0.91 - 1.27

gen elderly = 1 if age>75
replace elderly = 0 if elderly ==.

stcox i.treatment##i.elderly obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2

*** p value for interaction 0.44

***************************************************************************************************************************************************************************************************************************************************

*** CAD
preserve
drop if CAD ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension  MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 0.94 0.67 - 1.32

preserve
drop if CAD ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension  MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 1.08 0.92 - 1.28

stcox i.treatment##i.CAD agegp obesity sex AF copd depression alcohol hypothyroidism hypertension  MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
*** p value for interaction 0.65

***************************************************************************************************************************************************************************************************************************************************
*** CKD
preserve
drop if ckd ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 1.25 0.97 - 1.60

preserve
drop if ckd ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 0.92 0.75 - 1.10

stcox i.treatment##i.ckd agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2

*** p value for interaction 0.03

***************************************************************************************************************************************************************************************************************************************************
*** BMI
*** BMI 30-40
preserve
drop if obesity ==6 
stcox treatment agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 1.23 1.02 - 1.47

*** BMI > 40
preserve
keep if obesity ==6 
stcox treatment agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore
*** HR 0.75 0.57-0.97


gen obesity1 = bmi2
recode obesity1  (30/39.9=1) (40/60=2)

stcox i.treatment##i.obesity1 agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2

*** p value for interaction 0.002


***************************************************************************************************************************************************************************************************************************************************
*** betablocker 

preserve
drop if BB==1
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 1.04  0.81-1.34

preserve
drop if BB==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 1.04  0.87-1.26


stcox i.treatment##i.BB agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE antiarr sglt2 insulin LD metformin spiro statin year weight2


*** p value for interaction 0.91


***************************************************************************************************************************************************************************************************************************************************

*** SGLT2 
preserve
drop if sglt2full ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin year weight2
restore

*** HR 1.07 0.76-1.50

preserve
drop if sglt2full ==1
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin year weight2
restore

*** HR 1.09 0.92-1.29


stcox i.treatment##i.sglt2full agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin year weight2


*** p value for interaction 0.85



***************************************************************************************************************************************************************************************************************************************************

*** AF 
preserve
drop if AF ==0
stcox treatment agegp obesity sex copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 1.13  0.92-1.40

preserve
drop if AF ==1
stcox treatment agegp obesity sex copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2
restore

*** HR 0.99  0.80-1.23


stcox i.treatment##i.AF agegp obesity sex copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2


*** p value for interaction 0.71



***************************************************************************************************************************************************************************************************************************************************

** Specific GLP1 use 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_drugdose.dta", clear
gen GLP = 1 if DrugNameWithoutDose =="Missing" | DrugNameWithoutDose =="SEMAGLUTIDE"
replace GLP = 2 if DrugNameWithoutDose =="LIRAGLUTIDE"
replace GLP = 3 if DrugNameWithoutDose =="DULAGLUTIDE"
replace GLP = 4 if DrugNameWithoutDose =="EXENATIDE"
replace GLP = 1 if GLP==.
keep scrssn GLP
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_survival_analysis_data.dta",
drop if _merge ==1
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)

**** analysing only semgalutide
replace treatment =2 if GLP ==1
drop if treatment ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin year weight2


*** HR 0.90 0.80-1.03



***************************************************************************************************************************************************************************************************************************************************

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_drugdose.dta", clear
gen GLP = 1 if DrugNameWithoutDose =="Missing" | DrugNameWithoutDose =="SEMAGLUTIDE"
replace GLP = 2 if DrugNameWithoutDose =="LIRAGLUTIDE"
replace GLP = 3 if DrugNameWithoutDose =="DULAGLUTIDE"
replace GLP = 4 if DrugNameWithoutDose =="EXENATIDE"
replace GLP = 1 if GLP==.
keep scrssn GLP
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_survival_analysis_data.dta",
drop if _merge ==1
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)

**** analysing only liraglutide
replace treatment =2 if GLP ==2
drop if treatment ==1 
stcox treatment agegp obesity ckd sex AF copd depression alcohol hypothyroidism hypertension MI CAD cld cancer pad polyabuse ppm schizo stroke ACE BB HFH THFH antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2

*** HR 0.96 0.87-1.06


***************************************************************************************************************************************************************************************************************************************************

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_drugdose.dta", clear
gen GLP = 1 if DrugNameWithoutDose =="Missing" | DrugNameWithoutDose =="SEMAGLUTIDE"
replace GLP = 2 if DrugNameWithoutDose =="LIRAGLUTIDE"
replace GLP = 3 if DrugNameWithoutDose =="DULAGLUTIDE"
replace GLP = 4 if DrugNameWithoutDose =="EXENATIDE"
replace GLP = 1 if GLP==.
keep scrssn GLP
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_survival_analysis_data.dta",
drop if _merge ==1
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)

**** analysing dulaglutide
replace treatment =2 if GLP ==3
drop if treatment ==1 
stcox treatment agegp obesity ckd sex AF copd depression alcohol hypothyroidism hypertension MI CAD cld cancer pad polyabuse ppm schizo stroke ACE BB HFH THFH antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2

*** HR 1.01 0.88-1.16



***************************************************************************************************************************************************************************************************************************************************
*** Sensitivity analyses excluding ARNI in follow up

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_survival_analysis_data.dta",

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
drop if ARNIfull ==0

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin year weight2

*** HR 0.93 0.59-1.48 

***************************************************************************************************************************************************************************************************************************************************
*** Sensitivity analyses excluding SGLT2 in follow up

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hfief\final_survival_analysis_data.dta",

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30July2025)) scale(365.25)
drop if sglt2full ==0

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin year weight2

*** HR 1.07 0.76-1.50