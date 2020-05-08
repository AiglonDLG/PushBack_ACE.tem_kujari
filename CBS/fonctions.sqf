/*
*	fonctions.sqf
*	[B.w.S] SoP
*	
*	19/7/2018
*/

BwS_CBS_fn_random_pos_loc = 
{
	_loc = _this;

	_position = locationPosition _loc;
	_posX = _position select 0;
	_posY = _position select 1;

	_location3 = [_loc] call BwS_CBS_find_location_by_name;

	_radiusA = getNumber (_location3 >> "radiusA");
	_radiusB = getNumber (_location3 >> "radiusB");
	_pos = [0,0];

	while {!(_pos inArea [[_posX, _posY], _radiusA, _radiusB, 0, false])} do
	{
		_pos = [_posX - _radiusA + random(2*_radiusA), _posY - _radiusB + random(2*_radiusB)];
	};

	_pos
};

BwS_CBS_fn_construction_locations = 
{
	_centre_du_monde = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	_locations = nearestLocations [_centre_du_monde, ["NameCityCapital", "NameCity", "NameVillage", "CityCenter"], 30000];
	{
		BwS_CBS_cfg_locations pushBack _x;
	} forEach _locations;
};

BwS_CBS_fn_init_location = 
{
	_location = (_this select 0);
	// attribution d'un nombre de civil selon la taille de la location
	_location_position = locationPosition _location;
	
	_type = type _location;
	_nombre_max_civils = 0;

	{
		if (_type isEqualTo (_x select 0)) then
		{
			_nombre_max_civils = _x select 1;
		};
	} forEach BwS_CBS_cfg_habitants_par_location;

	// nombre aléatoire de civils +/- 5 par rapport à la cfg
	_nombre_de_civils = (_nombre_max_civils + 5 - round(random(10))) max 0;
	
	for "_i" from 0 to _nombre_de_civils do
	{
	 	_pos = _location call BwS_CBS_fn_random_pos_loc;
	 	sleep 0.1;
	 	[_pos] spawn BwS_CBS_fn_nouveau_civil;
	}; 

	/*_mrkr = createMarker [text _location, locationPosition _location];
	_location2 = [_location] call BwS_CBS_find_location_by_name;
	_mrkr setMarkerShape "ELLIPSE";
	_mrkr setMarkerColor "ColorGreen";
	_mrkr setMarkerSize [getNumber (_location2 >> "radiusA"), getNumber (_location2 >> "radiusB")];*/

	
};

BwS_CBS_fn_nouveau_civil = 
{
	_position = _this select 0;
	_position pushBack 0;
	_civ = objNull;
	_type = selectRandom(BwS_CBS_cfg_types_civils);

	/*_mrkr = createMarker [str(random(10000)), _position];
	_mrkr setMarkerShape "ELLIPSE";
	_mrkr setMarkerColor "ColorRed";
	_mrkr setMarkerSize [BwS_CBS_cfg_taille_sphere_influence_civil, BwS_CBS_cfg_taille_sphere_influence_civil];*/

	_civil_apparu = false;
	while {true} do
	{
		_doit_apparaitre = ([_position] call BwS_CBS_fn_civil_doit_apparaitre);

		// checks d'apparition
		if (!_civil_apparu && _doit_apparaitre) then
		{
			_civil_apparu = true;
			_grp = createGroup [civilian, true];
			_civ = _grp createUnit [_type, _position, [], BwS_CBS_cfg_taille_sphere_influence_civil, "NONE"];
			[_civ] execVM "cos\addScript_Unit.sqf";
			// init de ce nouveau civil
			// _civ addEventHandler ["Hit", 
			// {
			// 	params ["_unit", "_source", "_damage", "_instigator"];
			// 	_unit switchMove "Acts_LyingWounded_loop3";
			// 	_unit setVariable ["BwS_CBS_var_hit", "oui"];
			// }]; 

			_civ addEventHandler ["FiredNear", 
			{
				params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

				// maison la plus proche
				if !(_unit getVariable ["BwS_CBS_var_cache", false]) then 
				{
					_maison = nearestBuilding _unit;
					_positions = count ([_maison] call BIS_fnc_buildingPositions);
					_unit move (_maison buildingPos round(random(_positions)));
					_unit setSpeedMode "FULL";
	
					_unit setVariable ["BwS_CBS_var_cache", true];
					_unit spawn {sleep 60; _this setVariable ["BwS_CBS_var_cache", false]};
				};
			}];
		};

		if (_civil_apparu && !_doit_apparaitre) then
		{
			deleteVehicle _civ;
			_civil_apparu = false;
		};


		// vie
		if (_civil_apparu && alive _civ) then
		{
			if ((_civ getVariable ["BwS_CBS_var_hit", "non"]) isEqualTo "soigne") then
			{
				_civ switchMove "";
				_civ setVariable ["BwS_CBS_var_hit", "non", true];
			};

			// joueur dans la zone d'influence
			_joueurs_influents = [_position] call BwS_CBS_fn_joueur_dans_la_zone_d_influence;
			_ordre_donne = _civ getVariable ["BwS_CBS_var_pending_order", "aucun"];
			_pending_order = !(_ordre_donne isEqualTo "aucun");
			_cache = _civ getVariable ["BwS_CBS_var_cache", false]; // bool
			_civils_morts_prox = [_position] call BwS_CBS_fn_civil_mort_dans_la_zone_d_influence; // bool

			if (!_cache) then
			{
				_destination = [0,0,0];
				_mode = "NORMAL";
				_behaviour = "CARELESS";
				// deplacements randoms
				if (!_pending_order && !_joueurs_influents) then
				{
					_dst = BwS_CBS_cfg_taille_sphere_influence_civil;
					_destination = (_position vectorAdd [random(2*_dst) - _dst, random(2*_dst) - _dst, 0]);
					_mode = "LIMITED";
				};

				// deplacement vers un joueur
				if (_joueurs_influents) then
				{
					_nrst_player = ([_civ] call BwS_CBS_fn_nearest_player);
					_pos_tgt = position _nrst_player;
					_destination = (_pos_tgt vectorAdd [random(20)-10, random(20)-10, 0]);
					_mode = "LIMITED";
				};

				// deplacement vers un cadavre
				if (_civils_morts_prox) then
				{
					_nrst_dead = [_civ] call BwS_cbs_fn_nearest_civilian_dead;
					_destination = (position _nrst_dead);
					_mode = "FULL";
					_civ setUnitPos "MIDDLE";
				}; 
				_civ move _destination;
				_civ setSpeedMode _mode;
				_civ setBehaviour _behaviour;
			};

			if (_pending_order) then
			{
				// selon l'ordre donné
				// ...
				// manifestation
				if (_ordre_donne isEqualTo "manifestation") then
				{
					// rassemblement
					// attente
					// eventuel deplacement ?
				};

				_civ setVariable ["BwS_CBS_var_pending_order", "aucun", true];
			};
		};  

		sleep 20;
	};
};

BwS_CBS_find_location_by_name =
{
	_loc = text (_this select 0); // param = loc

	(format ["getText (_x >> ""name"") isEqualTo %1", str(_loc)] configClasses (configFile >> "cfgWorlds" >> worldName >> "Names")) select 0
};

BwS_CBS_fn_civil_doit_apparaitre =
{
	_pos = _this select 0;

	(count (allPlayers select {(_x distance _pos) < BwS_CBS_cfg_distance_apparition_civil}) > 0)
};

BwS_CBS_fn_joueur_dans_la_zone_d_influence =
{
	_unit = _this select 0;
	(count (allplayers select {(_x distance _unit) < BwS_CBS_cfg_taille_sphere_influence_civil})) > 0
};

BwS_CBS_fn_civils_morts = 
{
	((allUnits+allDead+allDeadMen) select {(side _x == civilian) && !(alive _x)})
};

BwS_CBS_fn_civil_mort_dans_la_zone_d_influence =
{
	_unit = _this select 0;
	_civMorts = call BwS_CBS_fn_civils_morts;
	(count (_civMorts select {((_x distance _unit) < BwS_CBS_cfg_taille_sphere_influence_civil)})) > 0
};

BwS_CBS_fn_nearest_player =
{
	_unit = _this select 0;
	[_unit, allPlayers] call BwS_CBS_fn_nearest_in_array;
};

BwS_cbs_fn_nearest_civilian_dead =
{
	params ["_unit"];
	[_unit, call BwS_CBS_fn_civils_morts] call BwS_CBS_fn_nearest_in_array;
};

BwS_CBS_fn_nearest_in_array = 
{
	params ["_unit", "_array"];
	_nearest = _array select 0;

	{
		_joueur = _x;
		if ((_joueur distance _unit) < (_nearest distance _unit)) then
		{
			_nearest = _joueur;
		};

	} forEach allPlayers;
	_nearest
}