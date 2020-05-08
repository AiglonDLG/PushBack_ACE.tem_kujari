BwS_fn_gestion_radio = {
	scriptName "BwS_fn_gestion_radio";
	private ["_unit", "_unit_est_leader", "_tempsActuel", "_temps_dernier_rapport_au_hq"];
	
	_unit = _this select 0;
	
	_unit_est_leader = if (leader group _unit == _unit) then {true} else {false};
	
	_temps_dernier_rapport_au_hq = 0;
	_temps_rapports = 270 + random(60);

	while {alive _unit} do
	{
		if (simulationEnabled _unit) then 
		{
			_tempsActuel = serverTime;
			
			if (_unit_est_leader) then
			{
				if ((_tempsActuel - _temps_dernier_rapport_au_hq) >= _temps_rapports) then
				{
					_unit setVariable ["BwS_var_est_en_train_de_transmettre", true, true];
					sleep 10;
					_unit setVariable ["BwS_var_est_en_train_de_transmettre", false, true];
					_temps_dernier_rapport_au_hq = serverTime;
				};
			};
			
			if ((behaviour _unit isEqualTo "COMBAT") && ((random 1000) < 10)) then 
			{
				_unit setVariable ["BwS_var_est_en_train_de_transmettre", true, true];
				sleep (random 7);
				_unit setVariable ["BwS_var_est_en_train_de_transmettre", false, true];
			};
			
			if ((random 7500) < 10) then 
			{
				_unit setVariable ["BwS_var_est_en_train_de_transmettre", true, true];
				sleep (random 5);
				_unit setVariable ["BwS_var_est_en_train_de_transmettre", false, true];
			};
		};
		
		sleep 10;
	};
};

BwS_fn_detecter_radios = 
{
	scriptName "BwS_fn_detecter_radios";
	{
		if (_x distance player <= (_this select 1)) then 
		{
			if ((_x getVariable ["BwS_var_est_en_train_de_transmettre", false])) then
			{
				[[(position _x select 0) - (0.01*(_this select 1)) + (random 2*(0.01*(_this select 1))), (position _x select 1) - (0.01*(_this select 1)) + (random 2*(0.01*(_this select 1)))]] spawn {
					_nom = format ["radio_%1", random 10000];
					createMarkerLocal [_nom, (_this select 0)];
					_nom setMarkerShapeLocal "ELLIPSE";
					_nom setMarkerBrushLocal "Border";
					_nom setMarkerSizeLocal [0, 0];
					
					for "_i" from 50 to 250 do {
						_nom setMarkerSizeLocal [_i, _i];
						sleep 0.01;
					};
					deleteMarkerLocal _nom;
				};
			};
		};
	} forEach ((_this select 0) nearEntities ["Man", (_this select 1)]) + allPlayers;
};

BwS_fn_brouillage_local =
{
	scriptName "BwS_fn_brouillage_local";
	private ["_brouilleurs", "_joueurBrouille", "_coefficient"];
	_brouilleurs = nearestObjects [player, ["Land_JetEngineStarter_01_F"], 3000];
	_joueurBrouille = false;
	_coefficient = 0;
	if ((count _brouilleurs) > 0) then
	{
		{
			_distance_de_brouillage_x = _x getVariable ["BwS_var_distance_de_brouillage", 1500];
			if (((player distance _x) <= _distance_de_brouillage_x) && (alive _x)) then 
			{
				_coefficient = ((_distance_de_brouillage_x-(player distance _x))/(_distance_de_brouillage_x))*100; // ==> coef tend vers 100 quand on est proche				
				_joueurBrouille = if ((random 100) <= _coefficient) then {true} else {false};
			};
		} forEach _brouilleurs; 
	};

	player setVariable ["tf_unable_to_use_radio", _joueurBrouille];
};


