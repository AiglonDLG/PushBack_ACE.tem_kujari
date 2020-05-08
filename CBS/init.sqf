/*
*	init.sqf
*	[B.w.S] SoP
*	CBS - Civilian Behavior Simulator 
*	Simule des comportements civils réalistes
*	19/7/2018
*/

if (isServer) then
{
	nul = [] execVM "CBS\config.sqf";
	sleep 1;
	nul = [] execVM "CBS\fonctions.sqf";
	sleep 1;

	construction = 0 spawn BwS_CBS_fn_construction_locations;

	waitUntil {scriptDone construction};
	
	{
		[_x] spawn BwS_CBS_fn_init_location;
	} forEach BwS_CBS_cfg_locations;
};