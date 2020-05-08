/*
*	menus.sqf
*	[B.w.S] SoP
*	User menus for ARS script
*	23/12/2017
*/


BwS_ARS_MENU_MAIN = [
	["Menu principal", true],
	["Ciblage GPS", 			[2], "", -5, [["expression", "call BwS_ARS_fn_menu_ciblage_GPS"]], "1", "1"],
	["Réglages RADAR", 			[3], "", -5, [["expression", "call BwS_ARS_fn_menu_reglages_RDR"]], "1", "1"],
	["ECM", 					[4], "", -5, [["expression", "[vehicle player] spawn BwS_ARS_fn_demande_debut_ECM"]], "1", "1"],
	["Echo fantômes", 			[5], "", -5, [["expression", "[vehicle player] spawn BwS_ARS_fn_echo_fantome"]], "1", "1"],
	["Switch alarme ON/OFF", 	[6], "", -5, [["expression", "vehicle player setVariable [""BwS_ARS_var_alarme_off"", !(vehicle player getVariable [""BwS_ARS_var_alarme_off"", false]), true]"]], "1", "1"],
	["Switch tracking ON/OFF", 	[7], "", -5, [["expression", "vehicle player setVariable [""BwS_ARS_var_tracking"", !(vehicle player getVariable [""BwS_ARS_var_tracking"", false]), true]"]], "1", "1"]
	
];

BwS_ARS_fn_menu_ciblage_GPS = 
{
	BwS_ARS_MENU_CIBLAGE_GPS = [["Ciblage GPS", true]];

	_targets = allMapMarkers select {[(markerText _x) find "GPS TARGET"] call BwS_fn_toBool};

	{
		_fnc = { vehicle player setVariable ["BwS_ARS_GBU_var_cible", _this];

			_cible = markerPos (vehicle player getVariable ["BwS_ARS_GBU_var_cible", ""]);
			_dist = _cible distance vehicle player;
			
			if !(_cible isEqualTo [0,0,0]) then 
			{
				vehicle player vehicleChat format ["Ciblage %2 : RNG %1m", round(_dist), markerText (vehicle player getVariable ["BwS_ARS_GBU_var_cible", ""])];
			}; 
		};

		BwS_ARS_MENU_CIBLAGE_GPS pushback [format ["%1", markerText _x], [_forEachIndex+3], "", -5, [["expression", format ["""%1"" call %2", _x, _fnc]]], "1", "1"];
	} forEach _targets;

	BwS_ARS_MENU_CIBLAGE_GPS pushBack ["Pas de cible", [2], "", -5, [["expression", "vehicle player setVariable [""BwS_ARS_GBU_var_cible"", """"]"]], "1", "1"];

	0 spawn {showCommandingMenu "#USER:BwS_ARS_MENU_CIBLAGE_GPS"};
};