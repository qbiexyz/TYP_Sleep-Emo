* Last Updated: 2024. 10. 15
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

est clear


foreach x of num 1/6 {
	clear
	* 若是亂碼
	cd "C:\Dropbox\學習\碩士\碩論\TYP_Sleep-Emo\10 data\j1w`x's"
	unicode encoding set Big5
	unicode translate "j1w`x's.dta" , invalid(ignore) transutf8 nodata
	*刪除資料夾
	! rmdir /s/q "bak.stunicode"
}

foreach x of num 2011 2014 2017 {
	clear
	* 若是亂碼
	cd "C:\Dropbox\學習\碩士\碩論\TYP_Sleep-Emo\10 data\TYP`x'"
	unicode encoding set Big5
	unicode translate "TYP`x'.dta" , invalid(ignore) transutf8 nodata
	*刪除資料夾
	! rmdir /s/q "bak.stunicode"
}

