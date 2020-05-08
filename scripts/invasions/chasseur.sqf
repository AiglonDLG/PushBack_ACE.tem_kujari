scriptName "BwS_fn_chasseur";
["Un chasseur a ete spawn"] spawn BwS_fn_diag_log;

private ["_chasseur", "_cible", "_vehicles", "_type"];

// spawn un chasseur

_vehicles = ["O_Plane_CAS_02_F", "O_Heli_Attack_02_F"];

_type = selectRandom _vehicles;
	
_chasseur = createVehicle [_type, [-random 2000, -random 2000], [], 1000, "FLY"];
createVehicleCrew _chasseur;
// nul = [_chasseur] execVM "ARS\ARS_ia.sqf";	
_grp = group driver _chasseur;
_cible = (selectRandom allPlayers);
_wp = _grp addWaypoint [position _cible, 0];
_wp setWaypointType "DESTROY"; 
_wp waypointAttachVehicle _cible;
sleep 900;

if (alive _chasseur) then
{
	_chasseur move [-(random 3000),-(random 3000)];
};

sleep 900;

if (alive _chasseur) then
{
	_chasseur deleteVehicleCrew driver _chasseur;
	deleteVehicle _chasseur;
};