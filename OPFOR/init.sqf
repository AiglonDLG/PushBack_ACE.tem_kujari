/*
*	init.sqf
*	[B.w.S] SoP
*	OPFOR system for Arma
*	25/7/2018
*/

nul = [] execVM "OPFOR\config.sqf";
sleep 1;
nul = [] execVM "OPFOR\fonctions.sqf";
sleep 1;
if (isServer) then
{
};

if (hasInterface) then
{
	0 spawn BwS_OPFOR_fn_client; 
	BwS_OPFOR_var_action_groupe = 
		["<t color='#CC2222'>Téléportation vers groupe</t>", 
		{showCommandingMenu "#USER:BwS_OPFOR_MENU_CHOIX_GROUPE"}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"side player == BwS_OPFOR_cfg_side_OPFOR"];
	player addAction BwS_OPFOR_var_action_groupe;
	player addEventHandler ["Respawn", {player addAction BwS_OPFOR_var_action_groupe}];
	BwS_OPFOR_var_action_groupe_commandement = 
		["<t color='#CC2222'>Commandement groupe</t>", 
		{showCommandingMenu "#USER:BwS_OPFOR_MENU_COMMANDEMENT_GROUPE"}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"side player == BwS_OPFOR_cfg_side_OPFOR"];
	player addAction BwS_OPFOR_var_action_groupe_commandement;
	player addEventHandler ["Respawn", {player addAction BwS_OPFOR_var_action_groupe_commandement}];
};