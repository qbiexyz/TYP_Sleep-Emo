* Last Updated: 2024. 03. 15
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

cd "C:\Dropbox\學習\碩士\碩論\TYP_Sleep-Emo\10 data"
	 
/*****************************************

******************************************/

/*************************************************************************

*************************************************************************/
use "j1w1s\j1w1s.dta", clear

keep ///
    id1 ///
	as302000  ///
	as312001 - as312016 asfaocc asmaocc

order ///
    id1 ///
	as302000 ///
	as312001 - as312016 asfaocc asmaocc

ren ///
    (as302000 ///
	as312001 - as312016 asfaocc asmaocc) =_w1

sort id1

save "j1w1s\j1w1s_id1.dta", replace



*************************************************************************
use "j1w3s\j1w3s.dta", clear

keep ///
    id1 ///
	cs901000 cs919001 - cs919016

order ///
    id1 ///
	cs901000 cs919001 - cs919016

ren ///
    (cs901000 cs919001 - cs919016 ) =_w3

sort id1

save "j1w3s\j1w3s_id1.dta", replace


*************************************************************************
use "j1w6s\j1w6s.dta", clear

keep ///
	id1  ///
	fs610000 fs609001 - fs609016

order ///
	id1  ///
	fs610000 fs609001 - fs609016

ren ///
	(fs610000 fs609001 - fs609016) =_w6

sort id1

save "j1w6s\j1w6s_id1.dta", replace

*************************************************************************
use "j1w9s\j1w9s.dta", clear

keep ///
	id1 ///
	is055000 is059001 - is059016

order ///
	id1 ///
	is055000 is059001 - is059016

ren ///
	(is055000 is059001 - is059016) =_w9

sort id1

save "j1w9s\j1w9s_id1.dta", replace

*************************************************************************
use "TYP2011\TYP2011.dta" , clear

keep if m1sgroup == 1

keep ///
	id1 ///
	m1s067000 m1s064001 - m1s064016

order ///
	id1 ///
	m1s067000 m1s064001 - m1s064016

ren ///
	(m1s067000 m1s064001 - m1s064016) =_w10

sort id1

save "TYP2011\j1w10s_id1.dta", replace

*************************************************************************
use "TYP2014\TYP2014.dta" , clear

keep if m2sgroup == 1

keep ///
	id1 id2 ///
	m2s075000 m2s077001 - m2s077016

order ///
	id1 id2 ///
	m2s075000 m2s077001 - m2s077016

ren ///
	(m2s075000 m2s077001 - m2s077016) =_w11

sort id1

save "TYP2014\j1w11s_id1.dta", replace

*************************************************************************
use "TYP2017\TYP2017.dta" , clear

keep ///
	id2 m3ssex m3sedulevel m3sedulevel_open  ///
	m3sedudeg m3sfaedu m3smaedu m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 

order ///
	id2 m3ssex m3sedulevel m3sedulevel_open  ///
	m3sedudeg m3sfaedu m3smaedu m3sincome_house ///
	m3s063000 m3s076010 - m3s076160


ren ///
	(m3ssex m3sedulevel m3sedulevel_open  ///
	m3sedudeg m3sfaedu m3smaedu m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 ) =_w12

sort id2

save "TYP2017\j1w12s_id1.dta", replace

/************************************************************************

************************************************************************/
use "j1w1s\j1w1s_id1.dta" , clear

merge 1:1 id1 using "j1w3s\j1w3s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "j1w6s\j1w6s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "j1w9s\j1w9s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "TYP2011\j1w10s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "TYP2014\j1w11s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id2 using "TYP2017\j1w12s_id1.dta"
keep if _merge == 3
drop _merge

save "TYPSleepHappy7.dta", replace
