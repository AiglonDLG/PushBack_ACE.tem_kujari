/*
*	menus.sqf
*	[B.w.S] SoP
*	menus.sqf du script helios
*	23/7/2017
*/

BwS_HELIOS_MAIN_MENU = 
[
	["CONFIGURATION", true],
	["Ajouter un WP", [2], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_helios_fn_addWP"]], "1", "1"],
	["Supprimer un WP", [3], "#USER:BwS_HELIOS_MENU_SUPP_WP", -5, [["expression", ""]], "1", "1"],
	["ZOOM +", 			[4], "", -5, [["expression", "BwS_helios_var_alt = BwS_helios_var_alt-0.1; publicVariable ""BwS_helios_var_alt"""]], "1", "1"],
	["ZOOM -", 			[5], "", -5, [["expression", "BwS_helios_var_alt = BwS_helios_var_alt+0.1; publicVariable ""BwS_helios_var_alt"""]], "1", "1"],
	["VITESSE +", 		[6], "", -5, [["expression", "BwS_helios_var_vit = (BwS_helios_var_vit+10 min 100); publicVariable ""BwS_helios_var_vit"""]], "1", "1"],
	["VITESSE -", 		[7], "", -5, [["expression", "BwS_helios_var_vit = (BwS_helios_var_vit-10 max 10); publicVariable ""BwS_helios_var_vit"""]], "1", "1"]
];

BwS_HELIOS_MENU_ECRAN =
[
	["CFG ECRAN", true],
	["NORMAL", 			[2], "", -5, [["expression", "[cursorObject, 0] call BwS_helios_fn_vision"]], "1", "1"],
	["THERMIQUE", 		[3], "", -5, [["expression", "[cursorObject, 2] call BwS_helios_fn_vision"]], "1", "1"],
	["NVG", 			[4], "", -5, [["expression", "[cursorObject, 1] call BwS_helios_fn_vision"]], "1", "1"],
	["THERMIQUE INV", 	[5], "", -5, [["expression", "[cursorObject, 7] call BwS_helios_fn_vision"]], "1", "1"],
	["ZOOM + (drone)", 	[6], "", -5, [["expression", "[cursorObject, ""+""] call BwS_helios_fn_zoom"]], "1", "1"],
	["ZOOM - (drone)", 	[7], "", -5, [["expression", "[cursorObject, ""-""] call BwS_helios_fn_zoom"]], "1", "1"],
	["CHOIX STREAM", 	[8], "#USER:BwS_HELIOS_MENU_CHOIX_STREAM", -5, [["expression", ""]], "1", "1"],
	["Desact. cams locl",[9], "", -5, [["expression", "BwS_helios_var_desactiver = true"]], "1", "1"],
	["Act. cams locl",[10], "", -5, [["expression", "BwS_helios_var_desactiver = false"]], "1", "1"]
];

