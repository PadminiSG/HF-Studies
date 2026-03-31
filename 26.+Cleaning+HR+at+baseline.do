** STEP 1: Cleaning HR files at baseline for DPP4i (average of last 3 HR prior to DPP4 initiation)
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr.dta"
rename ScrSSN scrssn
drop diastolic Systolic VitalType VitalResult
gen hrtime= dofc( VitalSignTakenDateTime )
gen dof = dofc(DPP4Filltime)
rename VitalResultNumeric HR
drop if HR>120
drop if hrtime > dof
gen hr= dof-hrtime
sort hr
sort scrssn hr
by scrssn, sort: gen scrssn_n = _n
drop if scrssn_n > 3
collapse (mean) HR, by(scrssn)
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr_pre.dta", replace

*** STEP 2: Cleaning hr files post drug initiation for dpp4i (blanking period of 90 days, average of the 1st 3 heart rates post 90 days)
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFreF GLP1\diabetes_hfref_dpp4glp1_hraft.dta"
rename ScrSSN scrssn
drop diastolic Systolic VitalType VitalResult
gen hrtime= dofc( VitalSignTakenDateTime )
gen dof = dofc(DPP4Filltime)
rename VitalResultNumeric HRafter
drop if HRafter>120
gen hr= hrtime-dof
drop if hr<90
sort hr
sort scrssn hr
by scrssn, sort: gen scrssn_n = _n
drop if scrssn_n > 3
collapse (mean) HRafter, by(scrssn)
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr_post.dta", replace


*** STEP 3: Merging HR files of DPP4i
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr_pre.dta"
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr_post.dta"
drop if _merge==2
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",
keep if _merge ==3
keep scrssn HR HRafter
gen change= HRafter-HR
keep if change <=20 & change >=-20
gen treat=0
keep scrssn change treat
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr_diff.dta", replace

***********

                           change
-------------------------------------------------------------
      Percentiles      Smallest
 1%    -18.66666            -20
 5%    -14.33334            -20
10%          -11      -19.66667       Obs               1,326
25%    -4.999996      -19.66666       Sum of wgt.       1,326

50%     .3333359                      Mean           .4325038
                        Largest       Std. dev.        8.4568
75%     5.666672       19.66666
90%           12       19.66666       Variance       71.51747
95%     15.33333             20       Skewness      -.0433885
99%     18.66666             20       Kurtosis       2.666931

**********


*** STEP 4: Cleaning HR files at baseline for GLP-1RA (average of last 3 HR prior to DPP4 initiation)
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr.dta"
rename ScrSSN scrssn
drop diastolic systolic VitalType VitalResult
gen hrtime= dofc( VitalSignTakenDateTime )
gen dof = dofc(GLP1FillTime)
rename VitalResultNumeric HR
drop if HR>120
drop if hrtime > dof
gen hr= dof-hrtime
sort hr
sort scrssn hr
by scrssn, sort: gen scrssn_n = _n
drop if scrssn_n > 3
collapse (mean) HR, by(scrssn)
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr_pre.dta", replace

*** STEP 5: Cleaning hr files post drug initiation for glp-1ra (blanking period of 90 days, average of the 1st 3 heart rates post 90 days)
clear 
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFreF GLP1\diabetes_hfref_glp1_hrafter.dta"
rename ScrSSN scrssn
drop diastolic systolic VitalType VitalResult
gen hrtime= dofc( VitalSignTakenDateTime )
gen dof = dofc(GLP1FillTime)
rename VitalResultNumeric HRafter
drop if HRafter>120
gen hr= hrtime-dof
drop if hr<90
sort hr
sort scrssn hr
by scrssn, sort: gen scrssn_n = _n
drop if scrssn_n > 3
collapse (mean) HRafter, by(scrssn)
duplicates drop scrssn, force
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr_post.dta", replace


*** STEP 6: Merging HR files of glp1ra
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr_pre.dta"
merge 1:m scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr_post.dta"
drop if _merge==2
drop _merge
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\final_survival_analysis_data.dta",
keep if _merge ==3
keep scrssn HR HRafter
gen change1= HRafter-HR
keep if change1 <=20 & change >=-20
gen treat=1
keep scrssn change1 treat
save "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr_diff.dta", replace


*****

                           change
-------------------------------------------------------------
      Percentiles      Smallest
 1%          -17            -20
 5%    -12.33334      -19.66666
10%    -9.333334            -19       Obs               1,080
25%    -3.333336            -18       Sum of wgt.       1,080

50%     2.333336                      Mean           2.207253
                        Largest       Std. dev.      8.360011
75%     8.333334             20
90%     13.16666             20       Variance       69.88979
95%           16             20       Skewness      -.1510383
99%           19             20       Kurtosis       2.552783

****


*** STEP 7 Comparing changes in HR between GLP-1 RA and DPP4i
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_glp1_hr_diff.dta"
append using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\diabetes_hfref_dpp4glp1_hr_diff.dta"
gen group =1 if !missing(change)
replace group =2 if !missing(change1)
gen value=change
replace value =change1 if missing(change)
keep if !missing(value) & !missing(group)
tabstat value, by(group) stats(mean, median sd n)
ttest value, by(group)



**** 
   group |      Mean       p50        SD         N
---------+----------------------------------------
       1 |  .4325038  .3333359    8.4568      1326
       2 |  2.207253  2.333336  8.360011      1080
---------+----------------------------------------
   Total |  1.229149  1.333328  8.457955      2406
--------------------------------------------------

***
Two-sample t test with equal variances
------------------------------------------------------------------------------
   Group |     Obs        Mean    Std. err.   Std. dev.   [95% conf. interval]
---------+--------------------------------------------------------------------
       1 |   1,326    .4325038    .2322386      8.4568   -.0230916    .8880992
       2 |   1,080    2.207253     .254387    8.360011    1.708104    2.706402
---------+--------------------------------------------------------------------
Combined |   2,406    1.229149    .1724319    8.457955    .8910189     1.56728
---------+--------------------------------------------------------------------
    diff |           -1.774749    .3448583               -2.450999   -1.098499
------------------------------------------------------------------------------

