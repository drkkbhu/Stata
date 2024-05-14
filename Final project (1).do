** Final Project

** Research Question
**Overweight people are more susceptible to the disease like asthma, cancer and liver diseases.

**Importing NHANES 2021 Dataset

clear
cd "D:\Spring Sem\Stata\Final Project"
import sasxport5 P_MCQ.XPT, clear
br

**Cleaning dataset
*Dropping don't know responses from the varibale of interest.
drop if mcq010==9
drop if mcq080==9
drop if mcq220==9
drop if mcq500==9

**Recoding the variable
recode mcq010(1=0) (2=1)
recode mcq080(1=0) (2=1)
recode mcq220(1=0) (2=1)
recode mcq500(1=0) (2=1)

**Labeling values
label define mcq010 0 "yes" 1 "no"
label value mcq01 mcq010


label define mcq080 0 "yes" 1 "no"
label value mcq08 mcq080


label define mcq220 0 "yes" 1 "no"
label value mcq22 mcq220


label define mcq500 0 "yes" 1 "no"
label value mcq50 mcq500


**Renaming varibale
rename mcq010 asthma
rename mcq080 overweight
rename mcq220 cancer
rename mcq500 liver_condition

**Descriptive statistics
describe overweight cancer asthma liver_condition

summarize

**Exploring data and descriptice statistics
foreach var of var asthma cancer liver_condition{
	ta `var' overweight
}

**Cross table
tab overweight cancer, col row cell
tab overweight asthma, col row cell
tab overweight liver_condition, col row cell


**Test of association
tab overweight cancer, col chi2
tab overweight asthma, col chi2
tab overweight liver_condition, col chi2

**Graph to visualise

**gen overweight
gen overweight2 = overweight*100
tab overweight2

**overweight by cancer
graph bar (mean) overweight2, over(cancer, label(labsize(small))) /// 
				ylabel(0 "0" 20 "20%" 40 "40%" 60 "60%" 80 "80%" 100 "100%", labsize(small)) ///
				title("{bf:overweight by cancer}", size(medsmall) position(12)) ///
				ytitle("%overweight", size(medsmall)) ///
				blabel(bar, size(small) format(%2.1f)) ///
				bar(1, color(gs4)) ///
				scheme(burd)
graph export "desc_overweight_by_cancer.jpg", width(1200) height(800) as (jpg) replace

**overweight by asthma
graph bar (mean) overweight2, over(asthma, label(labsize(small))) /// 
				ylabel(0 "0" 20 "20%" 40 "40%" 60 "60%" 80 "80%" 100 "100%", labsize(small)) ///
				title("{bf:overweight by asthma}", size(medsmall) position(12)) ///
				ytitle("%overweight", size(medsmall)) ///
				blabel(bar, size(small) format(%2.1f)) ///
				bar(1, color(gs4)) ///
				scheme(burd)				
graph export "desc_overweight_by_asthma.jpg", width(1200) height(800) as (jpg) replace

**overweight by liver condition
graph bar (mean) overweight2, over(liver_condition, label(labsize(small))) /// 
				ylabel(0 "0" 20 "20%" 40 "40%" 60 "60%" 80 "80%" 100 "100%", labsize(small)) ///
				title("{bf:overweight by liver_condition}", size(medsmall) position(12)) ///
				ytitle("%overweight", size(medsmall)) ///
				blabel(bar, size(small) format(%2.1f)) ///
				bar(1, color(gs4)) ///
				scheme(burd)
graph export "desc_overweight_by_liver_condition.jpg", width(1200) height(800) as (jpg) replace


**Regression analysis
logit overweight i.asthma i.cancer, or base
**Export result
 outreg2 using result_logit_overweight2, replace excel label dec(3) eform addstat("pesudo R2", `e(r2_p)') ctitle ("logit") 

margins i.asthma
marginsplot, recast(bar)
marginsplot, title("{bf:overweight by asthma}", size(medsmall) position(12)) ///
				ytitle("%overweight", size(small)) xtitle(, size(small)) ///
				ylabel(0 "0" .20 "20%" .40 "40%" .60 "60%" .80 "80%" 1 "100%") ///
				xlabel(, labsize(small)) ///
				recast(bar) ///
				plotopts(fcolor(gs10) lcolor(green) barw(.7)) ///
				ciopts(lcolor(orange)) ///
				plotregion(margin(7 7 0 0)) ///
				scheme(burd)
graph export "overweight_by_asthma.jpg", width(1200) height(800) as (jpg) replace 
 
margins i.cancer
marginsplot, recast(bar)
marginsplot, title("{bf:overweight by cancer}", size(medsmall) position(12)) ///
				ytitle("%overweight", size(small)) xtitle(, size(small)) ///
				ylabel(0 "0" .20 "20%" .40 "40%" .60 "60%" .80 "80%" 1 "100%") ///
				xlabel(, labsize(small)) ///
				recast(bar) ///
				plotopts(fcolor(gs10) lcolor(green) barw(.7)) ///
				ciopts(lcolor(orange)) ///
				plotregion(margin(7 7 0 0)) ///
				scheme(burd)
graph export "overweight_by_cancer.jpg", width(1200) height(800) as (jpg) replace



 
