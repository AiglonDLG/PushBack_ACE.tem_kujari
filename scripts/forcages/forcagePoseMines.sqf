{ 
	{ 
		if (typeOf _x == "O_soldier_exp_F") then {[_x] execVM "scripts\poseMines.sqf";};
	} forEach units _x; 		
} forEach allGroups;