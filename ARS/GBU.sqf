BwS_ARS_GBU_fn_guidage =
{
	_suivi = false;
	_bombe = (_this select 0);
	_cible = (_this select 1);
	_position_cible = [0,0,0];
	if !("agm" in _this) then
	{
		_position_cible = AGLToASL _cible;
	};
	
	_cam = "camera" camCreate (getPos player);

	if (_suivi) then 
	{
		_cam cameraEffect ["Internal", "BACK"];
		_cam camSetFocus [-1, -1];
		showCinemaBorder false;
		_cam camSetTarget _cible;
		_cam camCommit 0;
	};
	
	if (!(_cible isEqualTo [0,0,0]) || ("agm" in _this)) then
	{
		_type = typeOf _bombe;
		sleep 1;
		
		_vel = velocity _bombe;
		_position = position _bombe;
		_dap = [vectorDir _bombe, vectorUp _bombe];
		_bombe setPos [-100,-100,500];
		
		deleteVehicle _bombe;
		
		_bombe = _type createVehicle _position;
		_bombe setVectorDirAndUp _dap;
		_bombe setVelocity _vel;

		if ("missile" in _this) then 
		{
			BwS_ARS_var_missiles pushBack _bombe;
			publicVariable "BwS_ARS_var_missiles";
		};

		_last_dist = 0;
		_vec_bombe_target = [0,0,0];
		while {alive _bombe} do
		{		
			if ("agm" in _this) then
			{
				_position_cible = AGLToASL position _cible; // dans le cas où _cible est un objet
			};
			
			if ((ASLToATL(_position_cible)) select 2 > 40) then
			{
				_bombe spawn fn_detonne;
			};
			
			_vec_bombe_target = (_position_cible vectorAdd [0,0, (_position_cible distance2D  _bombe) min (getPos _bombe select 2)]) vectorDiff (getPosASL _bombe vectorAdd [0,0,-1]);
			
			_dir_target = vectorNormalized _vec_bombe_target;	

			_bombe setVectorDirAndUp [_dir_target, [0,0,1]];				
			_missile_speed = vectorMagnitude velocity _bombe;
			
			if (_suivi) then
			{
				_cam camSetTarget _position_cible;				
				_cam camSetPos (position _bombe) vectorAdd [0,0,1];
				_cam camCommit 0.01;
			};
			_last_dist = (getPosASL _bombe) distance _position_cible;
			sleep 0.01;
		};
		vehicle player vehicleChat format ["Ciblage GPS : cible atteinte à %1m", round(_last_dist)];
		
		if (_suivi) then
		{
			sleep 5;
			_cam cameraEffect ["Terminate", "BACK"];
		};
		camDestroy _cam;
	};
};