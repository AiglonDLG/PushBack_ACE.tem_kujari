/*
*	fonctions.sqf
*	[B.w.S] SoP
*	fonctions.sqf du script Helios
*	23/7/2017
*/

BwS_helios_fn_addWP = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "b_plane", "ColorBLUFOR", "Helios WP"] call BwS_helios_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_helios_fn_placer_marqueur =
{
	_ID = str random(100);
	_nom = format ["BwS_helios_marqueur_%1", _ID];
	_mrkr = createMarker [_nom, (_this select 0)];
	_mrkr setMarkerColor (_this select 2);
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerType (_this select 1); 
	_mrkr setMarkerText format ["%1 (ID:%2)", (_this select 3), _ID];
	
	if (count _this > 4) then 
	{
		sleep (_this select 4);
		deleteMarker _mrkr;
	}
	
	else
	{
		_mrkr
	};
};

BwS_helios_fn_construction_WP =
{
	BwS_HELIOS_MENU_SUPP_WP = [["Suppression WP", true]];
	{
		if ((["Helios WP", markerText _x] call BIS_fnc_inString)) then 
		{
			BwS_HELIOS_MENU_SUPP_WP pushBack [markerText _x, [0], "", -5, [["expression", format ["deleteMarker %1", str _x]]], "1", "1"];
		};
	} forEach BwS_helios_marqueurs;
};

BwS_helios_fn_tmp = 
{
	_ID = _this select 0;
	
	_drone = (allUnitsUAV select {(_x getVariable ["BwS_helios_ID", 0]) == _ID}) select 0;
	
	_flux = _drone getVariable ["BwS_helios_flux", "helios"];
	
	_texture = format ["#(argb,512,512,1)r2t(%1,1.0)", _flux];
	
	cursorObject setVariable ["BwS_helios_var_id_source", _id, true]; 
	objet = cursorObject; 
	publicVariable "objet"; 
	cursorObject setObjectTextureGlobal [0, _texture];
};

BwS_helios_fn_construction_sources =
{
	BwS_HELIOS_MENU_CHOIX_STREAM = [["Choix stream", true]];
	{
		_id = _x getVariable ["BwS_helios_ID", 0];
		BwS_HELIOS_MENU_CHOIX_STREAM pushBack [getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName"), [0], "", -5, [["expression", format ["[%1] call BwS_helios_fn_tmp", _id]]], "1", "1"];
	} forEach (allUnitsUAV);
	BwS_HELIOS_MENU_CHOIX_STREAM pushBack ["Satellite", [0], "", -5, [["expression", "cursorObject setVariable [""BwS_helios_var_id_source"", 0, true]; cursorObject setObjectTextureGlobal [0, ""#(argb,512,512,1)r2t(helios,1.0)""];"]], "1", "1"];
};

BwS_helios_fn_loop_client = 
{
	sleep 20;
	BwS_helios_var_desactiver = true;
	helios cameraEffect ["Internal", "BACK", "helios"];	
	helios camSetFov BwS_helios_var_alt;

	helios camCommit 0;
	_prevDesact = BwS_helios_var_desactiver;
	
	while {true} do
	{
		BwS_helios_marqueurs = allMapMarkers select {(["helios", _x] call BIS_fnc_inString)};
		
		call BwS_helios_fn_construction_WP;
		call BwS_helios_fn_construction_sources;
		
		if !(BwS_helios_var_desactiver) then 
		{
			if !(_prevDesact isEqualTo BwS_helios_var_desactiver) then {_prevDesact = BwS_helios_var_desactiver;};
			helios cameraEffect ["Internal", "BACK", "helios"];  
			
			{
				_drone = _x;
				_cameraDrone = _drone getVariable ["BwS_helios_camera", helios];
				_flux = _drone getVariable ["BwS_helios_flux", "helios"];
				_cameraDrone cameraEffect ["Internal", "Back", _flux];
				
			} forEach allUnitsUAV;
		} else
		{
			if !(_prevDesact isEqualTo BwS_helios_var_desactiver) then 
			{
				helios cameraEffect ["Terminate", "BACK", "helios"];  
				
				{
					_drone = _x;
					_cameraDrone = _drone getVariable ["BwS_helios_camera", helios];
					_cameraDrone cameraEffect ["Terminate", "Back", toLower((name driver _drone))];
					
				} forEach allUnitsUAV;
				_prevDesact = BwS_helios_var_desactiver;
			};
		};
		
		sleep 1;
	};
};

BwS_helios_fn_loop_serveur = 
{
	helios = "camera" createVehicle [10000, 10000, 300];
	helios cameraEffect ["Internal", "BACK", "helios"];
	[helios, ["Internal", "BACK", "helios"]] remoteExec ["cameraEffect", 0, true];
	
	BwS_helios_var_alt = 0.75;
	BwS_helios_var_vit = 100;
	
	helios camSetDir [0,0.01,-1];
	[helios, [0,0.01,-1]] remoteExec ["camSetDir", 0, true];	
	
	helios camSetFov BwS_helios_var_alt;
	[helios, BwS_helios_var_alt] remoteExec ["camSetFov", 0, true];

	helios camCommit 0;
	[helios, 0] remoteExec ["camCommit", 0, false];

	publicVariable "BwS_helios_var_alt";
	publicVariable "BwS_helios_var_vit";
	publicVariable "helios";
	
	_mrkr = createMarker ["satellite", position helios];
	_mrkr setMarkerColor "ColorBLUFOR";
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerType "b_uav"; 
	_mrkr setMarkerText "Satellite";
	
	_mrkr2 = createMarker ["helios", [0,0,300]];
	_mrkr2 setMarkerShape "ICON";
	_mrkr2 setMarkerType "Empty"; 
	_mrkr2 setMarkerText "";	
	
	_zone = createMarker ["zone_sat", [0,0,0]];
	_zone setMarkerShape "ELLIPSE";
	_zone setMarkerBrush "Border";
	_zone setMarkerColor "ColorBlack";
	
	0 spawn BwS_helios_gestion_passages;
	_prev = BwS_helios_var_alt;
	while {true} do
	{
		_ecrans = (station_helios nearObjects 20) select {typeOf _x in ["Land_TripodScreen_01_large_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_BriefingRoomScreen_01_F"]};
		
		{
			_ecran = _x;
			if !(_ecran getVariable ["BwS_helios_connected", false]) then
			{
				_ecran setVariable ["BwS_helios_connected", true, true];
				_ecran setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(helios,1.0)"];
			};
		} forEach (_ecrans);
		
		_mrkr setMarkerPos (position helios);
		_mrkr2 setMarkerPos (position helios);
		_zone setMarkerPos (position helios);
		
		_rayon = 300*BwS_helios_var_alt;
		_zone setMarkerSize [_rayon, _rayon];
		
		if (BwS_helios_var_alt != _prev) then
		{
			helios camSetFov BwS_helios_var_alt;
			[helios, BwS_helios_var_alt] remoteExec ["camSetFov", 0, false];
			helios camCommit 0;	
			[helios, 0] remoteExec ["camCommit", 0, false];
			
			_prev = BwS_helios_var_alt;
		};

		{
			if !(_x getVariable ["BwS_helios_var_monitored", false]) then
			{
				_x setVariable ["BwS_helios_var_monitored", true, true];
				_x spawn {
					sleep 3;
					_drone = _this;
					_cameraDrone = "camera" createVehicle [0,0,0];
					_drone setVariable ["BwS_helios_flux", ((toLower((name driver _drone)) splitString " ") joinString ""), true];
					_drone setVariable ["BwS_helios_camera", _cameraDrone, true];
					_drone setVariable ["BwS_helios_ID", round(random(1000)), true];
					_cameraDrone cameraEffect ["Internal", "Back", toLower((name driver _drone))];
					
					_dirG = getText (configfile >> "CfgVehicles" >> typeOf _drone >> "uavCameraGunnerDir");
					_posG = getText (configfile >> "CfgVehicles" >> typeOf _drone >> "uavCameraGunnerPos");
					
					_cameraDrone attachTo [_drone, [0,0,0], _posG];
					while {true} do 
					{
						_dir = 
							(_drone selectionPosition _posG) 
								vectorFromTo 
							(_drone selectionPosition _dirG);
						_cameraDrone setVectorDirAndUp [
							_dir, 
							_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
						];
						sleep 0.1;
					};
				};
			};
		} forEach allUnitsUAV;
		
		sleep 0.01;
	};
};

BwS_helios_gestion_passages =
{
	while {true} do
	{
		_WPs = allMapMarkers select {(["helios", _x] call BIS_fnc_inString)};
		_WP = _WPs apply {markerPos _x};
		{
			_dist = (position helios) distance2D _x;
						
			helios camSetPos (_x vectorAdd [0,0, 300]);
			[helios, (_x vectorAdd [0,0, 300])] remoteExec ["camSetPos", 0, false];
			helios camCommit (_dist/BwS_helios_var_vit);
			[helios, (_dist/BwS_helios_var_vit)] remoteExec ["camCommit", 0, false];
			
			sleep (_dist/BwS_helios_var_vit);
		} forEach _WP;
		sleep 0.01;
	};
};

BwS_helios_fn_vision =
{
	_ecran = _this select 0;
	_facteur = _this select 1;
	_source_id = _ecran getVariable ["BwS_helios_var_id_source", 0];
	
	_drone = (allUnitsUAV select {(_x getVariable ["BwS_helios_ID", 0]) == _source_id}) select 0;
	
	_flux = if (_source_id != 0) then { _drone getVariable ["BwS_helios_flux", "helios"]} else {"helios"};
	[_flux, [_facteur]] remoteExec ["setPiPEffect", 0, false]
};

BwS_helios_fn_zoom =
{
	_ecran = _this select 0;
	_facteur = if ("+" in _this) then {-0.1} else {0.1};
	_source_id = _ecran getVariable ["BwS_helios_var_id_source", 0];
	
	_drone = (allUnitsUAV select {(_x getVariable ["BwS_helios_ID", 0]) == _source_id}) select 0;
	
	_fov = _drone getVariable ["BwS_helios_var_fov", 0.75];
	_drone setVariable ["BwS_helios_var_fov", _fov+_facteur, true];
	_source = _drone getVariable ["BwS_helios_camera", helios];
	[_source, _drone getVariable ["BwS_helios_var_fov", 0.75]] call BwS_helios_fn_change_fov;
};

BwS_helios_fn_change_fov =
{
	_cam = _this select 0;
	_fov = _this select 1;
	
	_cam camSetFov _fov;
	[_cam, _fov] remoteExec ["camSetFov", 0, false];
	_cam camCommit 0;	
	[_cam, 0] remoteExec ["camCommit", 0, false];
};




