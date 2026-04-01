*** cleaning laboratory variables in DPP4GLP (control) group


*** STEP 1: Cleaning age and sex files
clear
cd "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Raw files"
use diabetes_hfmref_dpp4glp1_age
rename ScrSSN scrssn
gen dof= dofc(DPP4Filltime)
gen sex = 1 if SEX=="M"
replace sex=2 if SEX=="F"
drop SEX
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_age.dta", replace
*****************************************************************************************************************************

*** STEP 2: Cleaning dob and dod files 
clear
use diabetes_hfmref_dpp4glp1_dod
rename ScrSSN scrssn
rename MPI_DOD dod
by scrssn, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_dod.dta", replace
*** 1002 patients who died during follow up --> increased to 1111 (last event July 2025)
*****************************************************************************************************************************

*** STEP 3: Merging age,sex,dob and dod files
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_age.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_dod.dta"
gen survival = dod-dof
rename DOB dob
count if survival <0
drop if survival < 0
gen survival1 = dod -dob
count if survival1<0
drop _merge survival survival1
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_demograhics.dta", replace
*** 1912 patients 
*****************************************************************************************************************************

*** STEP 4: Cleaning BMI files (BMI AT BASELINE)
clear all
use diabetes_hfmref_dpp4glp1_bmi
rename ScrSSN scrssn
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bmi.dta", replace
** 1893 patients

*****************************************************************************************************************************
*** STEP 5: Cleaning BNP files 
clear all
use diabetes_hfmref_dpp4glp1_bnp
drop patientsid
drop if LabChemResultNumericValue > 20000
***112 observations deleted
*** bnp > 20000 is likely an error 
*** on further inspection, seems like the only deleted observations were those with missing BNP values
gen dof= dofc(dpp4filltime)
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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bnp.dta", replace 
*** 627 patients with BNP value


*****************************************************************************************************************************
*** STEP 5: Cleaning proBNP files 
clear
use diabetes_hfmref_dpp4glp1_pbnp

drop if LabChemResultNumericValue > 100000
***3 observations deleted
*** proBNPbnp > 100000 is likely an error --> only deleted missing values
gen dof= dofc(dpp4filltime)
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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_pbnp.dta", replace 
*** 368 patients with proBNP value

*****************************************************************************************************************************
*** STEP 6: Cleaning creatinine files 

clear all
use diabetes_hfmref_dpp4glp1_creat

gen creatdate = dofc(LabChemCompleteDateTime)
gen dof= dofc(DPP4Filltime)
rename ScrSSN scrssn

drop if LabChemResultNumericValue > 10
*** creatinine > 10 is likely an error 

by scrssn creatdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** droping duplicate values of creatinine

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only creatinine value closest to the drug filling date

count if creatdate > dof
*** doublechecking to make sure all creatinine values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue creatinine
keep scrssn dof creatdate creatinine
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_creatinine.dta", replace 
***** 1869 patients

*****************************************************************************************************************************
*** STEP 7: Cleaning albumin files 

clear all
use diabetes_hfmref_dpp4glp1_albumin
gen albumindate = dofc(LabChemCompleteDateTime)
gen dof= dofc(dpp4filltime)

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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_albumin.dta", replace
***1782 patients with albumin values 

*****************************************************************************************************************************
*** STEP 8: Cleaning hemoglobin files 

clear all
use diabetes_hfmref_dpp4glp1_hemo

gen hemoglobindate = dofc(LabChemCompleteDateTime)
gen dof= dofc(dpp4filltime)

drop if LabChemResultNumericValue > 20 
drop if LabChemResultNumericValue < 4
*** cleaning erroinius values

drop if regexm( LabChemTestName, "GLYCATED")==1
**Some glycated HB values

*Look for other erroneous names
tab LabChemTestName
drop if regexm(LabChemTestName, "GLYCOHEMOGLOBIN")==1 | regexm(LabChemTestName, "GLYCOSYLATED HEMOGLOBIN")==1 | regexm(LabChemTestName, "GLYCO HGB") | regexm(LabChemTestName, "RETICULOCYTE HEMOGLOBIN EQUIVALENT")==1
*Additional 24 observations deleted

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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_hemoglobin.dta", replace
***1771 patients with hemoglobin values 

*****************************************************************************************************************************
*** STEP 9: Cleaning hematocrit files 

clear all
use diabetes_hfmref_dpp4glp1_hemato

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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_hct.dta", replace
***1794 patients with hct levels

*****************************************************************************************************************************
*** STEP 10: Cleaning ALP files 

clear all
use diabetes_hfmref_dpp4glp1_alpho.dta

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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_alp.dta", replace
**1426 patients with ALP values 

*****************************************************************************************************************************
*** STEP 11: Cleaning AST files 

clear all
use diabetes_hfmref_dpp4glp1_ast.dta

gen astdate = dofc(LabChemCompleteDateTime)
gen dof= dofc(dpp4filltime)

count if LabChemResultNumericValue <5
drop if LabChemResultNumericValue >5000
*** cleaning erroneous values

tab LabChemTestName
drop if strpos(LabChemTestName,"ALANINE AMINOTRANSFERASE (ALT)")
drop if strpos(LabChemTestName,"ALT (ALANINE TRANSAMINASE)")
drop if strpos(LabChemTestName,"ALANINE AMINOTRANSFERASE")
*** cleaning erroneous lab names

by scrssn astdate, sort: gen scrssn_n = _n
keep if scrssn_n==1
drop scrssn_n
*** dropping duplicate values of ast

by scrssn, sort: gen scrssn_n = _n
bysort scrssn : keep if scrssn_n==_N
*** keeping only ast value closest to the drug filling date

count if astdate > dof
*** doublechecking to make sure all ast values are before drug initiation

duplicates drop scrssn, force
rename LabChemResultNumericValue ast
keep scrssn dof astdate ast
*** cleaning variables  

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_ast.dta", replace
***749 patients with AST values 

*****************************************************************************************************************************
*** STEP 12: Cleaning bilirubin files 

clear all
use diabetes_hfmref_dpp4glp1_bili.dta

gen bilirubindate = dofc(LabChemCompleteDateTime)
gen dof= dofc(dpp4filltime)

drop if regexm( LabChemTestName, "URINE")==1
drop if regexm( LabChemTestName, "DIRECT")==1
*** dropping urine bilirubin and values with only direct bilirubin

tab LabChemTestName
drop if regexm(LabChemTestName, "CON. BILIRUBIN")==1
drop if regexm(LabChemTestName, "CONJ. BILIRUBIN")==1
drop if regexm(LabChemTestName, "DIR. BILIRUBIN")==1
drop if regexm(LabChemTestName, "DIR.BILIRUBIN")==1
drop if regexm(LabChemTestName, "Direct bilirubin")==1

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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bilirubin.dta", replace

***1584 patients with bilirubin values 


*****************************************************************************************************************************
*** STEP 13: Cleaning HBA1c files 

clear all
use diabetes_hfmref_dpp4glp1_hba1c.dta

gen hba1cdatedate = dofc(LabChemCompleteDateTime)
gen dof= dofc(dpp4filltime)

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

save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_hba1c.dta", replace
*** 1693 patients with HBA1C values 

*****************************************************************************************************************************
*** STEP 13: Merging all laboratory files 
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_demograhics.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bmi.dta"
drop DPP4Filltime HeightTime WeightTime _merge
rename heightresult height
rename weightresult weight
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bnp.dta"
rename bnpvalue bnp
drop bnpdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_pbnp.dta"
drop pbnpdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_creatinine.dta"
drop creatdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_albumin.dta"
drop albumindate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_hemoglobin.dta"
drop hemoglobindate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_hct.dta"
drop hctdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_alp.dta"
drop alpdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_ast.dta"
drop astdate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_bilirubin.dta"
drop bilirubindate _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_hba1c.dta"
drop hba1cdate _merge
order scrssn age sex dob dof height weight bmi bnp pbnp creatinine hemoglobin hba1c hct albumin alp bilirubin ast
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFmrEF GLP1\Edited files\diabetes_hfmref_dpp4glp1_final_lab_merged.dta", replace
*** 1914 patients 