BwS_MENU_EBN_CHOIX_GROUPE =
[
	["Choix du groupe", true],
	["Alpha",			[2], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Alpha""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"],
	["Bravo",			[3], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Bravo""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"],
	["Charly",			[4], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Charly""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"],
	["Delta",			[5], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Delta""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"],
	["Echo",			[6], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Echo""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"],
	["Foxtrot",			[7], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Foxtrot""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"],
	["Hotel",			[8], "", -5, [["expression", "player setVariable [""BwS_groupe"", ""Hotel""]; hint format [""Vous êtes maintenant le groupe %1"", player getVariable ""BwS_groupe""];"]], "1", "1"]
];

BwS_MENU_EBN = [
	["EBN", true],
	["Choisir son groupe",			[2], "#USER:BwS_MENU_EBN_CHOIX_GROUPE", -5, [["expression", ""]], "1", "1"],
	["Marquer la carte",			[3], "#USER:BwS_MENU_EBN_MARQUAGE", -5, [["expression", ""]], "1", "1"],
	["Supprimer des marqueurs",		[4], "#USER:BwS_MENU_EBN_SUPPRESION", -5, [["expression", ""]], "1", "1"],
	["Logistique",					[5], "#USER:BwS_MENU_EBN_CFS", -5, [["expression", ""]], "1", "1"],
	["Aide Artillerie",				[6], "#USER:BwS_MENU_EBN_ART", -5, [["expression", ""]], "1", "1"]
];

BwS_MENU_EBN_ART = [
	["Aide à l'artillerie", true],
	["Calculs",						[2], "", -5, [["expression", "[] spawn BwS_EBN_fn_calculs_art"]], "1", "1"]
];

BwS_MENU_EBN_CFS = [
	["Logistique", true],
	["Demande EVASAN",			[2], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_EVASAN"]], "1", "1"],
	["Demande ART",				[3], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_ART"]], "1", "1"],
	["Marquer OBS",				[4], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_OBS"]], "1", "1"],
	["Marquer OBJ",				[5], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_OBJ"]], "1", "1"],
	["Marquer CLAIR",			[6], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_CLAIR"]], "1", "1"],
	["Marquer COORD GPS",		[7], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_GPS"]], "1", "1"],
	["Marquer Mine/IED",		[8], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_IED"]], "1", "1"]
];

BwS_MENU_EBN_SUPPRESION = [
	["Suppression", true],
	["Marqueurs classiques",	[2], "#USER:BwS_MENU_EBN_SUPPRESION_CLASSIQUE", -5, [["expression", ""]], "1", "1"],
	["Marqueurs logistique",	[3], "#USER:BwS_MENU_EBN_SUPPRESION_LOGISTIQUE", -5, [["expression", ""]], "1", "1"]
];

BwS_MENU_EBN_SUPPRESION_LOGISTIQUE = [
	["Marqueurs Logistique", true],
	["Supprimer EVASAN",				[2], "#USER:BwS_MENU_EBN_SUPPRESION_EVASAN", -5, [["expression", ""]], "1", "1"],
	["Supprimer ART",					[3], "#USER:BwS_MENU_EBN_SUPPRESION_ART", -5, [["expression", ""]], "1", "1"],
	["Supprimer OBS",					[4], "#USER:BwS_MENU_EBN_SUPPRESION_OBS", -5, [["expression", ""]], "1", "1"],
	["Supprimer GPS",					[5], "#USER:BwS_MENU_EBN_SUPPRESION_GPS", -5, [["expression", ""]], "1", "1"],
	["Supprimer OBJ",					[6], "#USER:BwS_MENU_EBN_SUPPRESION_OBJ", -5, [["expression", ""]], "1", "1"],
	["Supprimer CLAIR",					[7], "#USER:BwS_MENU_EBN_SUPPRESION_Clair", -5, [["expression", ""]], "1", "1"],
	["Supprimer Mine/IED",				[8], "#USER:BwS_MENU_EBN_SUPPRESION_IED", -5, [["expression", ""]], "1", "1"]
];

BwS_MENU_EBN_SUPPRESION_CLASSIQUE = [
	["Marqueurs classiques", true],
	["Supprimer une caserne",			[2], "#USER:BwS_MENU_EBN_SUPPRESION_CASERNE", -5, [["expression", ""]], "1", "1"],
	["Supprimer une usine",				[3], "#USER:BwS_MENU_EBN_SUPPRESION_USINE", -5, [["expression", ""]], "1", "1"],
	["Supprimer un camp",				[4], "#USER:BwS_MENU_EBN_SUPPRESION_CAMP", -5, [["expression", ""]], "1", "1"],
	["Supprimer un VHL à recup",		[5], "#USER:BwS_MENU_EBN_SUPPRESION_VHL", -5, [["expression", ""]], "1", "1"],
	["Supprimer une patrouille",		[6], "#USER:BwS_MENU_EBN_SUPPRESION_PAT", -5, [["expression", ""]], "1", "1"],
	["Supprimer un véhicule",			[7], "#USER:BwS_MENU_EBN_SUPPRESION_VEH", -5, [["expression", ""]], "1", "1"],
	["Supprimer un marqueur groupe",	[8], "#USER:BwS_MENU_EBN_SUPPRESION_GROUPE", -5, [["expression", ""]], "1", "1"]
];

BwS_MENU_EBN_MARQUAGE = [
	["Marquer la carte", true],
	["Marquer sa position",			[2], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_sa_position"]], "1", "1"],
	["Marquer une menace pédestre",	[3], "#USER:BwS_MENU_EBN_PAT", -5, [["expression", ""]], "1", "1"],
	["Marquer une menace véhiculée",[4], "#USER:BwS_MENU_EBN_VEH", -5, [["expression", ""]], "1", "1"],
	["Marquer un véhicule perdu",	[5], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_VHL"]], "1", "1"],
	["Marquer une usine",			[6], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_usine"]], "1", "1"],
	["Marquer une caserne",			[7], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_caserne"]], "1", "1"],
	["Marquer un camp",				[8], "", -5, [["expression", "hint ""Cliquez sur la carte""; call BwS_EBN_fn_marquer_camp"]], "1", "1"]
];

BwS_MENU_EBN_PAT = [
	["Nombre de pax", true]
];

for "_i" from 1 to 10 do
{
	BwS_MENU_EBN_PAT pushBack [format ["%1 pax", _i], [_i+1], "", -5, [["expression", format ["hint ""Cliquez sur la carte""; [%1] call BwS_EBN_fn_marquer_pedestre", _i]]], "1", "1"];
};

BwS_MENU_EBN_VEH = [
	["Type de véhicule", true]
];

{
	BwS_MENU_EBN_VEH pushBack [_x, [_forEachIndex+2], "", -5, [["expression", format ["hint ""Cliquez sur la carte""; [%1] call BwS_EBN_fn_marquer_vehicule", str _x]]], "1", "1"];
} forEach BwS_EBN_types_de_vehicules_ennemis;