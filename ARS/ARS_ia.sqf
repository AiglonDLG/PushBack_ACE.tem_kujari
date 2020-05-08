sleep 5;
waitUntil {BwS_ARS_init_done};
_vehicule = _this select 0;

if (_vehicule getVariable ["BwS_ARS_var_deja_monitored", false]) exitWith {};

_vehicule setVariable ["BwS_ARS_var_deja_monitored", true];
[_vehicule] spawn BwS_ARS_fn_monte_dans_un_avion;

while {alive _vehicule} do
{
	(vehicle _vehicule) setVariable ["BwS_ARS_var_est_illumine", (count ((vehicles select 
					{
						(_x getVariable ["BwS_ARS_var_radar_actif", false]) && 
						(_x distance _vehicule <= BwS_ARS_cfg_portee_radar) && 
						(side _x != side _vehicule) &&
						([_x, (_vehicule), 120] call BwS_ARS_fn_cible_inAngleSector)
					})-[_vehicule]) > 0), true];

	if (typeOf _vehicule in (BwS_ARS_cfg_AA_sol+BwS_ARS_cfg_avions)) then
	{
		_vehicule setVariable ["BwS_ARS_var_cible", selectRandom(vehicles select 
					{
						(_x getVariable ["BwS_ARS_var_est_illumine", false] || 
						_x getVariable ["BwS_ARS_var_est_identifie", false] || 
						_x getVariable ["BwS_ARS_var_radar_actif", false]) && 
						(side _x != side driver _vehicule) && 
						(position _x select 2 >= 40) && 
						([_vehicule, _x, 60] call BwS_ARS_fn_cible_inAngleSector)
					})];
	};
	
	if (!((_vehicule getVariable ["BwS_ARS_var_cible", objNull]) isEqualTo objNull) && (typeOf _vehicule in (BwS_ARS_cfg_AA_sol+BwS_ARS_cfg_avions))) then
	{
		_cible = (_vehicule getVariable ["BwS_ARS_var_cible", objNull]);
		_vehicule reveal [_cible, 4];
		_vehicule commandTarget _cible;
		_vehicule commandMove (position _cible);
		sleep 15;
		// on a une cible, on tire
		_muzzle = selectRandom(weapons _vehicule select {_x in BwS_ARS_cfg_missiles_AA});
		_vehicule selectWeapon _muzzle;
		driver _vehicule selectWeapon _muzzle;
		
		_vehicule fire _muzzle;
		sleep 5;
	};
	
	if (typeOf _vehicule in BwS_ARS_cfg_avions) then 
	{				
		if ((vehicle _vehicule) getVariable ["BwS_ARS_var_est_illumine", false]) then
		{
			sleep random 20;
			[_vehicule] spawn BwS_ARS_fn_demande_debut_ECM;
			_vehicule setVariable ["BwS_ARS_var_radar_actif", true, true];
		}
		else
		{
			// _vehicule setVariable ["BwS_ARS_var_est_identifie", true, true];
			_vehicule setVariable ["BwS_ARS_var_radar_actif", false, true];
		};
	};
	
	if (typeOf _vehicule in BwS_ARS_cfg_AA_sol) then
	{
		_vehicule setVariable ["BwS_ARS_var_radar_actif", true, true];
	};
	sleep 5;
};