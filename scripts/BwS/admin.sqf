execVM "scripts\BwS\construction_kick.sqf";
BwS_MENU_ADMIN = [
	["Menu admin", true],
	//["Créer une zone de combat",	[0], "", -5, [["expression", "execVM ""scripts\invasions\nouvelleZone.sqf"""]], "1", "1"],
	["Téléportafion", 				[2], "", -5, [["expression", "onMapSingleClick {vehicle player setPos _pos; onMapSingleClick """"}"]], "1", "1"],
	["Téléporter à cursorTarget", 	[3], "", -5, [["expression", "player setPos _pos;"]], "1", "1"],
	["Punir cursorTarget", 			[4], "", -5, [["expression", "cursorTarget setPos [((getPos cursorTarget) select 0),((getPos cursorTarget) select 1),2000]"]], "1", "1"],
	["Afficher les IA", 			[5], "", -5, [["expression", "execVM ""scripts\forcages\forcageAfficher.sqf"""]], "1", "1"],
	["Afficher les mines", 			[6], "", -5, [["expression", "execVM ""scripts\forcages\forcageMines.sqf"""]], "1", "1"],
	["God mode on/off", 			[7], "", -5, [["expression", "player allowDamage !BwS_var_dommages_autorises; BwS_var_dommages_autorises = !BwS_var_dommages_autorises"]], "1", "1"],
	["Afficher casernes/usines", 	[8], "", -5, [["expression", "execVM ""scripts\forcages\forcageAfficherCasernesUsines.sqf"""]], "1", "1"],
	["DeleteVehicle cursorTarget", 	[9], "", -5, [["expression", "deleteVehicle cursorTarget"]], "1", "1"],
	["cursorTarget setDamage 0",   [10], "", -5, [["expression", "cursorTarget setDamage 0"]], "1", "1"],
	["kick",   					   [11], "#USER:BwS_MENU_ADMIN_KICK", -5, [["expression", "execVM ""scripts\BwS\construction_kick.sqf"""]], "1", "1"],
	["dump unités", 			   [12], "", -5, [["expression", "execVM ""scripts\forcages\dump.sqf"""]], "1", "1"],
	["intro",   				   [0], "", -5, [["expression", "execVM ""intro.sqf"""]], "1", "1"]
];
