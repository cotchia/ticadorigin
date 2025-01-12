 
 
 
 use "ticadorigin.dta", clear
 
 streamplot oda year , by(region) smooth(6) palette(CET C7, reverse) ///
	title("a. ODA") xtitle("")  xlabel(1960(5)2021, labsize(vsmall)) /// ///
	ylabsize(1.8) lc(black) lw(0.04)  percent format(%3.2f) offset(0.2) ylabc(palette)
	graph save oda01.gph, replace
	
	streamplot grants year , by(region) smooth(6) palette(CET C7, reverse) ///
	title("b. Grants") xtitle("")  xlabel(1960(5)2021, labsize(vsmall)) /// ///
	ylabsize(1.8) lc(black) lw(0.04)  percent format(%3.2f) offset(0.2) ylabc(palette) 
	graph save grants01.gph, replace

	

	
	
 streamplot tech year , by(region) smooth(6) palette(CET C7, reverse) ///
	title("") xtitle("c. Technical assistance")  xlabel(1960(5)2021, labsize(vsmall)) /// ///
	ylabsize(1.8) lc(black) lw(0.04)  percent format(%3.2f) offset(0.2) ylabc(palette) ///
 
	graph save tech01.gph, replace
	
	
 
 


	
	
graph combine "oda01.gph" "grants01.gph" "tech01.gph", colfirst cols(1) iscale(*0.8) imargin(tiny) scale(0.8) graphregion(margin(tiny) fcolor(white) ifcolor(white)) plotregion(margin(tiny) fcolor(white) ifcolor(white))
