* Last Updated: 2024. 04. 05
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

/*
cd "C:\Dropbox\學習\碩士\碩論"
	 
/*****************************************
*                                        *
******************************************/

use "10 data\TYPSleep__240315.dta", clear
*/

/*****************************************
*             睡眠時間               *
******************************************/

/*************************************************************************
平日上床
bs604001_w2 bs604002_w2 cs903001_w3 cs903002_w3 ///
es109001_w5 es109002_w5 fs613a01_w6 fs613a02_w6 ///
is036a01_w9 is036a02_w9 m3s128011_w12 m3s128012_w12


平日起床
bs604003_w2 bs604004_w2 cs903003_w3 cs903004_w3 ///
es110001_w5 es110002_w5 fs613b01_w6 fs613b02_w6 ///
is036b01_w9 is036b02_w9 m3s128013_w12 m3s128014_w12

假日上床
bs605001_w2 bs605002_w2 cs904001_w3 cs904002_w3 ///
es111001_w5 es111002_w5 fs612a01_w6 fs612a02_w6 ///
is0361a1_w9 is0361a2_w9 m3s128021_w12 m3s128022_w12

假日起床
bs605003_w2 bs605004_w2 cs904003_w3 cs904004_w3 ///
es112001_w5 es112002_w5 fs612b01_w6 fs612b02_w6 ///
is0361b1_w9 is0361b2_w9 m3s128023_w12 m3s128024_w12

*************************************************************************/

program drop _all
program define ST_ren

clonevar `5'ST11`6' = `1'
clonevar `5'ST12`6' = `2'
clonevar `5'ST21`6' = `3'
clonevar `5'ST22`6' = `4'

end

ST_ren bs604001_w2 bs604002_w2 bs604003_w2 bs604004_w2 weekday _w2
ST_ren bs605001_w2 bs605002_w2 bs605003_w2 bs605004_w2 weekend _w2

ST_ren cs903001_w3 cs903002_w3 cs903003_w3 cs903004_w3 weekday _w3
ST_ren cs904001_w3 cs904002_w3 cs904003_w3 cs904004_w3 weekend _w3

ST_ren es109001_w5 es109002_w5 es110001_w5 es110002_w5 weekday _w5
ST_ren es111001_w5 es111002_w5 es112001_w5 es112002_w5 weekend _w5

ST_ren fs613a01_w6 fs613a02_w6 fs613b01_w6 fs613b02_w6 weekday _w6
ST_ren fs612a01_w6 fs612a02_w6 fs612b01_w6 fs612b02_w6 weekend _w6

ST_ren is036a01_w9 is036a02_w9 is036b01_w9 is036b02_w9 weekday _w9
ST_ren is0361a1_w9 is0361a2_w9 is0361b1_w9 is0361b2_w9 weekend _w9

ST_ren m3s128011_w12 m3s128012_w12 m3s128013_w12 m3s128014_w12 weekday _w12
ST_ren m3s128021_w12 m3s128022_w12 m3s128023_w12 m3s128024_w12 weekend _w12


* 後面檢誤步驟2，在此更改

replace weekendST11_w3 = 14 if id1 == 10463

replace weekdayST11_w12 = 22 if id1 == 30233
replace weekdayST21_w12 = 8 if id1 == 30233
replace weekendST11_w12 = 22 if id1 == 30233
replace weekendST21_w12 = 9 if id1 == 30233

replace weekdayST11_w3 = 21 if id1 == 10001
replace weekendST11_w3 = 21 if id1 == 10001

replace weekdayST11_w3 = 21 if id1 == 10128

replace weekendST11_w3 = 0 if id1 == 10182

replace weekendST21_w3 = 13 if id1 == 10228

replace weekdayST11_w3 = 23 if id1 == 20976

replace weekendST21_w5 = 14 if id1 == 10488

replace weekendST21_w5 = 12 if id1 == 20753

replace weekendST21_w5 = 12 if id1 == 30345

replace weekendST11_w6 = 1 if id1 == 30486

replace weekendST11_w9 = 0 if id1 == 10396

replace weekdayST11_w9 = 22 if id1 == 20436
replace weekendST11_w9 = 22 if id1 == 20436

replace weekdayST11_w9 = 23 if id1 == 30432

replace weekendST11_w12 = 0 if id1 == 10185

replace weekdayST11_w12 = 23 if id1 == 10345
replace weekendST11_w12 = 23 if id1 == 10345

replace weekdayST11_w12 = 22 if id1 == 30396
replace weekendST11_w12 = 23 if id1 == 30396

replace weekdayST21_w12 = 13 if id1 == 30602
replace weekendST21_w12 = 13 if id1 == 30602

* weekdayST weekendST
program drop _all
program define ST_P

mvdecode `1' `2' `3' `4', mv(91/99)
generate `5'ST1`6' = `1' * 60 + `2'
generate `5'ST2`6' = `3' * 60 + `4'

generate `5'ST`6' = `5'ST2`6' - `5'ST1`6'
replace `5'ST`6' = `5'ST`6' + 1440 if `5'ST`6' < 0
replace `5'ST`6' = `5'ST`6' / 60
end

foreach y in "weekday" "weekend"{
	foreach x of num 2 3 5 6 9 12{
		ST_P `y'ST11_w`x' `y'ST12_w`x' `y'ST21_w`x' `y'ST22_w`x' `y' _w`x'
}

}

/*****************************************
*               檢誤睡眠                 *
******************************************/
/*
檢誤規則
1. 先將列出有問題的，檢查是否可能為24小時制問題
2. 若是上述問題，直接更改時間
3. 若不是且無法判別，且平日/假日其一為正常，則將其改為正常的平日/假日時間
4. 若不是且無法判別，且平日/假日兩者皆不太正常，刪除樣本

* 檢誤睡太少(<4)
foreach x of num 2 3 5 6 9 12{
	list id1 ///
	weekdayST_w`x' weekdayST11_w`x'  weekdayST21_w`x'  ///
	weekendST_w`x' weekendST11_w`x'  weekendST21_w`x'  ///
	if ///
	weekdayST_w`x' < 3 | weekendST_w`x' < 3
}

* 檢誤睡太多(>15)
foreach x of num 2 3 5 6 9 12{
	list id1 ///
	weekdayST_w`x' weekdayST11_w`x'  weekdayST21_w`x'  ///
	weekendST_w`x' weekendST11_w`x'  weekendST21_w`x'  ///
	if ///
	  (weekdayST_w`x' > 15 & weekdayST_w`x' != .) ///
    | (weekendST_w`x' > 15 & weekendST_w`x' != .)
}

*/

* 檢誤步驟3，在此更改
foreach x of num 2 3 5 6 9 12 {
	replace weekendST_w`x' = weekdayST_w`x' ///
		if weekendST_w`x' < 3

	replace weekdayST_w`x' = weekendST_w`x' ///
		if weekdayST_w`x' < 3 
}


/*****************************************
*               其他睡眠                 *
******************************************/

* TST
foreach x of num 2 3 5 6 9 12{
	gen TST_w`x' = ((weekendST_w`x' * 5) + weekdayST_w`x') / 7
	lab var TST_w`x' "整體睡眠_w`x'(加權))"
}

* TST3
foreach x of num 2 3 5 6 9 12{
	gen TST3_w`x' = .
	replace TST3_w`x' = 1 if TST_w`x' < 6
	replace TST3_w`x' = 2 if TST_w`x' >= 6 & TST_w`x' <= 8
	replace TST3_w`x' = 3 if TST_w`x' > 8 & TST_w`x' != .
}

* SD
foreach x of num 2 3 5 6 9 12{
	gen SD_w`x' = 0
	replace SD_w`x' = 1 if TST_w`x' < 8
	replace SD_w`x' = . if TST_w`x' == .
	lab var SD_w`x' "睡眠不足_w`x' (<8)"
}

* WndD
foreach x of num 2 3 5 6 9 12{
	gen WndD_w`x' = weekendST_w`x' - weekdayST_w`x'
	lab var WndD_w`x' "假日-平日睡眠_w`x'"
}


/*****************************************
*               睡眠問題                 *
******************************************/

/*************************************************************************

lookfor 失眠
di r(varlist)
bs615007_w2 cs919007_w3 es122000_w5 fs609007_w6 is059007_w9 m3s076070_w12

lookfor 不安穩
di r(varlist)
bs615013_w2 cs919013_w3 fs609013_w6 is059013_w9 m3s076130_w12

lookfor 一大早
di r(varlist)
bs615012_w2 cs919012_w3 fs609012_w6 is059012_w9 m3s076120_w12
*************************************************************************/

global sleepP0_w2 "bs615007_w2 bs615012_w2 bs615013_w2"
global sleepP0_w3 "cs919007_w3 cs919012_w3 cs919013_w3"
global sleepP0_w5 "es122000_w5"
global sleepP0_w6 "fs609007_w6 fs609012_w6 fs609013_w6"
global sleepP0_w9 "is059007_w9 is059012_w9 is059013_w9"
global sleepP0_w12 "m3s076070_w12 m3s076120_w12 m3s076130_w12"

tabm $sleepP0_w2 $sleepP0_w3 $sleepP0_w5 $sleepP0_w6 ///
     $sleepP0_w9 $sleepP0_w12 , m

foreach x of var $sleepP0_w2 $sleepP0_w3 $sleepP0_w5 $sleepP0_w6 ///
				 $sleepP0_w9 $sleepP0_w12 {
	mvdecode `x', mv(6/9)
}

foreach x of num 2 3 5 6 9 12{
	egen sleepP_w`x' =  rmean( ${sleepP0_w`x'} ) 
}

