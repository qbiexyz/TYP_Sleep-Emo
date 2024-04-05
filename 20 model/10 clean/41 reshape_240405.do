* Last Updated: 2024. 04. 05
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

cd "C:\Dropbox\學習\碩士\碩論"
	 
/*****************************************
*                                        *
******************************************/
est clear

do "20 model\10 clean\31 keep_240405.do"



reshape long ///
weekdayST_w weekendST_w ///
TST_w TST3_w SD_w WndD_w sleepP_w ///
happy_w dep_w ///
, i(id1) j(wave)

ren *_w *

save "10 data\TYPSleep_analysis", replace
         
lab var weekdayST "平日睡眠時間"
lab var weekendST "假日睡眠時間"
lab var TST "加權睡眠時間"
lab var TST3 "睡眠時間三類"
lab def TST3 1 "未滿6小時" 2 "6-8小時" 3 "超過8小時"
lab val TST3 TST3 
lab var SD "睡眠不足"
lab var WndD "假日-平日睡眠時間"
lab var sleepP "睡眠問題"
lab var happy "快樂情緒1-4"
lab var dep "憂鬱情緒1-5"


save "10 data\TYPSleepLong_analysis", replace


sem (TST_w2 -> TST_w3, ) (TST_w2 -> dep_w3, ) (TST_w3 -> TST_w5, ) ///
 (TST_w3 -> dep_w5, ) (TST_w5 -> TST_w6, ) (TST_w5 -> dep_w6, ) ///
 (TST_w6 -> TST_w9, ) (TST_w6 -> dep_w9, ) (TST_w9 -> TST_w12, ) ///
 (TST_w9 -> dep_w12, ) (dep_w2 -> TST_w3, ) (dep_w2 -> dep_w3, ) ///
 (dep_w3 -> TST_w5, ) (dep_w3 -> dep_w5, ) (dep_w5 -> TST_w6, ) ///
 (dep_w5 -> dep_w6, ) (dep_w6 -> TST_w9, ) (dep_w6 -> dep_w9, ) ///
 (dep_w9 -> TST_w12, ) (dep_w9 -> dep_w12, ) ///
 , cov( TST_w2*dep_w2 e.TST_w3*e.dep_w3 e.TST_w5*e.dep_w5 ///
 e.TST_w6*e.dep_w6 e.TST_w9*e.dep_w9 e.TST_w12*e.dep_w12) nocapslatent

 
 sem (TST_w2 -> TST_w3, ) (TST_w2 -> happy_w3, ) (TST_w3 -> TST_w5, ) ///
 (TST_w3 -> happy_w5, ) (TST_w5 -> TST_w6, ) (TST_w5 -> happy_w6, ) ///
 (TST_w6 -> TST_w9, ) (TST_w6 -> happy_w9, ) (TST_w9 -> TST_w12, ) ///
 (TST_w9 -> happy_w12, ) (happy_w2 -> TST_w3, ) (happy_w2 -> happy_w3, ) ///
 (happy_w3 -> TST_w5, ) (happy_w3 -> happy_w5, ) (happy_w5 -> TST_w6, ) ///
 (happy_w5 -> happy_w6, ) (happy_w6 -> TST_w9, ) (happy_w6 -> happy_w9, ) ///
 (happy_w9 -> TST_w12, ) (happy_w9 -> happy_w12, ) ///
 , cov( TST_w2*happy_w2 e.TST_w3*e.happy_w3 e.TST_w5*e.happy_w5 ///
 e.TST_w6*e.happy_w6 e.TST_w9*e.happy_w9 e.TST_w12*e.happy_w12) nocapslatent