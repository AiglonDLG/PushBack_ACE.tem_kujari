BwS_IED_fn_robot_ouvreur =
{
	_drone = _this select 0;
	_distance = 10;

	while {alive _drone} do
	{
		_IEDs = ((_drone nearObjects _distance) select {_x getVariable ["BwS_IED_est_un_IED", false]});
		
		if (count _IEDs > 0) then // s'il y a des IED à - de _distance m
		{
			_ied = ((nearestObjects [_drone, [], _distance]) select {_x getVariable ["BwS_IED_est_un_IED", false]}) select 0;
			
			if (_ied getVariable ["BwS_IED_RC", false]) then // si l'IED est contrôlé à distance
			{
				if (alive (_ied getVariable ["BwS_IED_controleur", objNull])) then // si le déclencheur est vivant, peu importe EOD ou pas, boum
				{
					[_ied] call BwS_IED_fn_Explose_IED;
				}
				else // l'observateur n'est plus vivant, l'objet n'est plus un IED
				{
					_ied setVariable ["BwS_IED_est_un_IED", false, true];
				};
			}
			else
			{
				if (!(call BwS_IED_cfg_joueur_EOD) || (abs(speed _drone) >= 6)) then // si le joueur n'est pas EOD ou s'il va trop vite
				{
					[_ied] call BwS_IED_fn_Explose_IED; // boom
				};
			};
		};
		sleep 1;
	};
};

BwS_IED_fn_creer_IED =
{	
	_randomRoad = objNull;
	if (count _this > 0) then {_randomRoad = _this select 0} else {_randomRoad = selectRandom ROADS};
	_randomType = selectRandom BwS_IED_cfg_types;
	
	_pos = [_randomRoad] call EPD_FIND_LOCATION_BY_ROAD;

	while {(count (allPlayers select {(_x distance _pos) < 2000})) == 0} do
	{					
		sleep 1;
	};

	_IED = (_randomType select 0) createVehicle _pos;

	if (_IED != objNull) then {			
		_IED setVariable ["BwS_IED_est_un_IED", true, true];
		_IED setVariable ["BwS_IED_force", (_randomType select 1), true];
		if (random 1 < BwS_IED_cfg_probabilite_RC) then
		{
			_IED setVariable ["BwS_IED_RC", true, true];
			_GRP_controleur = [(position _IED), 1, BwS_IED_cfg_type_controlleur, BwS_IED_cfg_camp_controlleur] call BwS_fn_spawnGroup;

			sleep 0.01;
			_controleur = (units _GRP_controleur) select 0;
			_controleur setPos [(position _controleur select 0)-10+random(20), (position _controleur select 1)-10+random(20)];
			_controleur setBehaviour "STEALTH";
			_controleur disableAI "MOVE";
			_IED setVariable ["BwS_IED_controleur", _controleur, true];
			_controleur addMagazine "30Rnd_762x39_Mag_F";
			_controleur addWeapon "arifle_AKM_F";
			_controleur addMagazine "30Rnd_762x39_Mag_F";
			_controleur addMagazine "30Rnd_762x39_Mag_F";
		}
		else
		{
			_IED setVariable ["BwS_IED_RC", false, true];
			_IED setVariable ["BwS_IED_controleur", objNull, true];
		};
	};		
	// [_IED] remoteExec ["BwS_IED_fn_addAction", 0, true];
	// [format ["IED %1", (_ied getVariable "BwS_IED_RC")], position _IED] spawn BwS_fn_creerMarqueur;
	BwS_IEDs pushBack _IED;
	// publicVariable "BwS_IEDs";
};

BwS_IED_fn_init =
{
	scriptName "BwS_IED_fn_init";

	if (BwS_IED_cfg_nombre_d_IED > 0) then 
	{
		for "_i" from 1 to BwS_IED_cfg_nombre_d_IED do
		{
			[] spawn BwS_IED_fn_creer_IED;
		};
	};
	
	while {true} do {
		// BwS_IEDs = (([0,0] nearObjects 30000) select {_x getVariable ["BwS_IED_est_un_IED", false]});
		{
			if (typeOf _x == "B_UGV_01_F" && !(_x getVariable ["BwS_IED_var_ouvreur", false])) then
			{
				_x setVariable ["BwS_IED_var_ouvreur", true, true];
				[_x] spawn BwS_IED_fn_robot_ouvreur;				
			};
		} forEach allUnitsUAV;
		publicVariable "BwS_IEDs";
		sleep 60;
	};
};

EPD_CREATE_FRAGMENTS = { // fonction de [EPD] Brian du script random IED
	_pos = _this select 0;
	_numberOfFragments = _this select 1;
	for "_i" from 0 to _numberOfFragments - 1 do{
		_pos set[2,.1 + random 2]; 
		_bullet = "B_408_Ball" createVehicle _pos;
		_angle = random 360;
		_speed = 450 + random 100;
		_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), -1*(random 4)];
	};
};

EPD_FIND_LOCATION_BY_ROAD = { // fonction de [EPD] Brian du script random IED
	_road = _this select 0;
	_orthogonalDist = 5;
	_dir = 0;
	if(count (roadsConnectedTo _road) > 0) then {
		_dir  = [_road, (roadsConnectedTo _road) select 0] call BIS_fnc_DirTo;
	};
	_position = getpos _road;
	_opositionX = _position select 0;
	_opositionY = _position select 1;

	_offSetDirection = 1;
	if((random 100) > 50) then { _offSetDirection = -1;};

	_positionX = _opositionX + (random 5) * _offSetDirection * sin(_dir);
	_positionY = _opositionY + (random 5) * _offSetDirection * cos(_dir);

	if((random 100) > 50) then { _offSetDirection = -1 * _offSetDirection;};		

	_tx = _positionX;
	_ty = _positionY;

	while{isOnRoad [_tx,_ty,0]} do{
		_orthogonalDist = _orthogonalDist + _offSetDirection;
		_tx = (_positionX + (_orthogonalDist * cos(_dir)));
		_ty = (_positionY + (_orthogonalDist * sin(_dir)));
	};	

	_extraOffSet = 1 + random 5;
	//move it off the road a random amount
	_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
	_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));

	//ensure we didn't put it on another road, this happens a lot at Y type intersections
	while{isOnRoad [_tx,_ty,0]} do
	{
		_extraOffSet = _extraOffSet - 0.5;
		_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
		_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));
	};
			
	[_tx,_ty,0];
};

	
BwS_IED_fn_Explose_IED = 
{
	_ied = (_this select 0);

	// ajout PB
	{deleteVehicle _x} forEach (_ied nearObjects ["DemoCharge_Remote_Ammo", 5]); 

	_ied setVariable ["BwS_IED_est_un_IED", false, true];
	
	_pos = position _ied;
	_type = (_ied getVariable ["BwS_IED_force", "R_80mm_HE"]);
	_controleur = (_ied getVariable ["BwS_IED_controleur", objNull]);
	
	deleteVehicle _ied;

	[_pos, 100] call EPD_CREATE_FRAGMENTS;
	
	_smoke = "IED_SMOKE_LARGE";

	if (_type in ["M_Mo_82mm_AT_LG", "HelicopterExploBig", "M_Air_AA_MI02"]) then
	{
		_smoke = "IED_SMOKE_MEDIUM";
	};

	if (_type in ["M_Titan_AA_long", "M_Zephyr", "M_Air_AT", "M_Titan_AA", "M_Titan_AT", "R_80mm_HE", "M_PG_AT", "R_Hydra_HE"]) then
	{
		_smoke = "IED_SMOKE_SMALL";
	};
	
	_pos set [2, 0];
	_type createVehicle _pos;	

	[[_pos], "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
	[[_pos], _smoke, true, false] spawn BIS_fnc_MP;
	[[_pos], "SHOCK_WAVE", true, false] spawn BIS_fnc_MP;
	
	if (_controleur != objNull) then {_type createVehicle position _controleur};
	[] spawn BwS_IED_fn_creer_IED; // quand un IED exlose, on en créé un nouveau
};

BwS_IED_fn_addAction =
{
	_ied = (_this select 0);
	
	_desarmer = ("<t color=""#27EE1F"">") + ("Désarmer l'IED") + "</t>";
	
	_ied addAction [
		_desarmer,
		{
			_ied = (_this select 3) select 0;
			
			[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
			disableUserInput true;
			sleep 4.545;			
			
			if (((call BwS_IED_cfg_joueur_EOD) && (random 100 > 2)) or (random 100 < 10)) then {_ied setVariable ["BwS_IED_est_un_IED", false, true];}
			else {[_ied] spawn BwS_IED_fn_Explose_IED};
			
			[[[player], {(_this select 0) playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
			sleep 6.545;
			disableUserInput false;

			_ied removeAction (_this select 2);
		},
		[_ied],
		11,
		false,
		true,
		"",
		BwS_IED_cfg_condition_desarmement
	];
};	

BwS_IED_fn_addAction2 =
{	
	_desarmer = ("<t color=""#27EE1F"">") + ("Désarmer l'IED") + "</t>";
	
	_action = [
		_desarmer,
		{
			_ied = cursorObject;
			
			[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
			disableUserInput true;
			sleep 4.545;			
			
			if (((call BwS_IED_cfg_joueur_EOD) && (random 100 > 2)) or (random 100 < 10)) then {_ied setVariable ["BwS_IED_est_un_IED", false, true];}
			else {[_ied] spawn BwS_IED_fn_Explose_IED};
			
			[[[player], {(_this select 0) playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
			sleep 6.545;
			disableUserInput false;
		},
		[],
		11,
		false,
		true,
		"",
		BwS_IED_cfg_condition_desarmement2
	];
	
	//player addAction _action;
	//player addEventHandler ["Respawn", {player addAction _action}];

	
	BwS_IED_var_action = {[player,
	"Désarmer l'IED",
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",
	BwS_IED_cfg_condition_desarmement2,
	BwS_IED_cfg_condition_desarmement2,
	{
		/*[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
		sleep 4.545;
		[[[player], {(_this select 0) playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
		sleep 6.545;*/
	},
	{},
	{
		cursorObject setVariable ["BwS_IED_est_un_IED", false, true];
		// ajout PB
		{deleteVehicle _x} forEach (cursorObject nearObjects ["DemoCharge_Remote_Ammo", 5]); 

	},
	{
		[cursorObject] spawn BwS_IED_fn_Explose_IED;
	},
	[],
	10,
	11,
	false]};

	(call BwS_IED_var_action) call BIS_fnc_holdActionAdd;

	player addEventHandler ["Respawn", {(call BwS_IED_var_action) call BIS_fnc_holdActionAdd;}];
	
};	

BwS_IED_fn_loop = 
{
	waitUntil {!isNull player};
	
	player addEventHandler ["FiredMan", {if ((cursorObject getVariable ["BwS_IED_est_un_IED", false]) && random(100) < 20) then {[cursorObject] spawn BwS_IED_fn_Explose_IED}}];
	player addEventHandler ["Respawn", {	player addEventHandler ["FiredMan", {if ((cursorObject getVariable ["BwS_IED_est_un_IED", false]) && random(100) < 20) then {[cursorObject] spawn BwS_IED_fn_Explose_IED}}];
}];

	call BwS_IED_fn_addAction2;
	while {true} do
	{
		_distance = 10;
		_IEDs = ((player nearObjects _distance) select {_x getVariable ["BwS_IED_est_un_IED", false]});
		
		if ((count _IEDs > 0) && (side player != BwS_var_side_ennemie)) then // s'il y a des IED à - de _distance m
		{
			_ied = ((nearestObjects [player, [], _distance]) select {_x getVariable ["BwS_IED_est_un_IED", false]}) select 0;
			
			if (_ied getVariable ["BwS_IED_RC", false]) then // si l'IED est contrôlé à distance
			{
				if (alive (_ied getVariable ["BwS_IED_controleur", objNull])) then // si le déclencheur est vivant, peu importe EOD ou pas, boum
				{
					[_ied] call BwS_IED_fn_Explose_IED;
				}
				else // l'observateur n'est plus vivant, l'objet n'est plus un IED
				{
					_ied setVariable ["BwS_IED_est_un_IED", false, true];
				};
			}
			else
			{
				if (!(call BwS_IED_cfg_joueur_EOD) || (abs(speed player) >= 6)) then // si le joueur n'est pas EOD ou s'il va trop vite
				{
					[_ied] call BwS_IED_fn_Explose_IED; // boom
				};
			};
		};
		sleep 1;
	};
};

BwS_fn_pick_random =
{
	private ["_list", "_modifiedList", "_retour"];
	_list = (_this select 0);

    _modifiedList = [];    

	{
    	_elmt = _x;
    	for "_i" from 0 to (_elmt select 1) do
   	 {
   		 _modifiedList pushback (_elmt select 0);
   	 };
	} forEach _list;
	_retour = selectRandom _modifiedList;
	_retour
};

