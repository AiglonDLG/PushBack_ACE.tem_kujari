fn_vie = 
{
	_chef = _this;
	[_chef] spawn BwS_fn_initCivil;
	
	removeAllWeapons _chef;
	removeUniform _chef;
	removeVest _chef;
	removeBackpack _chef;

	_chef forceAddUniform "U_I_C_Soldier_Camo_F";
	for "_i" from 1 to 3 do {_chef addItemToUniform "10Rnd_9x21_Mag";};
	_chef addVest "V_Rangemaster_belt";
	for "_i" from 1 to 3 do {_chef addItemToVest "10Rnd_9x21_Mag";};
	for "_i" from 1 to 3 do {_chef addItemToVest "MiniGrenade";};

	_chef addWeapon "hgun_Pistol_01_F";

	while {alive _chef} do
	{
		// prochaine planque
		_planque = selectRandom BwS_var_casernes;
		if ((_planque distance _chef) > 1000) then
		{
			_veh = createVehicle [selectRandom BwS_LLM_cfg_types, position _chef, [], 30, "NONE"];
			(group _chef) addVehicle _veh;

			_chef assignAsDriver _veh;
			waitUntil {unitReady _chef};

			(group _chef) addWaypoint [_planque, 0];
			waitUntil {unitReady _chef};
			(group _chef) leaveVehicle _veh;
			BwS_var_voitures_a_supp pushBack _veh;
		}
		else
		{
			(group _chef) addWaypoint [_planque, 0];
		};
		[group _chef, currentWaypoint group _chef] setWaypointHousePosition 1;
		waitUntil {unitReady _chef};
		// tempo 2 heures
		sleep 7200;
	};
};

BwS_var_chefs = [];
BwS_var_voitures_a_supp = [];
BwS_var_casernes = [];

waitUntil {count BwS_var_casernes > 0};

while {true} do
{	
	if ((count BwS_var_chefs) < 5) then
	{
		_grp = [position selectRandom ROADS, 1, civilian] call BwS_fn_spawnGroup;
		_chef = leader _grp;
		_chef spawn fn_vie;
		BwS_var_chefs pushBack _chef;
	};

	if (count allPlayers == 0) then
	{
		{deleteVehicle _x} forEach BwS_var_voitures_a_supp;
		BwS_var_voitures_a_supp = [];
	};
	sleep 1;
};