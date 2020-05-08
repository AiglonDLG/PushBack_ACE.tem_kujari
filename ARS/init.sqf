/*
*	ARS - Advanced Radar Simulation
*	[B.w.S] SoP
*		
*	Simulates radar and counter-measures
*	Air targets for AAM
*	GPS targets for GBU
*	Ground targets for AGM
*	17/08/2016
*/

execVM "ARS\config.sqf";
call compile preprocessFile "ARS\fonctions.sqf";
call compile preprocessFile "ARS\GBU.sqf";
call compile preprocessFile "ARS\menus.sqf";

if (hasInterface) then
{
	waitUntil {!isNull player};
	sleep 2;
	0 spawn BwS_ARS_fn_loop;
};

if (isServer) then
{
	BwS_ARS_var_missiles = [];
	BwS_ARS_var_leurres = [];
	BwS_ARS_AGM_var_vehicules = [];
	publicVariable "BwS_ARS_var_missiles";
	publicVariable "BwS_ARS_var_leurres";	
	publicVariable "BwS_ARS_AGM_var_vehicules";
	BwS_ARS_init_done = false;
	publicVariable "BwS_ARS_init_done";
	sleep 15;
	BwS_ARS_init_done = true;
	publicVariable "BwS_ARS_init_done";
	// while {true} do
	// {
		
		// sleep 1;
	// };
};