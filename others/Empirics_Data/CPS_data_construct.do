clear
clear matrix
clear mata
set more off

global data "C:\Users\Minsu Chang\Dropbox\Heterogeneity\Data\CPS\CPS_data\"

foreach year in 89 90 91 92 93 {
	foreach quarter in 1 2 3 4 {
	
		local d_year = "19`year'"

	if `quarter' == 1 { 
		use "${data}\`d_year'\cpsbmar`year'.dta", clear
		gen period = `d_year'
		keep period a_werntp a_explf
		rename a_explf employdum /* 1: employed, 2: unemployed */
		rename a_werntp earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
		egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q1.dta", replace
	}
	else if `quarter' == 2 {
 		use "${data}\`d_year'\cpsbjun`year'.dta", clear
		gen period = `d_year'+0.25
		keep period a_werntp a_explf
		rename a_explf employdum /* 1: employed, 2: unemployed */
		rename a_werntp earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q2.dta", replace
	}	
	else if `quarter' == 3 {
 		use "${data}\`d_year'\cpsbsep`year'.dta", clear
		gen period = `d_year'+0.5
		keep period a_werntp a_explf
		rename a_explf employdum /* 1: employed, 2: unemployed */
		rename a_werntp earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q3.dta", replace

	}
	else {
 		use "${data}\`d_year'\cpsbdec`year'.dta", clear
		gen period = `d_year'+0.75
		keep period a_werntp a_explf
		rename a_explf employdum /* 1: employed, 2: unemployed */
		rename a_werntp earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q4.dta", replace
	}
 


	}
}


foreach year in 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 {
	foreach quarter in 1 2 3 4 {
	
	if `year' >= 20  {
		local d_year = "19`year'"
	}
	else{
		local d_year = "20`year'"
	}

	if `quarter' == 1 { 
		use "${data}\`d_year'\cpsbmar`year'.dta", clear
		gen period = `d_year'
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q1.dta", replace
	}
	else if `quarter' == 2 {
 		use "${data}\`d_year'\cpsbjun`year'.dta", clear
		gen period = `d_year'+0.25
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
	    replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings		
		capture save "${data}\`d_year'\raw`year'q2.dta", replace
	}	
	else if `quarter' == 3 {
 		use "${data}\`d_year'\cpsbsep`year'.dta", clear
		gen period = `d_year'+0.5
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
	    replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q3.dta", replace

	}
	else {
 		use "${data}\`d_year'\cpsbdec`year'.dta", clear
		gen period = `d_year'+0.75
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q4.dta", replace
	}
 

	}
}


foreach year in 17 {
	foreach quarter in 1 2 3 {

		local d_year = "20`year'"
	
	if `quarter' == 1 { 
		use "${data}\`d_year'\cpsbmar`year'.dta", clear
		gen period = `d_year'
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q1.dta", replace
	}
	else if `quarter' == 2 {
 		use "${data}\`d_year'\cpsbjun`year'.dta", clear
		gen period = `d_year'+0.25
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
	    replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings		
		capture save "${data}\`d_year'\raw`year'q2.dta", replace
	}	
	else if `quarter' == 3 {
 		use "${data}\`d_year'\cpsbsep`year'.dta", clear
		gen period = `d_year'+0.5
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q3.dta", replace

	}
	else {
 		use "${data}\`d_year'\cpsbdec`year'.dta", clear
		gen period = `d_year'+0.75
		keep period prernwa prexplf
		rename prexplf employdum /* 1: employed, 2: unemployed */
		rename prernwa earnings
		drop if employdum == -1
		replace employdum = 0 if employdum == 2
		replace employdum = 1 if earnings > 0 & earnings ~= .
		egen fraczero = mean(employdum)
		replace fraczero = 1-fraczero
		replace earnings = 0 if employdum == 0 & earnings == .
		drop if earnings == .  /* fraczero is based on employdum. There are less missing value for employdum */
	 	egen fraczero2 = mean(employdum)
		replace fraczero2 = 1-fraczero2
	 	sort earnings
		capture save "${data}\`d_year'\raw`year'q4.dta", replace
	}
 
	}
}



clear

foreach year in 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 {
	foreach quarter in 1 2 3 4 {
	    if `year' >= 20  {
			local d_year = "19`year'"
		}
		else{
			local d_year = "20`year'"
		}

	capture noisily append using "${data}\`d_year'\raw`year'q`quarter'.dta"
	}
}

foreach quarter in 1 2 3 {
	capture noisily append using "${data}\2017\raw17q`quarter'.dta"
	}

	

sort period 

drop if employdum == 0

outsheet period earnings using "C:\Users\Minsu Chang\Dropbox\Heterogeneity\Data\CPS\earnings_nodetrend.txt", replace  /*(csv file cannot load all the observations)*/

