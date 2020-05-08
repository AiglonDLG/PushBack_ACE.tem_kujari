/*
*	armement.sqf
*	[B.w.S] SoP
*	Permet le choix de l'armement d'un aéronef
*	11/7/2017
*/

sleep 5; 
_pylons = "true" configClasses (configFile  >>  "CfgVehicles"  >>  typeOf (cursorObject)  >>  "Components"  >>  "TransportPylonsComponent" >> "pylons") apply {configName _x};

BwS_MENU_ARMEMENT = [
	["Choisir l'armement pour...", true]
];

{	
	_py = _x;
	_ammo_compatible = (nearestObject [position player, "Air"] ) GetCompatiblePylonMagazines _py;
	call compile ("BwS_MENU_ARMEMENT_"+_py+" = [["""+ _py +""", true]]");
	{
		call compile ("BwS_MENU_ARMEMENT_"+_py+" pushback "+str([getText(configfile >> "CfgMagazines" >> _x >> "displayName"), [_forEachIndex+2], "", -5, [["expression","cursorObject setPylonLoadOut ["+str(_py)+", "+str(_x)+", true, []]"]], "1", "1"])); 
	} forEach _ammo_compatible;	
	call compile ("BwS_MENU_ARMEMENT_"+_py+" pushBack "+str(["Vide", [0], "", -5, [["expression", "cursorObject setPylonLoadOut ["+str(_py)+", """", true, []]"]], "1", "1"]));
	BwS_MENU_ARMEMENT pushBack [_py, [0], "#USER:BwS_MENU_ARMEMENT_"+_py, -5, [["expression", ""]], "1", "1"],
} forEach _pylons;

showCommandingMenu "#USER:BwS_MENU_ARMEMENT";