

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


recode year (1960/1969=1) (1970/1979=2) (1980/1989=3) (1990/1999=4) (2000/2009=5) (2010/2019=6) (else=.),gen(nyear)
table ( recipient ) ( nyear ) (), statistic(total value )
