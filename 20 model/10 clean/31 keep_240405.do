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


foreach x of num 2 3 5 6 9 12 {
	gen qq_w`x' = 0
	replace qq_w`x' = 1 if weekdayST_w`x' < 7
}


gen qq = 1 if ///
	weekdayST_w2 < 7 & weekdayST_w3 <7 & ///
	weekdayST_w5 < 7 & weekdayST_w6 <7 & ///
	weekdayST_w9 < 7 & weekdayST_w12 <7 
	
egen qqq = rsum(qq_w*)