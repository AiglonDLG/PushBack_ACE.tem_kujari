BwS_EBN_fn_marquer_sa_position =
{
	onMapSingleClick 
	{		
		_nomMarker = format ["BwS_EBN_marqueur_groupe_%1", (player getVariable ["BwS_groupe", "XRay"])];
		_nomMarker setMarkerAlpha 1;
		_nomMarker setMarkerPos _pos;
				
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_EVASAN =
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "b_med", "ColorBLUFOR", "EVASAN"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_ART =
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "b_art", "ColorBLUFOR", "ART"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_OBS =
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "b_uav", "ColorBLUFOR", "OBS"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_pedestre = 
{
	[_this select 0] onMapSingleClick 
	{		
		[_pos, _this select 0] spawn
		{
			[(_this select 0), "o_inf", "ColorOPFOR", format ["PAT %1 pax", (_this select 1)]] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_vehicule = 
{
	[_this select 0] onMapSingleClick 
	{		
		[_pos, _this select 0] spawn
		{
			[(_this select 0), "o_mech_inf", "ColorOPFOR", format ["VEH %1", (_this select 1)]] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_usine = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "respawn_armor", "ColorOPFOR", "Usine"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_caserne = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "respawn_inf", "ColorOPFOR", "Caserne"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_camp = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "respawn_inf", "ColorOPFOR", "Camp"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_VHL = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "b_motor_inf", "ColorBLUFOR", "VHL à recup"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_OBJ = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "hd_objective", "ColorRed", "OBJ"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_CLAIR = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "hd_flag", "ColorGreen", "Clair"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_IED = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			[(_this select 0), "hd_warning", "ColorRed", "Mine/IED"] call BwS_EBN_fn_placer_marqueur;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_marquer_GPS = 
{
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			_mrkr = [(_this select 0), "respawn_plane", "ColorBLUFOR", "GPS TARGET"] call BwS_EBN_fn_placer_marqueur;
			_laser = "LaserTargetW" createVehicle (getMarkerPos _mrkr);
			waitUntil {
				_laser setPos [markerPos _mrkr select 0, markerPos _mrkr select 1, 5];
				sleep 0.01;
				(getMarkerColor _mrkr == "")
			};
			deleteVehicle _laser;
		};
		onMapSingleClick ""
	};
};

BwS_EBN_fn_placer_marqueur =
{
	_ID = str random(100);
	_nom = format ["BwS_EBN_marqueur_%1", _ID];
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

