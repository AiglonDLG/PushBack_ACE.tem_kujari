/*
*	fonctions.sqf
*	[B.w.S] SoP
*	
*	25/7/2018
*/

BwS_OPFOR_fn_update_marqueurs =
{
	_marqueurs = [];
	_groupes = allGroups select {side _x == BwS_OPFOR_cfg_side_OPFOR};

	{
		_groupe = _x;
		_ID = str _groupe;
		_nom = format ["BwS_OPFOR_marqueur_%1", _ID];
		_marqueurs pushBack _nom;
		if !(_nom in allMapMarkers) then
		{
			_mrkr = createMarkerLocal [_nom, position leader _groupe];
			_mrkr setMarkerColorLocal "colorIndependent";
			_mrkr setMarkerShapeLocal "ICON";
			_mrkr setMarkerTypeLocal "n_inf"; 
			_mrkr setMarkerTextLocal format ["%1 (%2 pax)", str(_groupe), count units _groupe];
		}
		else
		{
			_nom setMarkerPosLocal (position leader _groupe);
			_nom setMarkerTextLocal format ["%1 (%2 pax)", str(_groupe), count units _groupe];
		};
		
	} forEach _groupes;

	{
		if !(_x in _marqueurs) then
		{
			deleteMarkerLocal _x;
		};
	} forEach (allMapMarkers select {["BwS_OPFOR_marqueur", _x] call BIS_fnc_inString});
};

BwS_OPFOR_fn_update_menus =
{
	BwS_OPFOR_MENU_CHOIX_GROUPE =
	[
		["Choix du groupe", true],
		["Aucun", [2], "", -5, [["expression", "[player] join grpNull"]], "1", "1"]
	];

	BwS_OPFOR_MENU_COMMANDEMENT_GROUPE =
	[
		["Commandement à distance", true]
	];

	_groupes = allGroups select {side _x == BwS_OPFOR_cfg_side_OPFOR};
	{
		_grp = _x;

		_tab = [str(_grp), [_forEachIndex+3], "", -5, [["expression", format ["[""%1""] spawn BwS_OPFOR_fn_change_groupe", str _grp]]], "1", "1"];
		BwS_OPFOR_MENU_CHOIX_GROUPE pushBack _tab;

		_tab = [str(_grp), [_forEachIndex+2], "", -5, [["expression", format ["[""%1""] spawn BwS_OPFOR_fn_ordonne_groupe", str _grp]]], "1", "1"];
		BwS_OPFOR_MENU_COMMANDEMENT_GROUPE pushBack _tab;

	} forEach _groupes;
};

BwS_OPFOR_fn_client =
{
	while {true} do
	{
		if (side player == BwS_OPFOR_cfg_side_OPFOR) then
		{
			0 spawn BwS_OPFOR_fn_update_marqueurs;
			0 spawn BwS_OPFOR_fn_update_menus;
		};
		sleep 1;
	};
};

BwS_OPFOR_fn_change_groupe =
{
	_grp = [_this select 0] call BwS_OPFOR_fn_group_from_text;

	if !(_grp isEqualTo grpNull) then
	{
		_telep_ok = (count(allPlayers select {side _x != BwS_OPFOR_cfg_side_OPFOR && ((leader _grp) distance _x < 500)}) == 0);
		if (_telep_ok) then
		{
			player setPos (position leader _grp);
			[player] join grpNull;
			[player] join _grp;
			sleep 0.1;
			[group player, player] remoteExec ["selectLeader", groupOwner group player];
		};
	};
};

BwS_OPFOR_fn_ordonne_groupe =
{
	_grp = [_this select 0] call BwS_OPFOR_fn_group_from_text;

	if !(_grp isEqualTo grpNull) then
	{
		openMap true;
		systemChat "Cliquez sur la destination du groupe";
		[_grp] onMapSingleClick 
		{		
			[_this select 0, _pos] spawn
			{
				(_this select 0) move (_this select 1);
				[(_this select 0), (_this select 1)] remoteExec ["move", groupOwner (_this select 0)];
			};
			openMap false;
			onMapSingleClick ""
		};

	};
};

BwS_OPFOR_fn_group_from_text = 
{
	_text = _this select 0;
	_grp = grpNull;
	_groupes = allGroups select {side _x == BwS_OPFOR_cfg_side_OPFOR};
	{
		if ([_text, str(_x)] call BIS_fnc_inString) then
		{
			_grp = _x;
		};
	} forEach _groupes;
	_grp
}