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
use "10 data\TYPSleepHappy7.dta", clear


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

gen happy_w3 = cs901000_w3

gen happy_w6 = fs610000_w6
gen happy_w9 = is055000_w9
gen happy_w10 = m1s067000_w10
gen happy_w11 = m2s075000_w11
gen happy_w12 = m3s063000_w12

foreach x of num 1 3 6 9 10 11 12 {
	mvdecode happy_w`x', mv(7/9)
	if (`x' <= 6) replace happy_w`x' = 5 - happy_w`x'
		else recode happy_w`x' (1 = 4)(2 = 3.33)(3 = 2.67)(4 = 2)(5 =1)
	/* drop if happy_w`x' == . */
}

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
global dep0_w3 "cs919001_w3 - cs919006_w3 cs919008_w3 - cs919011_w3 cs919014_w3 - cs919016_w3"
global dep0_w6 "fs609001_w6 - fs609006_w6 fs609008_w6 - fs609011_w6 fs609014_w6 - fs609016_w6"
global dep0_w9 "is059001_w9 - is059006_w9 is059008_w9 - is059011_w9 is059014_w9 - is059016_w9"
global dep0_w10 "m1s064001_w10 - m1s064006_w10 m1s064008_w10 - m1s064011_w10 m1s064014_w10  - m1s064016_w10"
global dep0_w11 "m2s077001_w11 - m2s077006_w11 m2s077008_w11 - m2s077011_w11 m2s077014_w11 - m2s077016_w11"
global dep0_w12 "m3s076010_w12 - m3s076060_w12 m3s076080_w12 - m3s076110_w12 m3s076140_w12 - m3s076160_w12"

tabm $dep0_w3 $dep0_w6 $dep0_w9 $dep0_w10 $dep0_w11 $dep0_w12 , m

foreach x of var $dep0_w1 $dep0_w3 $dep0_w6 $dep0_w9 ///
                 $dep0_w10 $dep0_w11 $dep0_w12 {
	mvdecode `x', mv(6/9)
	replace `x' = `x' - 1
}

foreach x of num 1 3 6 9 10 11 12{
	egen dep_w`x' =  rsum( ${dep0_w`x'} ) 
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
*************************************************************************/
global sleepP0_w1 "as312007_w1 as312013_w1 as312012_w1"

global sleepP0_w3 "cs919007_w3 cs919012_w3 cs919013_w3"

global sleepP0_w6 "fs609007_w6 fs609012_w6 fs609013_w6"
global sleepP0_w9 "is059007_w9 is059012_w9 is059013_w9"
global sleepP0_w10 "m1s064007_w10 m1s064013_w10 m1s064012_w10"
global sleepP0_w11 "m2s077007_w11 m2s077013_w11 m2s077012_w11"
global sleepP0_w12 "m3s076070_w12 m3s076120_w12 m3s076130_w12"

tabm $sleepP0_w1  $sleepP0_w3  $sleepP0_w6 ///
     $sleepP0_w9 $sleepP0_w10 $sleepP0_w11 $sleepP0_w12 , m

foreach x of var $sleepP0_w1  $sleepP0_w3  ///
                 $sleepP0_w6 $sleepP0_w9 $sleepP0_w10 $sleepP0_w11 ///
				 $sleepP0_w12 {
	mvdecode `x', mv(6/9)
	replace `x' = `x' - 1
}

foreach x of num 1 3 6 9 10 11 12 {
	egen sleepP_w`x' =  rsum( ${sleepP0_w`x'} ) 
}

/*****************************************
*                 other                 *
******************************************/

* male
recode m3ssex_w12 (1 = 1 "男")(2 = 0 "女"), gen(male)
lab var male "男"

/*****************************************
*                 keep                   *
******************************************/

keep ///
id2 male ///
happy_w* sleepP_w* dep_w*

order ///
id2 male ///
happy_w* sleepP_w* dep_w*


ren sleepP_w* x*
ren happy_w* y*
ren dep_w* z*


foreach x in "x" "y" "z" {
	ren `x'3 `x'2
	ren `x'6 `x'3
	ren `x'9 `x'4
	ren `x'10 `x'5
	ren `x'11 `x'6
	ren `x'12 `x'7
}


compress
save "10 data\TYPSleepHappy7_analysis.dta", replace

/*
pwcorr happy_w* sleepP_w* ,star(0.05)
pwcorr happy_w* sleepP_w* ,star(0.05)
*/





