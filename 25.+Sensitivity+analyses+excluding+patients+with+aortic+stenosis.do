clear
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_glp1_aorticstenosis_cleaned.dta"
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1\diabetes_hf_dpp4_glp1_aorticstenosis_cleaned.dta"
drop _merge

merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files\final_survival_analysis_data.dta"
drop if _merge==1
drop _merge
recode AS .=0

**Survival analysis
drop outcome failure
replace admission=. if admission>follow_up
replace dod=. if dod>follow_up
gen outcome=min(admission, dod, follow_up)
gen failure =0 if admission==. & dod==.
replace failure = 1 if failure ==.

stset outcome, id(scrssn) origin(dof) failure(failure==1) exit(failure ==1 time td(30jun2022)) scale(365.25)

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year AS weight2

stcox i.treatment##i.AS agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke creatinine hba1c ACE BB antiarr insulin LD metformin spiro TZD statin HFH THFH year weight2