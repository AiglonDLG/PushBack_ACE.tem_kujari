/**************************************
server.sqf
Functions server side

Author : ~R3F~ Mapoule et [B.w.S] SoP
team-r3f.org
***************************************/

R3F_AIC_FNCT_ai_suppress_fire = { 
	private ["_unit","_cible","_random_result"];
	
	_unit = _this select 0;
	_cible = _this select 1;
	
	_random_result = floor ( random 100 );	
	if (( _random_result <= R3F_AIC_CFG_suppress_fire_probability ) && ( _unit distance _cible <= ( R3F_AIC_CFG_distance_min_suppress_fire + random ( R3F_AIC_CFG_distance_max_suppress_fire - R3F_AIC_CFG_distance_min_suppress_fire )))) then 
	{
		_unit suppressFor ( R3F_AIC_CFG_time_min_suppress_fire + random (R3F_AIC_CFG_time_max_suppress_fire - R3F_AIC_CFG_time_min_suppress_fire) );
	};
};

R3F_AIC_FNCT_ai_flares = {
	if (( sunOrMoon < 1 ) && ( time > R3F_AIC_time_flare + (( random 120 ) + 120 )) && ( floor ( random 100 ) <= 15 )) then
	{
		private ["_unit", "_cible", "_flare"];
		
		_unit = _this select 0;
		_cible = _this select 1;
		
		if ( _unit distance _cible < floor ( random 50 ) + 150 ) then
		{	
			R3F_AIC_time_flare = time;
			sleep ( random 15 ) + 10;
			_flare =  createvehicle ["F_20mm_Red", [ getPos _cible select 0, getPos _cible select 1, (getPos _cible select 2) + 190 ], [], 100, "NONE"]; 
			_flare setVelocity [0, 0, -10];
			waitUntil {sleep 1; ! alive _flare};
			deleteVehicle _flare;
		};
	};
};

BwS_fn_GetInNearest = {
	private ["_unit", "_nearests"];
	
	_unit = _this select 0;

	_unit commandWatch objNull; 
	_unit doWatch objNull;
	
	_nearests = (position _unit) nearEntities [["StaticWeapon", "Tank", "Car", "Air"], 20]; // on récupère les statics les plus proches (- de 20m)

	if (count(_nearests) != 0) then 
	{
		{
			private ["_nearest", "_occupe"];
			_nearest = _x; // on prend le premier venu (pas forcément le plus proche, à améliorer)	
			
			_occupe = (_nearest getVariable ["BwS_var_occupe", false]);
			_assigne = ((leader group _unit) getVariable ["BwS_var_assigne", false]);
			
			if (!_occupe && !_assigne) exitWith
			{
				group _unit addVehicle _nearest;
				{
					[_x] orderGetIn true;
				} forEach units group _unit;
				_nearest setVariable ["BwS_var_occupe", true];
				(leader group _unit) setVariable ["BwS_var_assigne", true];
				
			};
		} forEach _nearests;
	};	
};

BwS_fn_mouvements = 
{
	sleep 0.01;
	private ["_unit", "_prochain_mouvement", "_nearest_building"];

	_unit = (_this select 0);

	_prochain_mouvement = 0;

	while {(behaviour _unit == "COMBAT") && (alive _unit) && !BwS_AIC_execution_fnct_serveur_en_cours} do
	{
		_nearest_building = (nearestObjects [_unit, ["House", "Building"], 50]) call KK_fnc_arrayShuffle;  // maisons les plus proches dans un rayon de 50m (mélangées)
		_nearest_player = [_unit] call BwS_fn_nearestPlayer;
		
		_nearest_building = [_nearest_building, _unit, 60, _nearest_player] call BwS_fn_buildings_inAngleSector;
		
		if (count _nearest_building > 0) then// si on en compte au moins 1
		{
			_nearest_building = _nearest_building select 0;// on prend la première du tableau
			
			if ((_unit distance _nearest_building) < 20) then // si on est à - de 20m de cette batisse
			{
				_unit commandMove (selectRandom ([_nearest_building] call BIS_fnc_buildingPositions));// on commande d'aller dedans
				_unit setSpeedMode "FULL";
				_prochain_mouvement = time + 40;
			}
			else
			{
				_unit commandMove position (nearestBuilding _unit); // sinon on commande de s'en rapprocher
				_unit setSpeedMode "FULL";
				_prochain_mouvement = time + 10;
			};
		}
		else // sinon push sur le joueur le plus proche
		{	
			_unit commandMove position ([_unit] call BwS_fn_nearestPlayer);
			_prochain_mouvement = time + 20;
		};
		
		waitUntil {time >= _prochain_mouvement};
		sleep 0.1;
	};
};

BwS_fn_handle_fire =
{
	private ["_unit", "_target"];
	_unit = _this select 0;
	
	_target = selectRandom ((_unit nearEntities R3F_AIC_CFG_distance_max_suppress_fire) select {side _x == west});
	
	_unit doWatch _target;

	waitUntil {_unit aimedAtTarget [_target] > 0};
	
	while {!BwS_AIC_execution_fnct_serveur_en_cours} do
	{
		_unit fireAtTarget [_target]; 
		sleep 0.5+ (random 0.5);
	};
};

R3F_AIC_FNCT_sever = {
	BwS_AIC_execution_fnct_serveur_en_cours = true;
	
	private ["_player_array_eni","_player","_array_eni_detected","_distance","_min_max_reveal"];

	_player_array_eni = _this select 1;
	_player = _player_array_eni  select 0;
	_array_eni_detected = _player_array_eni select 1;

	switch ( sunOrMoon ) do
	{
		case 1:
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_day_min_max;
		};
		case 0:
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_night_min_max;
		};		
		default 
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_transition_d_n_min_max;
		};
	};
	
	{
		if ( _x knowsAbout _player < R3F_AIC_CFG_knowsAbout_set_mini ) then 
		 {
			_distance_de_l_objet_actuel= _x distance _player;
			if ( _x isKindOf "LandVehicle" ) then
			{
				_x reveal [ _player, 3.3 ];
				_x setCombatMode "RED";
				_x setBehaviour "COMBAT";
				_x allowFleeing 0;
				_x doTarget _player;
			} else {
				if ( _distance_de_l_objet_actuel> 250 ) then
				{
					_x reveal [ _player, _min_max_reveal select 0 ];
				} else {
					_x reveal [ _player, _min_max_reveal select 1 ];
				};
			};
		 }; 

		[ _x, _player ] call R3F_AIC_FNCT_ai_suppress_fire; 
		[ _x, _player ] spawn R3F_AIC_FNCT_ai_flares; 
		// [ _x ] spawn BwS_fn_GetInNearest;
		// [ _x ] spawn BwS_fn_mouvements;
		// [ _x ] spawn BwS_fn_handle_fire;
	} forEach _array_eni_detected;
		
	BwS_AIC_execution_fnct_serveur_en_cours = false;
};