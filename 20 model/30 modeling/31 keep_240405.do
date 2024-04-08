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

use "10 data\TYPSleep__240315.dta", clear

do "20 model\10 clean\21 sleep_240405.do"
do "20 model\10 clean\22 emo_240405.do"

keep ///
id1 ///
weekdayST_w* weekendST_w*  ///
TST_w* TST3_w* SD_w* WndD_w* sleepP_w* ///
happy_w* dep_w*


pwcorr weekdayST_w* happy_w*, star(0.05)
pwcorr sleepP_w* happy_w*, star(0.05)
pwcorr TST_w* happy_w*, star(0.05)

pwcorr weekdayST_w* dep_w*, star(0.05)
pwcorr sleepP_w* dep_w*, star(0.05)
pwcorr TST_w* happy_w*, star(0.05)

pwcorr weekdayST_w* sleepP_w*, star(0.05)
