
BwS_fn_gestion_vehicule = 
{ 
	scriptName "BwS_fn_gestion_vehicule";
	_v = _this select 0;
	_spawnPos = position _v;
	_dir = direction _v;
	_typeof = typeof _v;
	_prochainCheck = 0;
	
	_v addEventHandler ["GetIn", {(_this select 0) setVariable ["BwS_var_prochain_check", 1000000000]}];
	_v addEventHandler ["GetOut", {if (count crew (_this select 0) == 0) then {(_this select 0) setVariable ["BwS_var_prochain_check", time+(600)]}}];
		
	_v setVariable ["BwS_var_prochain_check", 1000000000];
	
	while {true} do
	{
		_prochainCheck = (_v getVariable ["BwS_var_prochain_check", 0]);
		
		if ((time >= _prochainCheck && _typeof in ["B_T_Quadbike_01_F","B_Quadbike_01_F","C_Offroad_01_repair_F","B_Truck_01_mover_F"]) || damage _v == 1) then
		{
			if (damage _v == 1) then
			{
				sleep 300; // 5 min avant réapparition
				deleteVehicle _v;
				sleep 1;
				_v = objNull;
				sleep 1;
				_v = _typeof createVehicle [0,0,10000];
				_v addEventHandler ["GetIn", {(_this select 0) setVariable ["BwS_var_prochain_check", 1000000000]}];
				_v addEventHandler ["GetOut", {if (count crew (_this select 0) == 0) then {(_this select 0) setVariable ["BwS_var_prochain_check", time+(600)]}}];				
				_v setDir _dir;
				_v setPos _spawnPos;
				_v setDamage 0;
				_v setFuel 1;
				_v setVehicleAmmoDef 1;
				_v setVariable ["BwS_var_prochain_check", 1000000000];
			}
			else
			{
				_v setDir _dir;
				_v setPos _spawnPos;
				_v setDamage 0;
				_v setFuel 1;
				_v setVehicleAmmoDef 1;
				_v setVariable ["BwS_var_prochain_check", 1000000000];
			};
		};
	
		sleep 1;
	};
};

{
	[_x] spawn BwS_fn_gestion_vehicule;
} forEach (vehicles select {(_x distance markerPos "navale" < 200) || (_x distance markerPos "PC" < 500) || (_x distance FOBa < 200) || (_x distance FOBb < 500)})-[FOBa,FOBb,COP_USA_1,COP_USA_2,arsenal1,arsenal2,conteneur,conteneur2,remise1,remise2];