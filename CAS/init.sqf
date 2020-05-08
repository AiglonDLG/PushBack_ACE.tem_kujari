/*
*	init.sqf
*	[B.w.S] SoP
*	init du script Close Air Support
*	24/10/2017
*/

call compile preprocessFile "CAS\config.sqf";
call compile preprocessFile "CAS\fonctions.sqf";
call compile preprocessFile "CAS\menus.sqf";

sleep 0.1;

if (isServer) then
{
	0 spawn BwS_CAS_server_loop;
};

if (hasInterface) then // cote client
{
	player addAction BwS_CAS_cfg_action_request;
	player addEventHandler ["Respawn", {player addAction BwS_CAS_cfg_action_request}];
	
	0 spawn BwS_CAS_fn_loop_client;
};

