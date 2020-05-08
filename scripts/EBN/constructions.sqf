BwS_fn_construction_menus_marqueurs =
{
	BwS_marqueurs_EBN = allMapMarkers select {(["BwS_EBN_marqueur_", _x] call BIS_fnc_inString)};
	call BwS_fn_construction_menus_marqueurs_usines;
	call BwS_fn_construction_menus_marqueurs_casernes;
	call BwS_fn_construction_menus_marqueurs_camps;
	call BwS_fn_construction_menus_marqueurs_VHL;
	call BwS_fn_construction_menus_marqueurs_VEH;
	call BwS_fn_construction_menus_marqueurs_PAT;
	call BwS_fn_construction_menus_marqueurs_ART;
	call BwS_fn_construction_menus_marqueurs_EVASAN;
	call BwS_fn_construction_menus_marqueurs_groupes;
	call BwS_fn_construction_menus_marqueurs_OBS;
	call BwS_fn_construction_menus_marqueurs_GPS;
	call BwS_fn_construction_menus_marqueurs_OBJ;
	call BwS_fn_construction_menus_marqueurs_CLAIR;
	call BwS_fn_construction_menus_marqueurs_IED;
};

BwS_fn_construction_menus_marqueurs_usines =
{
	BwS_MENU_EBN_SUPPRESION_USINE = [["Suppression USINE", true]];
	{
		if ((["Usine", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_USINE pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_casernes =
{
	BwS_MENU_EBN_SUPPRESION_CASERNE = [["Suppression CASERNE", true]];
	{
		if ((["Caserne", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_CASERNE pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_camps =
{
	BwS_MENU_EBN_SUPPRESION_CAMP = [["Suppression CAMP", true]];
	{
		if ((["Camp", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_CAMP pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_VHL =
{
	BwS_MENU_EBN_SUPPRESION_VHL = [["Suppression VHL", true]];
	{
		if ((["VHL", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_VHL pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_pat =
{
	BwS_MENU_EBN_SUPPRESION_PAT = [["Suppression Patrouille", true]];
	{
		if ((["Pat", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_PAT pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_veh =
{
	BwS_MENU_EBN_SUPPRESION_VEH = [["Suppression Véhicule", true]];
	{
		if ((["Veh", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_VEH pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_groupes =
{
	BwS_MENU_EBN_SUPPRESION_GROUPE = [["Suppression Groupe", true]];
	{
		if ((["groupe", _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_GROUPE pushBack [markerText _x, [0], "", -5, [["expression", format ["%1 setMarkerAlpha 0", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_EVASAN =
{
	BwS_MENU_EBN_SUPPRESION_EVASAN = [["Suppression EVASAN", true]];
	{
		if ((["EVASAN", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_EVASAN pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_ART =
{
	BwS_MENU_EBN_SUPPRESION_ART = [["Suppression ART", true]];
	{
		if ((["ART", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_ART pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_OBS =
{
	BwS_MENU_EBN_SUPPRESION_OBS = [["Suppression OBS", true]];
	{
		if ((["OBS", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_OBS pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_OBJ =
{
	BwS_MENU_EBN_SUPPRESION_OBJ = [["Suppression OBJ", true]];
	{
		if ((["OBJ", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_OBJ pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_CLAIR =
{
	BwS_MENU_EBN_SUPPRESION_CLAIR = [["Suppression Clair", true]];
	{
		if ((["Clair", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_CLAIR pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_IED =
{
	BwS_MENU_EBN_SUPPRESION_IED = [["Suppression IED", true]];
	{
		if ((["IED", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_IED pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

BwS_fn_construction_menus_marqueurs_GPS =
{
	BwS_MENU_EBN_SUPPRESION_GPS = [["Suppression GPS", true]];
	{
		if ((["GPS", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_MENU_EBN_SUPPRESION_GPS pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_marqueurs_EBN;
};

