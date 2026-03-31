clear
import delimited "P:\ORD_Sundaram_202108013D\Padmini\Diabetes Stata Files\HFrEF GLP1\GLP1 HFrEF Standardized Differences graph.csv"



** balance plot***
egen var_index = group(variable)

sort var_index

list

** define labels**
label define var_labels  1 "Age" 2 "BMI" 3 "Sex" 4 "AF" 5 "COPD" 6 "Depression" 7 "Alcohol" 8 "Hypertension" 9 "CAD" 10 "MI" 11 "CKD " 12 "CLD" 13 "Cancer" 14 "PAD" 15 "Polyabuse" 16 "PPM" 17 "Schizo" 18 "Stroke" 19 "Creatinine" 20 "HBA1C" 21 "ACE" 22 "BB" 23 "Antiarr" 24 "Insulin" 25 "LD" 26 "Metformin" 27 "Spiro" 28 "TZD" 29 "Statin" 30 "HFH" 31 "THFH" 32 "Year"

label values var_index var_labels


twoway (scatter var_index unweighted) (scatter var_index weighted)


