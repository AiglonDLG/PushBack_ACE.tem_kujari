
scriptName "BwS_fn_peupler";
_positionCentreDuMonde = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_center = _this select 0;
BwS_var_taille_zone = 20000;

/*_zone_op = format ["zone_op_%1", random 10000];
createMarker [_zone_op, _center];
_zone_op setMarkerShape "ELLIPSE";
_zone_op setMarkerBrush "Border";
_zone_op setMarkerSize [BwS_var_taille_zone/2, BwS_var_taille_zone/2];*/

BwS_fn_add_credit =
{
	private ["_credits", "_nombre", "_usine"];
	_usine = _this select 0;
	_nombre = _this select 1;
	_credits = _usine getVariable ["R3F_LOG_CF_credits", 100000];
	_credits = _credits + _nombre;
	_usine setVariable ["R3F_LOG_CF_credits", _credits, true];
};

BwS_fn_random_pos = 
{
	_centre = _this;
	_posX = (_centre select 0) - (BwS_var_taille_zone/2) + random (BwS_var_taille_zone);
	_posY = (_centre select 1) - (BwS_var_taille_zone/2) + random (BwS_var_taille_zone);
	[_posX, _posY]
};

BwS_fn_creer_patrouille = 
{
	waitUntil {count BwS_var_casernes > 0};
	_centre = position (selectRandom BwS_var_casernes);
	_posX = _centre select 0;
	_posY = _centre select 1;
	if (({(_x distance _centre) <= 1000} count allPlayers) == 0) then 
	{
		if (random 100 < 75) then
		{

			_g = [[_posX, _posY], 3+round(random(4)), BwS_var_side_ennemie, BwS_var_side_ennemie, "CAN_COLLIDE"] call BwS_fn_spawnGroup;
			_g deleteGroupWhenEmpty true; 
		}
		else
		{
			[position (selectRandom (_centre nearRoads 100))] spawn BwS_fn_pickups;
		};
	};
};

// artillerie
for "_i" from 0 to round random(2) do
{
	_posX = (_center select 0) - (BwS_var_taille_zone/2) + random (BwS_var_taille_zone);
	_posY = (_center select 1) - (BwS_var_taille_zone/2) + random (BwS_var_taille_zone);
	[[_posX, _posY, 0]] spawn BwS_fn_mortier;
};

	// de toute manière
// homed dans les maisons 
BwS_var_casernes = [];
BwS_var_usines = (_center) nearObjects ["Land_i_Garage_V1_F", (BwS_var_taille_zone/2)];
_maisons = (_center) nearObjects ["House", (BwS_var_taille_zone/2)];
BwS_var_casernes = _maisons;
//{
//	[position _x, "hd_dot", "ColorBLUFOR", "", 500] spawn BwS_EBN_fn_placer_marqueur;
//} forEach _maisons;

_maisons = _maisons call BIS_fnc_arrayShuffle;
_nombreMaisons = count _maisons;

if (_nombreMaisons > 0) then 
{
	_maisons resize ((floor(0.01*_nombreMaisons) max 5) min 50);
	//systemChat format ["%1 maisons, %2 choisies", _nombreMaisons, count _maisons];
	_nombreMaisons = (count _maisons);

	// spawner des homed et des mines en proportion
	if (_nombreMaisons > 0) then 
	{	
		{
			if ((count ([_x] call BIS_fnc_buildingPositions) > 0) && ((_x distance (markerPos "PC")) > 2500)) then 
			{
				BwS_var_casernes pushBackUnique _x;
				_pos = (selectRandom ([_x] call BIS_fnc_buildingPositions));
				if ((_pos select 0) != 0) then 
				{
					//_groupHomed = createGroup BwS_var_side_ennemie;
					//BwS_var_groupes_a_exclure pushBackUnique _groupHomed;
					//"I_C_Soldier_Para_5_F" createUnit [_pos, _groupHomed];
					_pos spawn 
					{
						_pos = _this;

						while {(count (allPlayers select {(_x distance _pos) < 2000})) == 0} do
						{					
							sleep 1;
						};

						diag_log "Spawn homed";
						_groupHomed = [_pos, 1, BwS_var_side_ennemie, BwS_var_side_ennemie, "CAN_COLLIDE"] call BwS_fn_spawnGroup;
						BwS_var_groupes_a_exclure pushBackUnique _groupHomed;
						_groupHomed setBehaviour "STEALTH";
						_unit = (units _groupHomed) select 0;
						BwS_var_homed pushBack _unit;
						[_unit] spawn BwS_fn_gestion_radio;
						_unit setpos [(position _unit select 0),
									  (position _unit select 1),
									  (((position _unit) select 2) + 1.2)];
						_unit spawn BwS_fn_gestion_homed;
					};
				};
			};
		} forEach _maisons;
		publicVariable "BwS_var_homed";
	};
};

for "_i" from 0 to (1+round(random(2))) do
{
	[selectRandom ["petit", "moyen", "grand"], _center call BwS_fn_random_pos] spawn BwS_fn_camp;
};

sleep 10;

_suicideBombers = (allUnits-allPlayers) select {if (random 100 < 10) then {true} else {false}};
{
	_unit = _x;
	_unit setVariable ["BwS_IED_est_un_IED", true, true];
	_explosif1 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
	_explosif1 attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis"];
	_explosif1 setVectorDirAndUp [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ];
	_explosif2 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
	_explosif2 attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
	_explosif2 setVectorDirAndUp [ [1, 0, 0], [0, 1, 0] ];
	_explosif3 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
	_explosif3 attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis"];
	_explosif3 setVectorDirAndUp [ [0.5, -0.5, 0], [0.5, 0.5, 0] ];
} forEach _suicideBombers;

//_fob = (_this select 2);
BwS_var_pat_patrouilles = [];
BwS_var_pat_attaquants = [];
BwS_var_TIC = [];
//BwS_var_pat_en_mouvement = [];

while {true} do
{
	_allPatrols = allGroups select {side _x == BwS_var_side_ennemie && (count units _x) > 1};

	//BwS_var_pat_en_mouvement = BwS_var_pat_en_mouvement - [grpNull];
	BwS_var_pat_attaquants = BwS_var_pat_attaquants - [grpNull]/* - BwS_var_pat_en_mouvement*/;
	BwS_var_pat_patrouilles = BwS_var_pat_patrouilles - [grpNull];
	BwS_var_TIC = [];

	// si pas assez de patrouilles on en fait spawn
	if (count _allPatrols < 12) then
	{
		for "_i" from 0 to round(random 2) do
		{
			0 spawn BwS_fn_creer_patrouille;
		}; 
	};
	
	// s'il n'y a pas de joueurs chez les IA
	if ((count (allPlayers select {side _x == BwS_var_side_ennemie})) == 0) then
	{
		// pour chaque patrouille
		{
			// si pas de role
			if !(_x getVariable ["BwS_pat_role", false]) then
			{
				// répartition parmi les attaquants ou les patrouilleurs
				if (count BwS_var_pat_patrouilles < count BwS_var_pat_attaquants) then
				{
					//BwS_var_pat_patrouilles pushBack _x;
					BwS_var_pat_attaquants pushBack _x;
					_x setVariable ["BwS_pat_role", true];
				}
				else
				{
					BwS_var_pat_attaquants pushBack _x;
					_x setVariable ["BwS_pat_role", true];
				};
			};
		} forEach _allPatrols;
		
		// si des joueurs sont présents
		if (count allPlayers > 0) then
		{		
			// on détermine les pax qui sont en Troop In Contact
			BwS_var_TIC = allUnits select {
				(side _x == BwS_var_side_ennemie) &&
				(((behaviour _x) isEqualTo "COMBAT") || (_x getVariable ["BwS_var_is_TIC", false]))
			};

			// s'il y en a
			if (count BwS_var_TIC > 0) then
			{
				// appel de renforts parmi les patrouilles dédiées
				{
					_x move position selectRandom(BwS_var_TIC);
					[_x, (currentWaypoint _x)] setWaypointType "SAD";
					_x setSpeedMode "FULL";
				} forEach BwS_var_pat_attaquants;

				// pour chaque soldat en TIC
				{
					_soldat = _x;
					// si sa variable TIC n'est pas bonne on la met à jour
					if !(_soldat getVariable ["BwS_var_is_TIC", false]) then 
					{
						_soldat setVariable ["BwS_var_is_TIC", true];
						_soldat setVariable ["BwS_var_debut_TIC", serverTime];
					}
					// sinon s'il est en TIC, on regarde depuis quand
					else 
					{	
						// si il est en TIC depuis plus d'un certain temps, il repasse en stade normal 
						// ça évite de se retrouver avec toutes les IA de la carte à un endroit 
						if ((serverTime - (_soldat getVariable ["BwS_var_debut_TIC", 0])) > 300) then
						{
							(group _soldat) setBehaviour "AWARE";
							_soldat setVariable ["BwS_var_is_TIC", false];
						};
					};
				} forEach BwS_var_TIC;
			} 
			// sinon, si personne au contact, on fait patrouiller les patrouilles dédiées à la QRF
			else 
			{
				// random pat
				{
					if (unitReady leader _x) then 
					{
						_x move [random(20500), random(20500)];
					};
				} forEach BwS_var_pat_attaquants;
			};
		};
	};
	
	// un peu de reward quand même pour renflouer les caisses
	[usine_us, 50] call BwS_fn_add_credit;
	[conteneur, 5] call BwS_fn_add_credit;
	[conteneur2, 5] call BwS_fn_add_credit;
	
	sleep 30;
};
//deleteMarker _zone_op;
/*
BwS_IEDs = (([0,0] nearObjects BwS_IED_cfg_radius) select {_x getVariable ["BwS_IED_est_un_IED", false]});
sleep 10;
publicVariable "BwS_IEDs";
*/