scriptName "BwS_fn_loop";

private ["_config"];
_config = [] execVM "scripts\invasions\config.sqf";
waitUntil {scriptDone _config}; 

// peuplement du serveur
//if (BwS_var_casernes) then {for "_i" from 0 to 10+random(3) do {	[] spawn BwS_fn_caserne; sleep 0.01;};};

//if (BwS_var_usines) then {for "_i" from 0 to 10+random(3) do {	[] spawn BwS_fn_usines; sleep 0.01;};};

BwS_var_positions_villes = [];
_centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_locations = nearestLocations [_centerMap, ["NameCityCapital", "NameCity", "NameVillage"], 30000];
{BwS_var_positions_villes pushBack [(locationPosition _x) select 0, (locationPosition _x) select 1]} forEach _locations;

execvm "scripts\invasions\head.sqf"

