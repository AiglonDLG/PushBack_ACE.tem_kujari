private ["_centerMap"];
_centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

while {playerInHQ} do 
{
	_objets = (/*(nearestObjects [_centerMap, ["SubmunitionBase", "MissileBase", "BombBase"], 20000]) + */(_centerMap nearEntities ["Air", 20000]));
	//_objets = _objets unitsBelowHeight 15;

	[_centerMap, 20000] call BwS_fn_detecter_radios;
	
	{
		[_x, 654] execVM "scripts\HQ\traqueur.sqf";			
	} forEach _objets;
	sleep 1;	
	
	{ 
		private ["_a"]; 
		_a = toArray _x; 
		_a resize 5;
		if (toString _a == "radar") then 
		{ 
			deleteMarker _x; 
		};
	} forEach allMapMarkers;
};

