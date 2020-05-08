{
	if (count units _x == 0) then
	{
		deleteGroup _x;
	};
	sleep 0.01;
} forEach allGroups;

{
	_x enableSimulationGlobal true;
	deleteVehicle _x; 
} forEach allDead;

diag_log format ["REPORT FPS serveur : %1 Nombre d'ennemis : %2 Nombre de joueurs : %3", diag_fps, { side _x == bws_var_side_ennemie } count allunits, count allPlayers];