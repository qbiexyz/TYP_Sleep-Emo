* Last Updated: 2024. 04. 05
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

cd "C:\Dropbox\學習\碩士\碩論\TYP_Sleep-Emo"
	 
/*****************************************
*                                        *
******************************************/
est clear
use "10 data\TYPSleepHappy9m.dta", clear

/*****************************************
*             正/負面情緒               *
******************************************/

/*************************************************************************
快樂

lookfor 快樂
di r(varlist)
tabm ///
as302000_w1 bs602000_w2 cs901000_w3 es143000_w5 fs610000_w6 ///
is055000_w9 m1s067000_w10 m2s075000_w11 m3s063000_w12

*************************************************************************/
gen happy_w1 = as302000_w1
gen happy_w2 = bs602000_w2
gen happy_w3 = cs901000_w3

gen happy_w5 = es143000_w5

gen happy_w6 = fs610000_w6
gen happy_w9 = is055000_w9
gen happy_w10 = m1s067000_w10
gen happy_w11 = m2s075000_w11
gen happy_w12 = m3s063000_w12

foreach x of num 1 2 3 5 6 9 10 11 12 {
	mvdecode happy_w`x', mv(7/9)
	if (`x' <= 6) replace happy_w`x' = 5 - happy_w`x'
		else recode happy_w`x' (1 = 4)(2 = 3.33)(3 = 2.67)(4 = 2)(5 = 1)
	/* drop if happy_w`x' == . */
}

/*
/*************************************************************************
憂鬱
as312001_w1 - as312006_w1 as312008_w1 - as312011_w1 as312014_w1 as312016_w1
cs919001_w3 - cs919006_w3 cs919008_w3 - cs919011_w3 cs919014_w3 - cs919016_w3
fs609001_w6 - fs609006_w6 fs609008_w6 - fs609011_w6 fs609014_w6 - fs609016_w6
is059001_w9 - is059006_w9 is059008_w9 - is059011_w9 is059014_w9 - is059016_w9

m1s064001_w10 - m1s064006_w10 m1s064008_w10 - m1s064011_w10 
m1s064014_w10  - m1s064016_w10

m2s077001_w11 - m2s077006_w11 m2s077008_w11 - m2s077011_w11 
m2s077014_w11 - m2s077016_w11

m3s076010_w12 - m3s076060_w12 m3s076080_w12 - m3s076110_w12 
m3s076140_w12 - m3s076160_w12
*************************************************************************/

global dep0_w1 "as312001_w1 - as312006_w1 as312008_w1 - as312011_w1 as312014_w1 as312016_w1"
global dep0_w2 "bs615001_w2 - bs615006_w2 bs615008_w2 - bs615011_w2 bs615014_w2 - bs615016_w2"
global dep0_w3 "cs919001_w3 - cs919006_w3 cs919008_w3 - cs919011_w3 cs919014_w3 - cs919016_w3"
global dep0_w6 "fs609001_w6 - fs609006_w6 fs609008_w6 - fs609011_w6 fs609014_w6 - fs609016_w6"
global dep0_w9 "is059001_w9 - is059006_w9 is059008_w9 - is059011_w9 is059014_w9 - is059016_w9"
global dep0_w10 "m1s064001_w10 - m1s064006_w10 m1s064008_w10 - m1s064011_w10 m1s064014_w10  - m1s064016_w10"
global dep0_w11 "m2s077001_w11 - m2s077006_w11 m2s077008_w11 - m2s077011_w11 m2s077014_w11 - m2s077016_w11"
global dep0_w12 "m3s076010_w12 - m3s076060_w12 m3s076080_w12 - m3s076110_w12 m3s076140_w12 - m3s076160_w12"

foreach x of var $dep0_w1 $dep0_w2 $dep0_w3 $dep0_w6 $dep0_w9 ///
                 $dep0_w10 $dep0_w11 $dep0_w12 {
	mvdecode `x', mv(6/9)
	replace `x' = `x' - 1
}

foreach x of num 1 2 3 6 9 10 11 12{
	egen dep_w`x' =  rmean( ${dep0_w`x'} ) 
}
*/

/*************************************************************************
憂鬱2
*************************************************************************/

global dep3_w1 "as312003_w1 - as312005_w1"
global dep3_w2 "bs615003_w2 - bs615005_w2"
global dep3_w3 "cs919003_w3 - cs919005_w3"

global dep3_w5 "es120000_w5 es121000_w5"

global dep3_w6 "fs609003_w6 - fs609005_w6"
global dep3_w9 "is059003_w9 - is059005_w9"
global dep3_w10 "m1s064003_w10 - m1s064005_w10"
global dep3_w11 "m2s077003_w11 - m2s077005_w11"
global dep3_w12 "m3s076030_w12 - m3s076050_w12"

foreach x of var $dep3_w1 $dep3_w2 $dep3_w3 ///
                 $dep3_w5 $dep3_w6 $dep3_w9 ///
				 $dep3_w10 $dep3_w11 $dep3_w12 {
	mvdecode `x', mv(6/9)
}

foreach x in dep3_w1 dep3_w2 dep3_w3 ///
             dep3_w5 dep3_w6 dep3_w9 ///
		     dep3_w10 dep3_w11 dep3_w12 {
	alpha $`x'
}


foreach x of num 1 2 3 5 6 9 10 11 12{
	egen dep3_w`x' =  rmean( ${dep3_w`x'} ) 
}


/*****************************************
*               睡眠問題                 *
******************************************/

/*************************************************************************

lookfor 失眠
di r(varlist)
as312007_w1 bs615007_w2 cs919007_w3 es122000_w5 fs609007_w6 ///
is059007_w9 m1s064007_w10 m2s077007_w11 m3s076070_w12


lookfor 不安穩
di r(varlist)
as312013_w1 bs615013_w2 cs919013_w3 fs609013_w6 ///
is059013_w9 m1s064013_w10 m2s077013_w11 m3s076130_w12

lookfor 一大早
di r(varlist)
as312012_w1 bs615012_w2 cs919012_w3 fs609012_w6 ///
is059012_w9 m1s064012_w10 m2s077012_w11 m3s076120_w12
	replace `x' = `x' - 1
*************************************************************************/
global sleepP0_w1 "as312007_w1 as312013_w1 as312012_w1"
global sleepP0_w2 "bs615007_w2 bs615012_w2 bs615013_w2"
global sleepP0_w3 "cs919007_w3 cs919012_w3 cs919013_w3"

global sleepP0_w5 "es122000_w5"

global sleepP0_w6 "fs609007_w6 fs609012_w6 fs609013_w6"
global sleepP0_w9 "is059007_w9 is059012_w9 is059013_w9"
global sleepP0_w10 "m1s064007_w10 m1s064013_w10 m1s064012_w10"
global sleepP0_w11 "m2s077007_w11 m2s077013_w11 m2s077012_w11"
global sleepP0_w12 "m3s076070_w12 m3s076120_w12 m3s076130_w12"

/*
tabm $sleepP0_w1 $sleepP0_w2 $sleepP0_w3   ///
                 $sleepP0_w6 $sleepP0_w9 $sleepP0_w10 $sleepP0_w11 ///
				 $sleepP0_w12 , m
*/

foreach x of var $sleepP0_w1 $sleepP0_w2 $sleepP0_w3 $sleepP0_w5 ///
                 $sleepP0_w6 $sleepP0_w9 $sleepP0_w10 $sleepP0_w11 ///
				 $sleepP0_w12 {
	mvdecode `x', mv(6/9)
}


foreach x in sleepP0_w1 sleepP0_w2 sleepP0_w3  ///
                 sleepP0_w6 sleepP0_w9 sleepP0_w10 sleepP0_w11 ///
				 sleepP0_w12 {
	alpha $`x'
}


foreach x of num 1 2 3 5 6 9 10 11 12 {
	egen sleepP_w`x' =  rmean( ${sleepP0_w`x'} ) 
}


/*****************************************
*                 other                  *
******************************************/
* male
foreach x of var assex_w1 cssex_w3 m3ssex_w12{
	recode `x' (1 = 1 "男")(2 = 0 "女"), gen(male_`x')
	lab var male_`x' "男"
}

egen male =  rsum(male_*) 

recode male (1/5 = 1 )(0 = 0 )
lab var male "男"

* age
gen age1 = 2000 - 1911 - asbirth_w1
gen age2 = 2000 - 1911 - bsbirth_w2
gen age3 = 2000 - 1911 - csbirth_w3

gen age = age1
replace age = age2 if age == . 
replace age = age3 if age == . 

recode age (13 = 1)(14/17 = 0), gen(agey)

* peduc
recode asfaedu_w1 asmaedu_w1 (1/4 8 = 0)(5/7 = 1)(* = -1)
recode bsfedu_w2 bsmedu_w2 (1/4 8 = 0)(5/8 = 1)(* = -1)
recode csfaedu_w3 csmaedu_w3  (1/4 = 0)(5/8 = 1)(* = -1)
recode m3sfaedu_w12 m3smaedu_w12 (1/5 = 0)(6/8 = 1)(* = -1)

gen peduc1 = asfaedu_w1
replace peduc1 = asmaedu_w1 if asmaedu_w1 > asfaedu_w1

gen peduc2 = bsfedu_w2
replace peduc2 = bsmedu_w2 if bsmedu_w2 > bsfedu_w2

gen peduc3 = csfaedu_w3
replace peduc3 = csmaedu_w3 if csmaedu_w3 > csfaedu_w3

gen peduc4 = m3sfaedu_w12
replace peduc4 = m3smaedu_w12 if m3smaedu_w12 > m3sfaedu_w12

gen peduc = peduc1
replace peduc = peduc2 if peduc == . | peduc < 0 
replace peduc = peduc3 if peduc == . | peduc < 0 
replace peduc = peduc4 if peduc == . | peduc < 0 
replace peduc = 1 if id1 == 10485 | id1 == 20593 | id1 == 10671
replace peduc = 0 if id1 == 20516
replace peduc = . if peduc == -1

* inc
recode asincome_w1 bsincome_w2 csincome_w3 ///
	   (1 = 1)(2/13 = 0)(* = .)
gen inc = asincome_w1
replace inc = bsincome_w2 if inc == .
replace inc = csincome_w3 if inc == .


* urban
clonevar urban = asurban
replace urban = bsurban if urban == .
replace urban = csurban if urban == .

recode urban (1 2 = 1)(3/6 = 0)

/*****************************************
*                 keep                   *
******************************************/

keep ///
id1 male age agey peduc inc urban ///
happy_w* sleepP_w* dep3_w* _merge* nmis_w*

order ///
id1 male age agey peduc inc urban ///
happy_w* sleepP_w* dep3_w* _merge* nmis_w*

ren sleepP_w* x*
ren happy_w* y*
ren dep3_w* z*

foreach x in "x" "y" "z" "_merge" "nmis_w" {
	ren `x'5 `x'4	
	ren `x'6 `x'5
	ren `x'9 `x'6
	ren `x'10 `x'7
	ren `x'11 `x'8
	ren `x'12 `x'9
}

/*****************************************
*             缺失值處理                *
******************************************/

/*************************************************************************
nmis_w* 該波次有參與之樣本 (最少會有一次)


如果該波x y z 都是缺失才算沒有參與

nmis 有參與波次數量
*************************************************************************/
tabm nmis_w*

foreach x of num 1/9 {
replace nmis_w`x' = . ///
	if x`x' == . & z`x' == . & y`x' == . & nmis_w`x' == 1
}

drop nmis_w4 /*高二不要放*/
egen nmis = rsum(nmis_w*)
recode nmis_w* (. = 0) 
tab nmis

/*
*/
recode nmis (1/4 = 1)(* = 0), gen(misw)
replace misw = 1 if peduc == .

tab misw male ,chi 
tab misw peduc ,chi
tab misw agey ,chi row
tab misw urban ,chi row

ttest x1 , by(misw)
ttest y1 , by(misw)
ttest z1 , by(misw)


/*
*/
egen nmis7 = rsum(nmis_w1 nmis_w3 nmis_w5 nmis_w6 nmis_w7 nmis_w8 nmis_w9)
recode nmis7 (1/3 = 1)(* = 0), gen(misw7)
replace misw7 = 1 if peduc == .
tab nmis7

tab misw7 male ,chi
tab misw7 peduc ,chi
tab misw7 agey ,chi row
tab misw7 urban ,chi row

ttest x1 , by(misw7)
ttest y1 , by(misw7)
ttest z1 , by(misw7)

/*

egen nmis5 = rsum(nmis_w1 nmis_w2 nmis_w3 nmis_w4 nmis_w5)
recode nmis5 (1/2 = 1)(* = 0), gen(misw5)
replace misw5 = 1 if peduc == .
tab nmis5

tab misw5 male ,chi
tab misw5 peduc ,chi
tab misw5 agey ,chi row
tab misw5 urban ,chi row

ttest x1 , by(misw5)
ttest y1 , by(misw5)
ttest z1 , by(misw5)
*/
* 刪除缺失 容忍四波缺失 約流失
drop if nmis <= 4
* drop if nmis7 <= 3

*drop if nmis_w7 == . & nmis_w8 == . & nmis_w9 == .


compress
save "10 data\TYPSleepHappy9m_analysis.dta", replace

/*
id1
10273
11045
20516

sum x* y* z* 

bysort location : sum z* 


pwcorr x* y* ,star(0.05)
pwcorr x* z* ,star(0.05)

pwcorr y* z* ,star(0.05)
pwcorr nmis_w* ,star(0.05)
mcartest nmis
*/
