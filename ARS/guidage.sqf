// Merci Madbull !!

fn_detonne = 
{
	_charge = "SatchelCharge_Remote_Ammo_Scripted" createVehicle position _this;
	deleteVehicle _this;
	_charge setDamage 1;
};

BwS_ARS_fn_hint =
{
	_missile	= _this select 0;
	_brouillage	= _this select 1;
	_cible 		= _this select 2;

	_locked = if (_brouillage) then {format ["<t size='0.9' align='right' color='#FF0000'>LOST</t>"]} else {format ["<t size='0.9' align='right' color='#00FF00'>LOCKED</t>"]};
	
	_nomMissile = getText(configFile >> "CfgVehicles" >> (typeof _missile) >> "displayName");
	if ((vectorMagnitude velocity _missile) != 0) then
	{
		_text = composeText [
			"<br /><t align='left' size='0.9'>MSL</t>",
			(format ["<t size='0.9' align='right'>%1</t>", _nomMissile]),
			
			"<br /><t align='left' size='0.9'>SPD</t>", 
			(format ["<t size='0.9' align='right'>%1 km/h (Ma %2)</t>", round(speed _missile), (vectorMagnitude velocity _missile)/340]), 
			
			"<br /><t align='left' size='0.9'>RNG to TARGET</t>", 
			(format ["<t size='0.9' align='right'>%1 m</t>", round(_cible distance _missile)]), 
			
			"<br /><t align='left' size='0.9'>ETA</t>", 
			(format ["<t size='0.9' align='right'>%1 s</t>", round((_cible distance _missile)/(vectorMagnitude velocity _missile))]), 
			
			"<br /><t align='left' size='0.9'>LOCKED</t>", 
			_locked];	
			
			hintSilent parseText str _text;
	}
	else
	{
		hintSilent "Signal lost";
	};
	
};

BwS_ARS_fn_guidage =
{
	_missile = (_this select 0);
	_cible = (_this select 1);
	_suivi = false;
	_cam = "camera" camCreate (getPos player);
	if (_suivi) then
	{
		_cam cameraEffect ["Internal", "BACK"];
		_cam camSetFocus [-1, -1];
	};
	
	_type = typeOf _missile;
	sleep 1;
	
	_missile_speed = speed _missile / 3.6;
	_vel = velocity _missile;
	_position = position _missile;
	_dap = [vectorDir _missile, vectorUp _missile];
	_missile setPos [-100,-100,0];
	
	deleteVehicle _missile;
	
	_missile = _type createVehicle _position;
	_missile setVectorDirAndUp _dap;
	_missile setVelocity _vel;
	
	BwS_ARS_var_missiles pushBack _missile;
	publicVariable "BwS_ARS_var_missiles";
		
	_brouillage = (_cible getVariable ["BwS_ARS_var_ECM_actif", false] || (position _cible select 2 < 40));
	_brouillagePrecedent = !_brouillage;
	_continuer = true;
	while {_continuer} do
	{
		// CIBLE VEROUILLEE
		// à distance d'explosion
		if (_missile distance _cible <= 20) then
		{
			vehicle player vehicleChat format ["Missile : cible atteinte  - RNG: %1m", round(_missile distance _cible)];
			_continuer = false;
			_missile spawn fn_detonne;
		};
					
		_position_cible = (getPosASL _cible);
		_vitesse_cible = velocity _cible;
		_vec_missile_target = _position_cible vectorDiff (getPosASL _missile);
		_dir_target = vectorNormalized _vec_missile_target;	
		// cône de verrouillage
		if (vectorDir _missile vectorCos _dir_target < BwS_ARS_cfg_lock_cone_missiles_cos) exitWith 
		{
			vehicle player vehicleChat format ["Missile : cible perdue - autodestruction - RNG: %1m", round(_cible distance _missile)];
			_continuer = false;
			_missile spawn fn_detonne;
		};
		
		if (_missile isEqualTo objNull) then
		{
			_continuer = false;
		};
		
		// la cible active son brouillage
		_brouillage = (_cible getVariable ["BwS_ARS_var_ECM_actif", false] || (position _cible select 2 < 40));
		if !(_brouillage isEqualTo _brouillagePrecedent) then
		{
			if (_brouillage) then
			{
				vehicle player vehicleChat format ["Missile : cible perdue  - RNG: %1m", round((_cible distance _missile))];
				_cible = objNull;
				while {isNull _cible} do
				{
					// RECHERCHE DE CIBLE
					_derniere_position_connue = _position_cible;
					_derniere_vitesse_connue = vectorMagnitude _vitesse_cible;
					_leurres = BwS_ARS_var_leurres apply {_x select 0};
					diag_log _leurres;
					_cibles_potentielles = (vehicles select 
							{
								(_x getVariable ["BwS_ARS_var_est_illumine", false] || 
								_x getVariable ["BwS_ARS_var_est_identifie", false] || 
								_x getVariable ["BwS_ARS_var_radar_actif", false]) && 
								(side _x != side player) &&
								([(vehicle player), _x, acos(BwS_ARS_cfg_lock_cone_missiles_cos)] call BwS_ARS_fn_cible_inAngleSector)
							})+(BwS_ARS_var_missiles-[_missile]+_leurres select {([(vehicle player), _x, acos(BwS_ARS_cfg_lock_cone_missiles_cos)] call BwS_ARS_fn_cible_inAngleSector)});
					_sorted_cibles = _cibles_potentielles apply {[_x, abs(_derniere_vitesse_connue-vectorMagnitude(velocity _x))/_derniere_vitesse_connue]};
					_sorted_cibles sort true;
					_cible = (_sorted_cibles select 0) select 0;
					diag_log _sorted_cibles;
					diag_log typeOf _cible;
				};
			}
			else
			{
				vehicle player vehicleChat format ["Missile : cible accrochée  - RNG: %1m ETA: %2s", round((_cible distance _missile)), round((_cible distance _missile)/(_missile_speed))];
			};
		};
		
		_brouillagePrecedent = _brouillage;
		
		if (!(_brouillage) && (position _cible select 2 >= 40)) then
		{				
			_missile setVectorDirAndUp [_dir_target, [0,0,3]];
		};			
		
		[_missile, _brouillage, _cible] spawn BwS_ARS_fn_hint;
		
		if (_suivi) then
		{
			_cam camSetTarget _cible;				
			_cam camSetPos ((position _cible) vectorAdd [100,100,100]);
			_cam camCommit 0.01;
		};
		sleep 0.01;
	};
	sleep 5;
	
	if (_suivi) then {_cam cameraEffect ["Terminate", "BACK"];};
    camDestroy _cam;
};