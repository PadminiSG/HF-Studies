
clear all
use "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hfref_final_glp1_dpp4.dta"
gen year= year(dof)
drop if bmi < 30
merge 1:1 scrssn using "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 new files hf\diabetes_hf_dpp4glp1_glp1_hfh.dta"
drop if _merge==2
drop _merge

*******************************************************************************************************************************************

**** STEP 2
*** Splitting continous variables (age and BMI) into categorical variables for regression 
gen bmi2 = round(bmi,1)
**rounding bmi values to nearest number 
replace bmi2=. if bmi2>60
*** 24 changes made
drop bmi


** Splitting age into clinically relevant groups
gen agegp=age
recode agegp (18/35=1) (36/45=2) (46/55=3) (56/65=4) (66/75=5) (76/85=6) (86/100=7)
tab agegp

** Splitting BMI into clinically relevant groups
gen obesity = bmi2
recode obesity (0/18.4=1) (18.5/24.9=2) (25.0/29.9=3) (30/34.9=4) (35.0/39.9=5) (40/60=6)


*******************************************************************************************************************************************
**** STEP 4: IPTW

** STEP 4A: Checking standardized difference prior to matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin ARNI year

** STEP 4B: Calculating logistic regression, probability of treatment assignment for each patient (total observations 4,808/5597; some missing values)
logistic treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr insulin LD metformin spiro statin ARNI year


** Calculating p
predict p
gen q=1-p if treatment ==0
drop weight
gen weight=.

** Calculating inverse of probability 
replace weight =1/p if treatment==1
replace weight =1/q if treatment==0

** STEP 4C: Checking balance post matching 
pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year, wt(weight)
** < 10% difference for all variables 

graph tw kdensity p if treatment ==0||kdensity p if treatment ==1
graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight]
sum weight,de
sum p if treatment ==1,de
sum p if treatment ==0, de

** STEP 4D: Residual imbalance post matching; removing extreme weights
gen p2=p if p>0.1 & p<0.9
gen q2=q if q>0.1 & q <0.9

gen weight2=.

replace weight2=1/p2 if treatment ==1
replace weight2=1/q2 if treatment ==0

pbalchk treatment age bmi2 sex AF copd depression alcohol hypothyroidism hypertension CAD MI ckd cld cancer pad polyabuse ppm schizo stroke HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNI sglt2 year, wt(weight2)
** No residual imbalance after excluding extreme weights 

graph tw kdensity p if treatment ==0||kdensity p if treatment==1 [w=weight2]

*******************************************************************************************************************************************drop _merge


**** STEP 5: gen outcome date variable (composite of HFH or mortality; whichever comes first)
gen follow_up =.
replace follow_up= mdy(04,30,2024)

gen compet=1 if admission < dod

replace compet=2 if dod< admission

**gen outcome = min(admission, dod)

gen outcome = admission

gen censor=min(admission,follow_up, dod)

stset censor, origin(dof) failure(compet=1) id(scrssn) scale(365.25)

stcompet CumInc = ci SError = se, compet1(2) 

gen CumInc1= CumInc if compet==1

gen CumInc2= CumInc if compet==2

stcox treatment

sts graph, by(treatment) 

stcox treatment agegp obesity sex AF copd depression alcohol hypertension CAD MI ckd pad ppm HFH THFH ACE BB antiarr sglt2 insulin LD metformin spiro statin ARNIfull sglt2full year weight2


