**SUBGROUP ANALYSES**

*STEP 1: repeat primary analysis
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta"

drop outcome failure
replace admission=. if admission>follow_up
replace dod=. if dod>follow_up
gen outcome = min(admission, dod, follow_up)
gen failure =0 if admission==. & dod==.
replace failure = 1 if failure ==.
stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30jun2022)) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

***AGE
preserve
keep if age >=75
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
restore

preserve
keep if age <75
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
restore

gen elderly=age
recode elderly 0/74=1 75/max=2
tab elderly
stcox i.treatment##i.elderly obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox i.treatment##i.elderly obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

***BMI group
*30-34.9
preserve
keep if obesity==4
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
restore

*35-39.9
preserve
keep if obesity==5
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
restore

*>40
preserve
keep if obesity==6
stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
restore

*new way
bysort obesity: stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

bysort obesity: stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
est store A

stcox i.treatment##i.obesity agegp sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year
est store B

lrtest A B

***CAD
bysort CAD: stcox treatment agegp obesity sex AF copd depression alcohol hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

stcox i.treatment##i.CAD agegp obesity sex AF copd depression alcohol hypertension MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

***CKD
bysort ckd: stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

stcox i.treatment##i.ckd agegp obesity sex AF copd depression alcohol hypertension CAD MI cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year

***AFib
bysort AF: stcox treatment agegp obesity sex copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

stcox i.treatment##i.AF agegp obesity sex copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2

**Ambulatory HFH
bysort HFH: stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin  THFH year weight2

stcox i.treatment##i.HFH agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin  THFH year weight2