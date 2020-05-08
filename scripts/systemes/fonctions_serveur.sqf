BwS_fn_chargement = 
{
	startLoadingScreen ["Chargement en cours"]; 
	waituntil {preloadCamera position player}; 
	endLoadingScreen;
}; 
	
BwS_fn_nearestPlayer = 
{
	private ["_nearest"];
	if ((count allPlayers) != 0) then {
		if (isDedicated) then {
			private ["_unit", "_distance_de_l_objet_actuel", "_distance_du_plus_proche"];
			_unit = (_this select 0);
			
			_nearest = objNull;
			_distance_de_l_objet_actuel = 0;
			_distance_du_plus_proche = 1000000000000000;
		
			{
				_distance_de_l_objet_actuel = _unit distance _x;
				if (_distance_de_l_objet_actuel < _distance_du_plus_proche) then {_nearest = _x; _distance_du_plus_proche = _distance_de_l_objet_actuel;};
			} forEach (allPlayers select {side _x != BwS_var_side_ennemie});
		}
		else {
			_nearest = player;
		};
	} 
	else {
		_nearest = objNull
	};
	_nearest
};
	
BwS_fn_nearestEnnemy = 
{		
	private ["_unit", "_distance", "_distancePrecedente", "_nearest"];
	
	BwS_nombreEnnemis = {side _x == East} count allUnits;
	if (BwS_nombreEnnemis != 0) then {
		_unit = (_this select 0);
		_nearest = objNull;
		_distance = 0;
		_distancePrecedente = 1000000000000000;
		
		{
			if (side _x == east) then {
				_distance = _unit distance _x;
				if (_distance < _distancePrecedente) then {_nearest = _x;};
				_distancePrecedente = _distance;
			};
		} forEach allUnits;
	}
	else {
		_nearest = objNull;
	};
	_nearest
};

BwS_fn_creerMarqueur =
{
	scriptName "BwS_fn_creerMarqueur";
	private ["_nomMarker", "_text", "_position", "_marker", "_couleur"];
	
    //[input,index,(defaultValue,dataTypes,requiredCount)] call BIS_fnc_param; 
	
	_text = _this select 0;
	_position = [_this, 1, [0, 0, 0], [[]], 3] call BIS_fnc_param;
	_couleur = [_this, 2, "Default", [""]] call BIS_fnc_param;
	
	_nomMarker = format ["%1", random 10000];
	
	_marker = createMarker [_nomMarker, _position];

	_nomMarker setMarkerColor _couleur;
	_nomMarker setMarkerShape "ICON";
	_nomMarker setMarkerType "hd_dot"; 
	_nomMarker setMarkerAlpha 1;
	_nomMarker setMarkerText format ["%1", _text];
	sleep 60;
	deleteMarker _nomMarker;
};

BwS_fn_addArray = {
	private ["_tabA", "_tabB", "_tabC"];
	_tabA = (_this select 0);
	_tabB = (_this select 1);
	_tabC = [];
	
	if (count _tabA == count _tabB) then
	{
		{
			_tabC pushBack (_x + (_tabB select ([_tabA, _x] call BwS_fn_getIndex)));
		} forEach _tabA;
	};
	
	_tabC
};

BwS_fn_substractArray = {
	private ["_tabA", "_tabB", "_tabC"];
	_tabA = (_this select 0);
	_tabB = (_this select 1);
	_tabC = [];
	
	if (count _tabA == count _tabB) then
	{
		{
			_tabC pushBack (_x - (_tabB select ([_tabA, _x] call BwS_fn_getIndex)));
		} forEach _tabA;
	};
	
	_tabC
};

BwS_fn_getIndex = {
	private ["_tab", "_elmt"];
	_tab = _this select 0;
	_elmt = _this select 1;
	
	for "_i" from 0 to count _tab do
	{
		if (_elmt == _tab select _i) exitWith {_i};
	};
};

BwS_fn_diag_log = {
	
	if (BwS_debug) then {
		diag_log format ["%1", (_this select 0)];
	};
};

BwS_fn_spawn_camp = 
{
	// [[<items>, ...], <position>, <position de ref>] call BwS_fn_spawn_camp;
	
	_items = (_this select 0);
	_position = _this select 1,
	_positionBase = _this select 2;
	
	{ 
		_temp = createVehicle [(_x select 0), ([_position, [_positionBase, _x select 1] call BwS_fn_substractArray] call BwS_fn_addArray), [], 0, "CAN_COLLIDE"];
		_temp setDir (_x select 2);
		_temp setVectorUp surfaceNormal position _temp;
		_temp setPosATL [position _temp select 0, position _temp select 1, 0];
	} forEach _objects;
};

//[<location>] spawn BwS_fn_occuper_une_location;
BwS_fn_occuper_une_location =
{
	scriptName "BwS_fn_occuper_une_location";
	private ["_maisons", "_nombreMaisons", "_location", "_group", "_groupHomed"];
	
	_location = _this select 0;

	// maisons rayon - 500m
	_maisons = (locationPosition _location) nearObjects ["House", 350];
	_maisons = _maisons call KK_fnc_arrayShuffle;
	_nombreMaisons = count _maisons;
	
	// une patrouille pour 50 maisons
	private ["_group"];
	for "_i" from 0 to (_nombreMaisons/50) do 
	{
		_group = [(locationPosition _location), 3 + round(random(5)), BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup;
		[_group, (position leader _group), 200] call BIS_fnc_taskPatrol;
	};	
	
	// on prend 5% des maisons
	_maisons resize floor(0.1*_nombreMaisons);
	_nombreMaisons = (count _maisons);

	// spawner des homed en proportion
	if (_nombreMaisons > 0) then 
	{
		{
			_pos = (_x buildingPos floor(random(count([_x] call BIS_fnc_buildingPositions))));
			if ((_pos select 0) != 0 && (_pos select 1) != 0) then {
				_groupHomed = createGroup BwS_var_side_ennemie;
				"I_C_Soldier_Para_7_F" createUnit [_pos, _groupHomed]; 
				_groupHomed setBehaviour "STEALTH";
				[(units _groupHomed) select 0] call BwS_fn_gestion_radio;
			};
		} forEach _maisons;
	};
	
	waitUntil {(({alive _x}count (units _group)) == 0) && (({alive _x}count (units _groupHomed)) == 0)};
};

BwS_fn_buildings_inAngleSector =
{
	//[<array buildings>, <unit>, <angle>, <to unit>] call BwS_fn_buildings_inAngleSector;
	private ["_array_buildings", "_unit", "_angle", "_toUnit", "_buildings_inAngleSector"];
	_array_buildings = _this select 0;
	_unit = _this select 1;
	_angle = _this select 2;
	_toUnit = _this select 3;
	
	_buildings_inAngleSector = [];
	{
		if ([getPos _unit, _unit getDir _toUnit, _angle, getPos _x] call BIS_fnc_inAngleSector) then
		{
			_buildings_inAngleSector pushBack _x;
		};
	} forEach _array_buildings;
	_buildings_inAngleSector
};

BwS_fn_tri_des_unites =
{
	BwS_var_unites = [];
	BwS_var_unites_de_caserne = BwS_var_unites_de_caserne - [grpNull];
	BwS_var_unites_d_usine = BwS_var_unites_d_usine - [grpNull];
	BwS_var_groupes_a_exclure = BwS_var_groupes_a_exclure - [grpNull];
	BwS_var_groupes_a_exclure_simulation = BwS_var_groupes_a_exclure_simulation - [grpNull];
	
	{deleteGroup _x} forEach (allGroups select {(count units _x == 0)});
	
	{
		if (side _x != west && (_x distance ([_x] call BwS_fn_nearestPlayer) <= 3000)) then
		{
			BwS_var_unites pushBack [_x, _x distance ([_x] call BwS_fn_nearestPlayer)];
		};
	} forEach allUnits-allDead;
	
	BwS_var_unites sort true;
	{BwS_var_unites set [_forEachIndex, _x select 0]} forEach BwS_var_unites;
	BwS_var_unites resize 50;
};

BwS_fn_faut_il_les_simuler =
{	
	if (({_x in BwS_var_unites} count units (_this select 0)) == count units (_this select 0)) then 
	{ true } else { false };
};

BwS_fn_faut_il_produire_des_pedestres =
{
	(({(_x distance (_this select 0)) <= 3000} count allPlayers > 0) && ({side _x == BwS_var_side_ennemie} count allUnits) < 200 && ({(_x distance (_this select 0)) <= 20} count allPlayers == 0))
};

BwS_fn_faut_il_produire_des_vehicules =
{
	(({(_x distance (_this select 0)) <= 3000} count allPlayers > 0) && ({side _x == BwS_var_side_ennemie} count allUnits) < 200 && ({(_x distance (_this select 0)) <= 20} count allPlayers == 0))
};

BwS_fn_nearestUsine = {
	_positionUsine = _this select 0;
	
	_usines = [];
	
	{
		_usines pushBack [_x, _x distance _positionUsine];
	} forEach BwS_usines;
	
	_usines sort true;
	{_usines set [_forEachIndex, _x select 0]} forEach _usines;
	
	(_usines select 0)
};

BwS_fn_nearestCaserne = {
	_positionCaserne = _this select 0;
	
	_casernes = [];
	
	{
		_casernes pushBack [_x, _x distance _positionCaserne];
	} forEach BwS_casernes;
	
	_casernes sort true;
	{_casernes set [_forEachIndex, _x select 0]} forEach _casernes;
	
	(_casernes select 0)
};

BwS_fn_sont_ils_en_groupe =
{
	((count (call BwS_fn_joueurs_en_groupe)) > 0)
};

BwS_fn_sont_ils_en_convoi =
{
	((count (call BwS_fn_joueurs_en_convoi)) > 0)
};

BwS_fn_nearest_group =
{
	_mechant = _this select 0;
	_joueurs_en_groupe = call BwS_fn_joueurs_en_groupe;
	_nearest = _joueurs_en_groupe select 0;
	{
		if ((_mechant distance _x) < (_mechant distance _nearest)) then
		{
			_nearest = _x;
		};
	} forEach _joueurs_en_groupe;
	_nearest
};

BwS_fn_nearest_convoi =
{
	_mechant = _this select 0;
	_joueurs_en_convoi = call BwS_fn_joueurs_en_convoi;
	_nearest = _joueurs_en_convoi select 0;
	{
		if ((_mechant distance _x) < (_mechant distance _nearest)) then
		{
			_nearest = _x;
		};
	} forEach _joueurs_en_convoi;
	_nearest
};

BwS_fn_joueurs_en_groupe =
{
	_joueurs_en_groupe = [];
	{
		_joueur = _x;
		if (({(_x distance _joueur) < 20} count allPlayers) > 3) then
		{
			_joueurs_en_groupe pushBack _x;
		};
	} forEach (allPlayers select {side _x != BwS_var_side_ennemie});
	_joueurs_en_groupe
};

BwS_fn_joueurs_en_convoi =
{
	_joueurs_en_convoi = [];
	{
		_vehiculesJoueurs = [];
		_joueur = _x;
		{ if (vehicle _x != _x) then {_vehiculesJoueurs pushBackUnique (vehicle _x)} } forEach allPlayers;
		
		if (({(((_x distance _joueur) < 200))} count _vehiculesJoueurs) > 2) then
		{
			_joueurs_en_convoi pushBack _x;
		};
	} forEach (allPlayers select {side _x != BwS_var_side_ennemie});
	_joueurs_en_convoi
};



BwS_fn_route_entre_a_et_b = {
	_r = (_this select 0);
	_a = (_this select 1);
	_b = (_this select 2);
	
	_xa = position _a select 0; 
	_xb = position _b select 0;
	_xr = position _r select 0;
	_ya = position _a select 1;
	_yb = position _b select 1;
	_yr = position _r select 1;
	
	if (_xa > _xb) then
	{
		if (_ya > _yb) then
		{
			(_xr <= _xa) && (_xr >= _xb) && (_yr <= _ya) && (_yr >= _yb)
		}
		else // _ya < _yb
		{
			(_xr <= _xa) && (_xr >= _xb) && (_yr >= _ya) && (_yr <= _yb)
		};
	}
	else // _xa < _xb
	{
		if (_ya > _yb) then
		{
			(_xr >= _xa) && (_xr <= _xb) && (_yr <= _ya) && (_yr >= _yb)
		}
		else // _ya < _yb
		{
			(_xr >= _xa) && (_xr <= _xb) && (_yr >= _ya) && (_yr <= _yb)
		};
	};
};

BwS_fn_creer_equipage = {
	_batiment = _this select 0;
	_groupe = group driver _batiment;
	
	diag_log "Demande de creation d un groupe dans BwS_fn_creer_equipage";
	_groupePassager = [[0,0,0], (_batiment emptyPositions "cargo"), side driver _batiment, BwS_var_side_ennemie] call BwS_fn_spawnGroup;
	{[_x] join _groupe; _x moveInCargo _batiment;} forEach units _groupePassager;
	_batiment setVariable ["BwS_SLM_est_mechant", true, false];
};

BwS_fn_random_water_pos =
{
	_randomWaterPos = ([[random 15350, random 15350], 1, 150, 3, 2, 20, 0] call BwS_fn_findSafePos); // water only
	
	while {_randomWaterPos isEqualTo (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"))} do
	{
		_randomWaterPos = ([[random 15350, random 15350], 1, 150, 3, 2, 20, 0] call BwS_fn_findSafePos); // water only
	};
	_randomWaterPos
};


KK_fnc_arrayShuffle =
{
    private "_cnt";
    _cnt = count _this;
    for "_i" from 1 to _cnt do {
        _this pushBack (_this deleteAt floor random _cnt);
    };
    _this
};


BwS_fn_gestion_homed =
{
	_homed = _this;

	while {alive _homed} do
	{
		{
			if ((_x distance _homed) < 20) then
			{ 
				(group _homed) setBehaviour "COMBAT";
				_homed reveal [_x, 4];
				_homed move (position _x);
			};
		} forEach (allPlayers select {side _x != BwS_var_side_ennemie});
		sleep 0.1;
	};
};

