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
    id1 asurban aslocation ///
	as302000 assex asbirth asfaedu asmaedu asfaocc asmaocc asincome ///
	as312001 - as312016 

order ///
    id1 asurban aslocation ///
	as302000 assex asbirth asfaedu asmaedu asfaocc asmaocc asincome ///
	as312001 - as312016 

gen nmis = 1

ren ///
    (as302000 assex asbirth ///
	 asfaedu asmaedu asfaocc asmaocc asincome ///
	as312001 - as312016  nmis) =_w1

sort id1

save "j1w1s\j1w1s_id1.dta", replace


*************************************************************************
use "j1w2s\j1w2s.dta", clear

keep ///
    id1 bsurban bslocation bsbirth bsfedu bsmedu bsincome ///
	bs602000 bs615001 - bs615016 

order ///
    id1 bsurban bslocation bsbirth bsfedu bsmedu bsincome ///
	bs602000 bs615001 - bs615016 

gen nmis = 1

ren ///
    (bsbirth bsfedu bsmedu bsincome ///
	 bs602000 bs615001 - bs615016 nmis) =_w2

sort id1

save "j1w2s\j1w2s_id1.dta", replace


*************************************************************************
use "j1w3s\j1w3s.dta", clear

keep ///
    id1 csurban cslocation cssex csbirth csfaedu csmaedu csincome ///
	cs901000 cs919001 - cs919016

order ///
    id1 csurban cslocation cssex csbirth csfaedu csmaedu csincome ///
	cs901000 cs919001 - cs919016
	
gen nmis = 1

ren ///
    (cssex csbirth csfaedu csmaedu csincome ///
	cs901000 cs919001 - cs919016 nmis) =_w3

sort id1

save "j1w3s\j1w3s_id1.dta", replace


*************************************************************************
use "j1w5s\j1w5s.dta", clear

keep ///
	id1 ///
	es143000 es119000 - es125000

order ///
	id1 ///
	es143000 es119000 - es125000

gen nmis = 1

ren ///
	(es143000 es119000 - es125000 nmis) =_w5

sort id1

save "j1w5s\j1w5s_id1.dta", replace

*************************************************************************
use "j1w6s\j1w6s.dta", clear

keep ///
	id1  ///
	fs610000 fs609001 - fs609016

order ///
	id1  ///
	fs610000 fs609001 - fs609016

gen nmis = 1

ren ///
	(fs610000 fs609001 - fs609016 nmis) =_w6

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

gen nmis = 1
	
ren ///
	(is055000 is059001 - is059016 nmis) =_w9

sort id1

save "j1w9s\j1w9s_id1.dta", replace

*************************************************************************
use "j1w10s\TYP2011.dta" , clear

keep if m1sgroup == 1

keep ///
	id1 ///
	m1s067000 m1s064001 - m1s064016

order ///
	id1 ///
	m1s067000 m1s064001 - m1s064016

gen nmis = 1
	
ren ///
	(m1s067000 m1s064001 - m1s064016 nmis) =_w10

sort id1

save "j1w10s\j1w10s_id1.dta", replace

*************************************************************************
use "j1w11s\TYP2014.dta" , clear

keep if m2sgroup == 1

keep ///
	id1 ///
	m2s075000 m2s077001 - m2s077016

order ///
	id1 ///
	m2s075000 m2s077001 - m2s077016

gen nmis = 1

ren ///
	(m2s075000 m2s077001 - m2s077016 nmis) =_w11

sort id1

save "j1w11s\j1w11s_id1.dta", replace

*************************************************************************
use "j1w12s\TYP2017.dta" , clear

keep if group == 1
gen id1 = id2 - 100000


keep ///
	id1 m3ssex m3sedulevel m3sedulevel_open  ///
	m3sedudeg m3sfaedu m3smaedu m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 

order ///
	id1 m3ssex m3sedulevel m3sedulevel_open  ///
	m3sedudeg m3sfaedu m3smaedu m3sincome_house ///
	m3s063000 m3s076010 - m3s076160

gen nmis = 1

ren ///
	(m3ssex m3sedulevel m3sedulevel_open  ///
	m3sedudeg m3sfaedu m3smaedu m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 nmis) =_w12

sort id1

save "j1w12s\j1w12s_id1.dta", replace

/************************************************************************

************************************************************************/
use "j1w1s\j1w1s_id1.dta" , clear

foreach x of num 1/3 5 6 9/12{
	merge 1:1 id1 using "j1w`x's\j1w`x's_id1.dta"
	ren _merge _merge`x'
}

save "TYPSleepHappy9m.dta", replace


