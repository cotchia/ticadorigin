 
use "ticadorigin.dta", clear

drop if year <=1966



***Table 3

itsa cum_oda , single treat(1) trperiod(1992;1997) replace  figure posttrend lag(2)

outreg2 using "Table3.xls", bdec(3) label se excel replace  

itsa cum_grants, single treat(1) trperiod(1992;1997) replace  figure posttrend lag(2)

outreg2 using "Table3.xls", bdec(3) label se excel append 


itsa cum_tech, single treat(1) trperiod(1992;1997) replace  figure posttrend lag(2)

outreg2 using "Table3.xls", bdec(3) label se excel append 