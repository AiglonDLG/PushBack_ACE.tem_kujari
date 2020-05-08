_position = (_this select 0);
_positionBase = [3969.64,4035.36,0.00143862];

_objects = [["Land_CampingTable_F",[3979.49,4040.71,0.0249543],270.337],
["Land_PCSet_01_screen_F",[3979.56,4041.32,0.0566816],69.9169],
["Land_PCSet_01_screen_F",[3979.69,4040.72,0.0567489],91.1404],
["Land_PCSet_01_screen_F",[3979.52,4040.12,0.0566702],124.05],
["Land_PCSet_01_keyboard_F",[3979.4,4040.74,0.576674],90.4099],
["Land_CampingChair_V1_F",[3978.15,4041.41,0.0219216],338.94],
["Land_PCSet_01_case_F",[3979.56,4040.05,0.0250049],88.5929],
["Land_CampingChair_V1_F",[3978.95,4040.19,0.021924],270.092],
["Land_CampingChair_V1_F",[3975.1,4041.57,0.021924],268.595],
["Land_Laptop_unfolded_F",[3979.74,4038.42,0.0250001],266.634],
["Land_Laptop_unfolded_F",[3979.72,4038.91,0.0250001],267.394],
["Land_Laptop_unfolded_F",[3979.76,4039.4,0.0250001],266.9],
["Land_Laptop_unfolded_F",[3979.82,4037.83,0.0250001],265.472]];

{ 
	_temp = createVehicle [(_x select 0), ([_position, [_positionBase, _x select 1] call BwS_fn_substractArray] call BwS_fn_addArray), [], 0, "CAN_COLLIDE"];
	_temp setDir (_x select 2);
	//_temp setVectorUp surfaceNormal position _temp;
	_temp setPosATL [position _temp select 0, position _temp select 1, position _temp select 2];
	
	if (((_x select 0) == "Land_PCSet_01_screen_F") or
		((_x select 0) == "Land_Laptop_unfolded_F")) then
	{
		[[[_temp],"scripts\HQ\retransmission.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;
		//[_temp] execVM "scripts\HQ\retransmission.sqf";
		_temp setPosATL [position _temp select 0, position _temp select 1, 1];
		_temp setDir ((direction _temp) - 180);
	};
	
} forEach _objects;