

import delimited "TABLE2A_12062023220830809.csv", clear 

drop if amounttype=="Current Prices"
 
drop recipient
ren v2 recipient
drop donor
ren v4 donor
ta part
drop part v6
 
drop aidtype
ren v8 aidtype
 
drop datatype
drop amounttype

 
drop time unitcode unit powercodecode powercode referenceperiodcode referenceperiod flagcodes flags
 
keep if donor=="Japan"
 

keep if inlist(aidtype, "ODA: Total Net", "Technical Cooperation", "Grants, Total")
 

encode aidtype,gen(aid)
drop aidtype



collapse (sum) value, by( recipient year aid )
 
egen id=group( recipient year), label

reshape wide value, i(id) j(aid)
recode value1 value2 value3 (.=0)



ren value1 grants
ren value2 oda
ren value3 tech
lab var grants "Grants, Total"
lab var oda "ODA: Total Net"
lab var tech "Technical Cooperation"



recode year (1960/1969=1)   (1970/1979=2)  (1980/1989=3)  (1990/1999=4)  (2000/2009=5)  (2010/2020=6) (else=.)  , gen(nyear)
drop if nyear==.


merge m:m recipient using "region_ODA.dta"


 


encode continent,gen(region)

keep if region==1

 egen total=rsum( grants oda tech)
table ( recipient ) ( nyear ) (), statistic(sum total )

 
collect style putdocx, layout(autofitcontents)
collect export table2.docx, replace
