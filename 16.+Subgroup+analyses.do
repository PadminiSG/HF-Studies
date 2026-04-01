clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\final_survival_analysis_data.dta"

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight

sts graph, by(treatment) 


***Subgroup analysis 

*** Elderly 

preserve
drop if age <75
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.77 0.60 - 0.98, N = 756

preserve
drop if age >75
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore
*** HR 1.00 (0.85 - 1.17), N = 2313

gen elderly = 1 if age>75
replace elderly = 0 if elderly ==.

stcox i.treatment##i.elderly obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight

*** p value for interaction 0.004

***************************************************************************************************************************************************************************************************************************************************

*** CAD
preserve
drop if CAD ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 1.00 (0.73 - 1.37), N = 713

preserve
drop if CAD ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.88 (0.76 - 1.02), N = 2257

stcox i.treatment##i.CAD agegp obesity sex AF copd depression alcohol hypothyroidism hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
*** p value for interaction 0.30

***************************************************************************************************************************************************************************************************************************************************
*** CKD
preserve
drop if ckd ==1 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.86 (0.62-1.17), N = 1035

preserve
drop if ckd ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.90 (0.78-1.05), N = 1935

stcox i.treatment##i.ckd agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight

*** p value for interaction 0.08

***************************************************************************************************************************************************************************************************************************************************
*** BMI
*** BMI < 25
preserve
keep if obesity ==1 | obesity==2
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.58 (0.29-1.16), N = 186

*** BMI 25-29.9
preserve
keep if obesity ==3
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.60 (0.42-0.86), N = 551

*** BMI 30-34.9
preserve
keep if obesity ==4
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.91 (0.70-1.18), N = 826

** BMI 35-39.9
preserve
keep if obesity ==5
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 1.20 (0.92-1.57), N = 721

*** BMI >40

preserve
keep if obesity ==6 
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore
*** HR 0.95 (0.72-1.27), N = 686

*** NEED TO FIGURE OUT HOW TO USEFULLY SPLIT BMI GROUPS

/*gen obesity1 = bmi2
recode obesity1  (30/39.9=1) (40/60=2)

stcox i.treatment##i.obesity agegp sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight

*** p value for interaction 0.11 */


***************************************************************************************************************************************************************************************************************************************************
*** betablocker 

preserve
drop if BB==1
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.77 (0.62-0.96), N = 1098

preserve
drop if BB==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.98 (0.83-1.15), N = 1872


stcox i.treatment##i.BB agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr SGLT2 insulin LD metformin spiro statin ARNI year weight


*** p value for interaction 0.26


***************************************************************************************************************************************************************************************************************************************************

*** SGLT2 
preserve
drop if SGLT2 ==0
stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin ARNI year weight
restore

*** HR 0.99 0.46-2.20
preserve
drop if SGLT2 ==1
stcox treatment agegp obesity ckd sex AF copd depression alcohol hypothyroidism hypertension MI CAD cld cancer pad polyabuse ppm schizo stroke ACE BB HFH THFH antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2
restore

*** HR 1.09 0.93-1.29


stcox i.treatment##i.sglt2full obesity agegp sex AF copd depression alcohol hypothyroidism CAD hypertension MI ckd cld cancer pad HFH THFH polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2


*** p value for interaction 0.89



***************************************************************************************************************************************************************************************************************************************************

*** AF 
preserve
drop if AF ==0
stcox treatment agegp obesity ckd sex copd depression alcohol hypothyroidism hypertension MI CAD cld cancer pad polyabuse ppm schizo stroke ACE BB HFH THFH antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2
restore

*** HR 0.88  0.71-1.11

preserve
drop if AF ==1
stcox treatment agegp obesity ckd sex copd depression alcohol hypothyroidism hypertension MI CAD cld cancer pad polyabuse ppm schizo stroke ACE BB HFH THFH antiarr sglt2 insulin LD metformin spiro statin ARNI  year weight2
restore

*** HR 0.92  0.74-1.16


stcox i.treatment##i.AF obesity agegp sex copd depression alcohol hypothyroidism CAD hypertension MI ckd cld cancer pad HFH THFH polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2


*** p value for interaction 0.6



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
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",
drop if _merge ==1
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)

**** analysing only semgalutide
replace treatment =2 if GLP ==1
drop if treatment ==1 
stcox treatment agegp obesity ckd sex AF copd depression alcohol hypothyroidism hypertension MI CAD cld cancer pad polyabuse ppm schizo stroke ACE BB HFH THFH antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2


*** HR 0.91 0.81-1.03



***************************************************************************************************************************************************************************************************************************************************

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_drugdose.dta", clear
gen GLP = 1 if DrugNameWithoutDose =="Missing" | DrugNameWithoutDose =="SEMAGLUTIDE"
replace GLP = 2 if DrugNameWithoutDose =="LIRAGLUTIDE"
replace GLP = 3 if DrugNameWithoutDose =="DULAGLUTIDE"
replace GLP = 4 if DrugNameWithoutDose =="EXENATIDE"
replace GLP = 1 if GLP==.
keep scrssn GLP
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",
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
merge m:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",
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
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)
drop if ARNIfull ==0

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin sglt2 year weight2

*** HR 0.97 0.60-1.57 

***************************************************************************************************************************************************************************************************************************************************
*** Sensitivity analyses excluding SGLT2 in follow up

clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30April2024)) scale(365.25)
drop if sglt2full ==0

stcox treatment agegp obesity sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI year weight2

*** HR 0.99 0.45-2.22



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