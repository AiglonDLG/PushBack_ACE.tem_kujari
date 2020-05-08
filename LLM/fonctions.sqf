BwS_LLM_fn_nouveau_terrestre =
{
	_voiture = (selectRandom BwS_LLM_cfg_types) createVehicle (position selectRandom ROADS);
	BwS_LLM_var_terrestres_en_route = BwS_LLM_var_terrestres_en_route + [_voiture];

	createVehicleCrew _voiture;
	_driver = driver _voiture;
	_grp = group _driver;
	[_driver] execVM "cos\addScript_Unit.sqf";
	_randomRoad = position selectRandom ROADS;
	
	_grp move _randomRoad;
	
	waitUntil {(_voiture distance _randomRoad) < 50 || (count allPlayers == 0) || !alive _driver};
	
	if ((_voiture distance _randomRoad) < 50 || (count allPlayers == 0)) then 
	{
		{deleteVehicle _x} forEach crew _voiture;
		deleteVehicle _voiture;
	};

	BwS_LLM_var_terrestres_en_route = BwS_LLM_var_terrestres_en_route - [_voiture];
};