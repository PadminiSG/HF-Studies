*** cleaning comorbidity files in dpp4i


*** STEP 1: Cleaning age and sex files
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1"
use diabetes_hf_dpp4glp1_age
rename ScrSSN scrssn
gen dpp4= cofd(DPP4Filltime)
gen dof= dofc(dpp4)
gen SEX = 1 if sex=="M"
replace SEX=2 if sex=="F"
drop sex
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
rename SEX sex
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_age.dta", replace
*****************************************************************************************************************************

*** STEP 2: Cleaning dob and dod files 
clear
use diabetes_hf_dpp4glp1_dod
rename ScrSSN scrssn
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_dod.dta", replace
*** 433 patients who died during follow up
*****************************************************************************************************************************

*** STEP 3: Merging age,sex,dob and dod files
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_age.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_dod.dta"
gen survival = dod-dof
count if survival <0
drop if survival < 0
gen survival1 = dod -dob
count if survival1<0
drop _merge survival survival1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_demograhics.dta", replace
*****************************************************************************************************************************

*** STEP 4: Cleaning BMI files (BMI AT BASELINE)
clear all
use diabetes_hf_dpp4glp1_bmi
rename ScrSSN scrssn
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_bmi.dta", replace

*****************************************************************************************************************************
*** STEP 5: Cleaning BNP files 
clear all
use diabetes_hf_dpp4glp1_bnp
drop patientsid
drop if LabChemResultNumericValue > 20000
***196 observations deleted
*** bnp > 10000 is likely an error 
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)
gen bnpdate = dofc(LabChemCompleteDateTime)
by scrssn bnpdate, sort: gen scrssn_n = _n
*** droping duplicate values of bnp

keep if scrssn_n==1
drop scrssn_n
by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only bnp value closest to the drug filling date

count if bnpdate > dof
*** doublechecking to make sure all bnp values are before durg initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue bnpvalue
keep scrssn dof bnpdate bnpvalue
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_bnp.dta", replace 
*** 251 patients with BNP value


*****************************************************************************************************************************
*** STEP 5: Cleaning proBNP files 
clear
use diabetes_hf_dpp4glp1_pbnp

drop if LabChemResultNumericValue > 100000
***145 observations deleted
*** proBNPbnp > 100000 is likely an error 
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)
gen pbnpdate = dofc(LabChemCompleteDateTime)
by scrssn pbnpdate, sort: gen scrssn_n = _n
*** droping duplicate values of proBNP

keep if scrssn_n==1
drop scrssn_n
by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only proBNP value closest to the drug filling date

count if pbnpdate > dof
*** doublechecking to make sure all proBNP values are before durg initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue pbnp
keep scrssn dof pbnpdate pbnp
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_pbnp.dta", replace 
*** 380 patients with proBNP value

*****************************************************************************************************************************
*** STEP 6: Cleaning creatinine files 

clear all
use diabetes_hf_dpp4glp1_creatinine

gen creatdate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(DPP4Filltime)
gen dof= dofc(dpp4)
rename ScrSSN scrssn

drop if LabChemResultNumericValue > 10
*** creatinine > 10 is likely an error 

by scrssn creatdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of bnp

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only creatinine value closest to the drug filling date

count if creatdate > dof
*** doublechecking to make sure all creatinine values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue creatinine
keep scrssn dof creatdate creatinine
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_creatinine.dta", replace 
***** 982 patients

*****************************************************************************************************************************
*** STEP 7: Cleaning albumin files 

clear all
use diabetes_hf_dpp4glp1_albumin
gen albumindate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

keep if LabChemTestName == "ALBUMIN" 
*** values included urine albumin, microalbumin and other irrelevant variables

drop if LabChemResultNumericValue > 5
*** albumin > 5 is likely an error 

by scrssn albumindate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of ALBUMIN 

by scrssn, sort: gen scrssn_n = _n
bysort scrssn albumindate: keep if scrssn_n==_N
*** keeping only albumin value closest to the drug filling date

count if albumindate > dof
*** doublechecking to make sure all albumin values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue albumin
keep scrssn dof albumindate albumin
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_albumin.dta", replace
***728 patients with albumin values 

*****************************************************************************************************************************
*** STEP 8: Cleaning hemoglobin files 

clear all
use diabetes_hf_dpp4glp1_hemoglobin

gen hemoglobindate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

drop if LabChemResultNumericValue > 20 
drop if LabChemResultNumericValue < 4
*** cleaning erroinius values

drop if regexm( LabChemTestName, "GLYCATED")==1
**Some glycated HB values

by scrssn hemoglobindate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of Hb

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only Hb value closest to the drug filling date

count if hemoglobindate > dof
*** doublechecking to make sure all hb values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue hemoglobin
keep scrssn dof hemoglobindate hemoglobin
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hemoglobin.dta", replace
***926 patients with hemoglobin values 

*****************************************************************************************************************************
*** STEP 9: Cleaning hematocrit files 

clear all
use diabetes_hf_dpp4glp1_hematocrit

gen hctdate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

drop if LabChemResultNumericValue >70
*** cleaning erroinius values

by scrssn hctdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of hematocrit

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only hct value closest to the drug filling date

count if hctdate > dof
*** doublechecking to make sure all hematocrit values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue hct
keep scrssn dof hctdate hct
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hct.dta", replace
***924 patients with hct levels

*****************************************************************************************************************************
*** STEP 10: Cleaning ALP files 

clear all
use diabetes_hf_dpp4glp1_alpho.dta

gen alpdate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

count if LabChemResultNumericValue <5
drop if LabChemResultNumericValue >3000
*** cleaning erroinius values

by scrssn alpdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of alp

by scrssn, sort: gen scrssn_n = _n
bysort scrssn: keep if scrssn_n==_N
*** keeping only alp value closest to the drug filling date

count if alpdate > dof
*** doublechecking to make sure all alp values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue alp
keep scrssn dof alpdate alp
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_alp.dta", replace
**746 patients with ALP values 

*****************************************************************************************************************************
*** STEP 11: Cleaning AST files 

clear all
use diabetes_hf_dpp4glp1_ast.dta

gen astdate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

count if LabChemResultNumericValue <5
drop if LabChemResultNumericValue >5000
*** cleaning erroinius values

by scrssn astdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of ast

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only ast value closest to the drug filling date

count if astdate > dof
*** doublechecking to make sure all ast values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue ast
keep scrssn dof astdate ast
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_ast.dta", replace
***381 patients with AST values 

*****************************************************************************************************************************
*** STEP 12: Cleaning bilirubin files 

clear all
use diabetes_hf_dpp4glp1_bilirubin.dta

gen bilirubindate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

drop if regexm( LabChemTestName, "URINE")==1
drop if regexm( LabChemTestName, "DIRECT")==1
*** dropping urine bilirubin and values with only direct bilirubin

drop if LabChemResultNumericValue >50
*** cleaning erroinius values

by scrssn bilirubindate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of bilirubin

by scrssn, sort: gen scrssn_n = _n
bysort scrssn: keep if scrssn_n==_N
*** keeping only bilirubin value closest to the drug filling date

count if bilirubindate > dof
*** doublechecking to make sure all albumin values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue bilirubin
keep scrssn dof bilirubindate bilirubin
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_bilirubin.dta", replace

*** 863 patients with bilirubin values 


*****************************************************************************************************************************
*** STEP 13: Cleaning HBA1c files 

clear all
use diabetes_hf_dpp4glp1_hba1c.dta

gen hba1cdatedate = dofc(LabChemCompleteDateTime)
gen dpp4= cofd(dpp4filltime)
gen dof= dofc(dpp4)

drop if LabChemResultNumericValue >15
*** cleaning erroinius values

by scrssn hba1cdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of HBA1c

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only creatinine value closest to the drug filling date

count if hba1cdatedate > dof
*** doublechecking to make sure all HBA1c values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue hba1c
keep scrssn dof hba1cdate hba1c
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hba1c.dta", replace
*** 868 patients with HBA1C values 

*****************************************************************************************************************************
*** STEP 13: Merging all laboratory files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_demograhics.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_bmi.dta"
drop DPP4Filltime HeightTime WeightTime _merge
rename heightresult height
rename weightresult weight
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_bnp.dta"
rename bnpvalue bnp
drop bnpdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_pbnp.dta"
drop pbnpdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_creatinine.dta"
drop creatdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_albumin.dta"
drop albumindate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hemoglobin.dta"
drop hemoglobindate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hct.dta"
drop hctdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_alp.dta"
drop alpdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_ast.dta"
drop astdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_bilirubin.dta"
drop bilirubindate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_hba1c.dta"
drop hba1cdate _merge
order scrssn age sex dob dof height weight bmi bnp pbnp creatinine hemoglobin hba1c hct albumin alp bilirubin ast
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\dpp4\diabetes_hf_dpp4glp1_final_lab_merged.dta", replace
*** 1027 patients 