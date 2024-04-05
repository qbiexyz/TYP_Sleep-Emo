* Last Updated: 2024. 10. 15
* File name: []
* Data: 
* Subject: 

/*****************************
*                            *
*****************************/

est clear


foreach x of num 2 3 5 6 9 {
	clear
	* 若是亂碼
	cd "D:\Dropbox\學習\碩士\碩論\10 data\j1w`x's"
	unicode encoding set Big5
	unicode translate "j1w`x's.dta" , invalid(ignore) transutf8 nodata
	*刪除資料夾
	! rmdir /s/q "bak.stunicode"
}




