/*
*	init.sqf
*	[B.w.S] SoP
*	init.sqf du script Helios
*	23/7/2017
*/

call compile preprocessFile "helios\config.sqf";
call compile preprocessFile "helios\fonctions.sqf";

sleep 0.01;

if (isServer) then
{
	0 spawn BwS_helios_fn_loop_serveur;
};

if (hasInterface) then // cote client
{
	player addAction BwS_helios_cfg_action_ecran;
	player addEventHandler ["Respawn", {player addAction BwS_helios_cfg_action_ecran}];
	
	station_helios addAction BwS_helios_cfg_action_station_helios;
	0 spawn BwS_helios_fn_loop_client;
};

