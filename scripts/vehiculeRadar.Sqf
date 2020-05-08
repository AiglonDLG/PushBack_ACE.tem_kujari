 
[position player, 4000] call BwS_fn_detecter_radios;

{
	if (getPosATL _x select 2 > 15) then 
	{	
		if ((_x isKindOf "MissileBase") || (_x isKindOf "BombBase") || (_x isKindOf "Air") || (sizeof(typeof(_x)) > 4)) then
		{
			[_x, 654] execVM "scripts\HQ\traqueur.sqf";
		};			
	};
} forEach ((position player) nearObjects 4000);

sleep 1;

[] call BwS_fn_RADAR_effacer_marqueurs;
