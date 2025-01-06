 
 use "ticadorigin.dta", clear

drop if year <=1965



***Table 4


itsa cum_oda ,  replace figure posttrend  prais rhotype(tscorr) vce(robust)  treat(1) trperiod(1992;1997)  contid(2 3 4 5 6)

outreg2 using "TableX03.xls", bdec(3) label se excel ///
adds("Durbin–Watson statistic (original)", `e(dw_0)', ///
"Durbin–Watson statistic (transformed)", `e(dw)' )  replace  




itsa cum_grants,  replace figure posttrend  prais rhotype(tscorr) vce(robust)  treat(1) trperiod(1992;1997)  contid(2 3 4 5 6)

outreg2 using "TableX03.xls", bdec(3) label se excel ///
adds("Durbin–Watson statistic (original)", `e(dw_0)', ///
"Durbin–Watson statistic (transformed)", `e(dw)' )  append 


itsa cum_tech ,  replace figure posttrend  prais rhotype(tscorr) vce(robust)  treat(1) trperiod(1992;1997)  contid(2 3 4 5 6)

outreg2 using "TableX03.xls", bdec(3) label se excel ///
adds("Durbin–Watson statistic (original)", `e(dw_0)', ///
"Durbin–Watson statistic (transformed)", `e(dw)' )  append 





global control fid  tot   

itsa cum_oda $control,  replace figure posttrend  prais rhotype(tscorr) vce(robust)  treat(1) trperiod(1992;1997)  contid(2 3 4 5 6)

outreg2 using "TableX03.xls", bdec(3) label se excel ///
adds("Durbin–Watson statistic (original)", `e(dw_0)', ///
"Durbin–Watson statistic (transformed)", `e(dw)' )  replace  




itsa cum_grants $control,  replace figure posttrend  prais rhotype(tscorr) vce(robust)  treat(1) trperiod(1992;1997)  contid(2 3 4 5 6)

outreg2 using "TableX03.xls", bdec(3) label se excel ///
adds("Durbin–Watson statistic (original)", `e(dw_0)', ///
"Durbin–Watson statistic (transformed)", `e(dw)' )  append 


itsa cum_tech $control,  replace figure posttrend  prais rhotype(tscorr) vce(robust)  treat(1) trperiod(1992;1997)  contid(2 3 4 5 6)

outreg2 using "TableX03.xls", bdec(3) label se excel ///
adds("Durbin–Watson statistic (original)", `e(dw_0)', ///
"Durbin–Watson statistic (transformed)", `e(dw)' )  append 