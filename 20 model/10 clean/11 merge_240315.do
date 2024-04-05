* Last Updated: 2024. 03. 15
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

cd "C:\Dropbox\學習\碩士\碩論\10 data"
	 
/*****************************************
*                                        *
******************************************/

/*************************************************************************

*************************************************************************/
use "j1w2s\j1w2s.dta", clear

keep ///
    id1 bsurban bslocation bssex bsbirth ///
	bsfedu bsmedu bsfocc bsmocc bsincome ///
	bs602000 bs615001 - bs615016 ///
	bs604001 - bs605004

order ///
    id1 bsurban bslocation bssex bsbirth ///
	bsfedu bsmedu bsfocc bsmocc bsincome ///
	bs602000 bs615001 - bs615016 ///
	bs604001 - bs605004


ren ///
    (bsurban bslocation bssex bsbirth ///
	bsfedu bsmedu bsfocc bsmocc bsincome ///
	bs602000 bs615001 - bs615016 ///
	bs604001 - bs605004) =_w2

sort id1

save "j1w2s\j1w2s_id1.dta", replace

*************************************************************************
use "j1w3s\j1w3s.dta", clear

keep ///
    id1 csurban cslocation cssex csbirth ///
	csfaedu csmaedu csfaocc csmaocc csincome ///
	cs901000 cs919001 - cs919016 ///
	cs903001 - cs904004

order ///
    id1 csurban cslocation cssex csbirth ///
	csfaedu csmaedu csfaocc csmaocc csincome ///
	cs901000 cs919001 - cs919016 ///
	cs903001 - cs904004


ren ///
    (csurban cslocation cssex csbirth ///
	csfaedu csmaedu csfaocc csmaocc csincome ///
	cs901000 cs919001 - cs919016 ///
	cs903001 - cs904004) =_w3

sort id1

save "j1w3s\j1w3s_id1.dta", replace

*************************************************************************
use "j1w5s\j1w5s.dta", clear

keep ///
	id1 eslocation espub essccl esschnew es087000 ///
	es143000 es119000 - es125000 ///
	es109001 - es112002

order ///
	id1 eslocation espub essccl esschnew es087000 ///
	es143000 es119000 - es125000 ///
	es109001 - es112002


ren ///
	(eslocation espub essccl esschnew es087000 ///
	es143000 es119000 - es125000 ///
	es109001 - es112002) =_w5

sort id1

save "j1w5s\j1w5s_id1.dta", replace

*************************************************************************
use "j1w6s\j1w6s.dta", clear

keep ///
	id1 fssex - fsmaedu ///
	fs610000 fs609001 - fs609016 ///
	fs612a01 - fs613b02

order ///
	id1 fssex - fsmaedu ///
	fs610000 fs609001 - fs609016 ///
	fs612a01 - fs613b02


ren ///
	(fssex - fsmaedu ///
	fs610000 fs609001 - fs609016 ///
	fs612a01 - fs613b02) =_w6

sort id1

save "j1w6s\j1w6s_id1.dta", replace

*************************************************************************
use "j1w9s\j1w9s.dta", clear

keep ///
	id1 id2 is001000 is055000 isgender - isincome ///
	is060000 is059001 - is059016 ///
	is036a01 - is0361b2

order ///
	id1 id2 is001000 is055000 isgender - isincome ///
	is060000 is059001 - is059016 ///
	is036a01 - is0361b2


ren ///
	(is001000 is055000 isgender - isincome ///
	is060000 is059001 - is059016 ///
	is036a01 - is0361b2) =_w9

sort id1

save "j1w9s\j1w9s_id1.dta", replace

*************************************************************************
use "TYP2017\TYP2017.dta" , clear

keep ///
	id2 m3ssex m3sedulevel m3sedulevel_open ///
	m3sedudeg m3sedugra m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 ///
	m3s128011 - m3s128024

order ///
	id2 m3ssex m3sedulevel m3sedulevel_open ///
	m3sedudeg m3sedugra m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 ///
	m3s128011 - m3s128024


ren ///
	(m3ssex m3sedulevel m3sedulevel_open ///
	m3sedudeg m3sedugra m3sincome_house ///
	m3s063000 m3s076010 - m3s076160 ///
	m3s128011 - m3s128024) =_w12

sort id2

save "TYP2017\j1w12s_id1.dta", replace

/************************************************************************

************************************************************************/
use "j1w2s\j1w2s_id1.dta" , clear

merge 1:1 id1 using "j1w3s\j1w3s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "j1w5s\j1w5s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "j1w6s\j1w6s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id1 using "j1w9s\j1w9s_id1.dta"
keep if _merge == 3
drop _merge

merge 1:1 id2 using "TYP2017\j1w12s_id1.dta"
keep if _merge == 3
drop _merge

save "TYPSleep__240315.dta", replace
