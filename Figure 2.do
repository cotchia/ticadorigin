 


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
 
*keep if donor=="Japan"
keep if inlist(donor,"Japan", "Korea", "Non-DAC Countries, Total", "Turkey" , "United Arab Emirates", "Other Non-DAC Countries") 

keep if inlist(aidtype, "ODA: Total Net", "Technical Cooperation", "Grants, Total")
 

encode aidtype,gen(aid)
drop aidtype
 
 

gen nid=(_n)
reshape wide value, i( nid) j(aid )



recode value1 value2 value3 (.=0)
 
ren value1 grants
ren value2 oda
ren value3 tech
lab var grants "Grants, Total"
lab var oda "ODA: Total Net"
lab var tech "Technical Cooperation"


merge m:m recipient using "region_ODA.dta"


 


encode continent,gen(region)
collapse (sum)  grants oda tech, by(region year donor)
ta region,mis
ta year,mis
drop if year==.
 
 
encode donor, gen(ndonor)
 
 

recode grants oda tech (.=0)


bysort region ndonor (year): gen cum_grants = sum( grants )  
bysort region ndonor (year): gen cum_oda = sum( oda )  
bysort region ndonor (year): gen cum_tech = sum( tech )

 
 
 
 
twoway (line cum_grants year if region==1 &  ndonor==1, connect(direct)) (line cum_grants year if region==1  &   ndonor==2, lpattern(dash)) (line cum_grants year if region==1 &  ndonor==3, lpattern(vshortdash)) (line cum_grants year if region==1 &  ndonor==4, lpattern(longdash)), ytitle("Grants, cumulative") ytitle(, size(small)) ylabel(, labsize(small)) xtitle("") xlabel(1960(10)2020, labsize(small)) subtitle("b. Grants") legend(order(1 "Japan" 2 "Korea" 3 "Non-DAC Countries" 4 "United Arab Emirates") rows(1) position(6))

graph save grants02.gph, replace


twoway (line cum_oda year if region==1 &  ndonor==1, connect(direct)) (line cum_oda year if region==1  &   ndonor==2, lpattern(dash)) (line cum_oda year if region==1 &  ndonor==3, lpattern(vshortdash)) (line cum_oda year if region==1 &  ndonor==4, lpattern(longdash)), ytitle("ODA, cumulative") ytitle(, size(small)) ylabel(, labsize(small)) xtitle("") xlabel(1960(10)2020, labsize(small)) subtitle("a. ODA") legend(order(1 "Japan" 2 "Korea" 3 "Non-DAC Countries" 4 "United Arab Emirates") rows(1) position(6))
	graph save oda02.gph, replace
	
 

twoway (line cum_tech  year if region==1 &  ndonor==1,) ///
(line cum_tech  year if region==1  &   ndonor==2, yaxis(2) lpattern(dash)) ///
(line cum_tech  year if region==1 &  ndonor==3, yaxis(2) lpattern(vshortdash)) ///
(line cum_tech  year if region==1 &  ndonor==4, yaxis(2) lpattern(longdash)) ///
, ytitle("Technical assistance, cumulative") ytitle(, size(small)) ///
ylabel(, labsize(small)) ytitle("Technical assistance, cumulative", axis(2)) ///
ytitle(, size(small) axis(2)) ylabel(, labsize(small) axis(2)) ///
xtitle("") xlabel(1960(10)2020, labsize(small)) ///
subtitle("c. Technical assistance") ///
legend(order(1 "Japan" 2 "Korea" 3 "Non-DAC Countries" 4 "United Arab Emirates") rows(1) position(6))
graph save tech02.gph, replace
 	
graph combine "oda02.gph" "grants02.gph" "tech02.gph", colfirst cols(1) iscale(*0.8) imargin(tiny) scale(0.8) graphregion(margin(tiny) fcolor(white) ifcolor(white)) plotregion(margin(tiny) fcolor(white) ifcolor(white))
 