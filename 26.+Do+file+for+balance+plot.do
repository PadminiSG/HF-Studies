clear
import delimited "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\GLP1 HFpEF Standardized Differences graph 2.csv"



** balance plot***
egen var_index = group(variable)

sort var_index

list

** define labels**
label define var_labels  1 "Age" 2 "BMI" 3 "Sex" 4 "AF" 5 "COPD" 6 "Depression" 7 "Alcohol" 8 "Hypertension" 9 "Coronary Artery Disease" 10 "Myocardial Infarction" 11 "Chronic Kidney Disease " 12 "Chronic Liver Disease" 13 "Cancer" 14 "Peripheral Artery Disease" 15 "Polysubtance Abuse" 16 "Pacemaker" 17 "Schizophrenia" 18 "Stroke" 19 "Serum Creatinine" 20 "Hba1c" 21 "ACE/ARB" 22 "Beta Blockers" 23 "Antiarrhythmics" 24 "Insulin" 25 "Loop Diuretics" 26 "Metformin" 27 "Spironolactone" 28 "Thiazide" 29 "Statin" 30 "Recent HF Hospitalization" 31 "Total HF Hospitalizations" 32 "Year of Drug Initiation"

label values var_index var_labels


twoway (scatter var_index unweighted) (scatter var_index extremeweightsremoved)


