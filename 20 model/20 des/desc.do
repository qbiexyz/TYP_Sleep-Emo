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
use "10 data\TYPSleepHappy9m_analysis.dta", clear

drop x4 y4 z4



sum x* y* z* 

tab1 male agey peduc urban


pwcorr ///
	x1 y1 z1 ///
	x2 y2 z2 ///
	x3 y3 z3 ///
	x5 y5 z5 ///
	x6 y6 z6 ///
	x7 y7 z7 ///
	x8 y8 z8 ///
	x9 y9 z9 ///
	,star(0.001)

	
setstars(***@.001, **@.01, *@.05)

wmtcorr  ///
	x1 y1 z1 ///
	x2 y2 z2 ///
	x3 y3 z3 ///
	x5 y5 z5 ///
	x6 y6 z6 ///
	x7 y7 z7 ///
	x8 y8 z8 ///
	x9 y9 z9 ///
	using corr.rtf, replace pwcorr

asdoc pwcorr ///
	x1 y1 z1 ///
	x2 y2 z2 ///
	x3 y3 z3 ///
	x5 y5 z5 ///
	x6 y6 z6 ///
	x7 y7 z7 ///
	x8 y8 z8 ///
	x9 y9 z9 ///
	, star(0.01)


/*




bysort location : sum z* 


pwcorr x* y* ,star(0.05)
pwcorr x* z* ,star(0.05)

pwcorr y* z* ,star(0.05)
pwcorr nmis_w* ,star(0.05)
mcartest nmis
*/
