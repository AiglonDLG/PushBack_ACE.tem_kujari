scriptName "BwS_fn_motorizedPatrolTeam";
// Création d'un pick up armé et de son équipage
private ["_group", "_positionOnRoad", "_positionGroup"];

_positionOnRoad = _this select 0;
_center = _this select 1;

sleep 0.01;
_tab = ["I_G_Offroad_01_F","I_G_Offroad_01_armed_F","I_C_Van_01_transport_olive_F", "I_G_Offroad_01_AT_F", "I_C_Offroad_02_LMG_F", "I_C_Offroad_02_AT_F"];

_veh = createVehicle [(selectRandom _tab), _positionOnRoad, [], 20, "NONE"];
//_veh setVariable ["R3F_LOG_CF_depuis_usine", true, true];

createVehicleCrew _veh;
_group = group driver _veh;

_groupePassager = [[0,0,0], (_veh emptyPositions "cargo"), BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup;
{[_x] join _group; _x moveInCargo _veh;} forEach units _groupePassager;

BwS_var_unites_d_usine pushBack _group;
_group deleteGroupWhenEmpty true;

_positionGroup = position driver _veh;

{	[_x] spawn BwS_fn_gestion_radio;	} forEach crew _veh;

