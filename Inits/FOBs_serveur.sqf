BwS_fn_TP_COP_USA = {
	(_this select 0) addAction ["<t color='#00FF00'>BASE</t>", {(_this select 1) setPos (getMarkerPos "respawn_west");}];
	(_this select 0) addAction ["<t color='#555555'>COP #1</t>", {player moveInCargo COP_USA_1; [] spawn BwS_fn_chargement}];
	(_this select 0) addAction ["<t color='#555555'>COP #2</t>", {player moveInCargo COP_USA_2; [] spawn BwS_fn_chargement}];
};

{
	_x addEventHandler ["Respawn", 
		{
			[(_this select 0)] spawn {sleep 2; [(_this select 0)] remoteExec ["BwS_fn_TP_COP_USA", 0, true];};
		}];
} forEach [FOBa/*, FOBb*/];