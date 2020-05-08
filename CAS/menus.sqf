/*
*	menus.sqf
*	[B.w.S] SoP
*	
*	24/10/2017
*/

BwS_CAS_MENU_REQUEST = [
	["CAS REQUEST", true],
	["Helico. d'attaque", 	[2], "", -5, [["expression", ""]], "1", "1"],
	["Avion", 				[3], "", -5, [["expression", ""]], "1", "1"],
	["Imagerie drone", 		[4], "", -5, [["expression", "[""drone""] spawn BwS_CAS_fn_request"]], "1", "1"],
	["QRF", 				[5], "", -5, [["expression", "[""QRF""] spawn BwS_CAS_fn_request"]], "1", "1"]
];