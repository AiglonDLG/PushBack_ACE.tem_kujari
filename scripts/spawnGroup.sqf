// [_position, _nombre(, _type, _faction, special)] call BwS_fn_spawnGroup;

private ["_position",
"_eastHQ",
"_group",
"_soldats",
"_nombre"];

_position = (_this select 0);
_nombre = (_this select 1);
_type = (_this select 2);

_position = if ("CAN_COLLIDE" in _this) then {_position} else {[_position, 0, 50, 5, 0, -1, 0] call BwS_fn_findSafePos};

if (count _this >= 4) then {_eastHQ = createCenter (_this select 3);}
else {_eastHQ = createCenter East;};

_group = createGroup _eastHQ;

_soldats = ["B_G_Soldier_LAT_F",
		"B_G_Soldier_AR_F",
		"B_G_Soldier_GL_F",
		"B_G_soldier_exp_F",
		"B_G_medic_F",
		"B_G_Soldier_F",
		"B_G_Sharpshooter_F",
		"O_Soldier_AA_F"];

if (count _this >= 3) then {
	if (_type == East) then 
	{
		_soldats = [];
		_soldats = [["O_V_Soldier_TL_ghex_F", 5],
				["O_V_Soldier_JTAC_ghex_F", 1],
				["O_V_Soldier_M_ghex_F", 1],
				["O_V_Soldier_Exp_ghex_F", 1],
				["O_V_Soldier_LAT_ghex_F", 1],
				["O_V_Soldier_Medic_ghex_F", 1],
				["O_T_Soldier_SL_F", 1],
				["O_T_Soldier_AR_F", 5],
				["O_T_Soldier_GL_F", 3],
				["O_T_Soldier_M_F", 1],
				["O_T_Soldier_AT_F", 1],
				["O_T_Soldier_AAT_F", 1],
				["O_T_Soldier_A_F", 1],
				["O_T_Medic_F", 1]];
	};

	if (_type == West) then 
	{
		_soldats = [];
		_soldats = [["B_Soldier_LAT_F",1],
			["B_Soldier_AR_F",1],
			["B_Soldier_GL_F",1],
			["B_soldier_exp_F",1],
			["B_medic_F",1],
			["B_Soldier_F",1],
			["B_Sharpshooter_F",1],
			["B_Soldier_AA_F",1]];
	};
	
	if (_type == resistance) then
	{
		_soldats = [];
		// _soldats = [["I_Soldier_SL_F", 1],
				// ["I_Soldier_AR_F", 1],
				// ["I_Soldier_GL_F", 1],
				// ["I_Soldier_M_F", 1],
				// ["I_Soldier_AT_F", 1],
				// ["I_Soldier_AAT_F", 1],
				// ["I_Soldier_A_F", 1],
				// ["I_medic_F", 1],
				// ["I_Soldier_SL_F", 1],
				// ["I_soldier_F", 1],
				// ["I_Soldier_LAT_F", 1],
				// ["I_Soldier_M_F", 1],
				// ["I_Soldier_TL_F", 1],
				// ["I_Soldier_AR_F", 1],
				// ["I_Soldier_A_F", 1],
				// ["I_medic_F", 1],
				// ["I_Soldier_TL_F", 1],
				// ["I_Soldier_AT_F", 1],
				// ["I_Soldier_AT_F", 1],
				// ["I_Soldier_AAT_F", 1],
				// ["I_Soldier_TL_F", 1],
				// ["I_Soldier_AA_F", 1],
				// ["I_Soldier_AA_F", 1],
				// ["I_Soldier_AAA_F", 1],
				// ["I_Sniper_F", 1],
				// ["I_Spotter_F", 1],
				// ["I_Soldier_TL_F", 1],
				// ["I_Soldier_AR_F", 1],
				// ["I_Soldier_GL_F", 1],
				// ["I_Soldier_LAT_F", 1],
				// ["I_Soldier_GL_F", 1],
				// ["I_soldier_F", 1]];
		_soldats = [["I_C_Soldier_Para_5_F",1],
			["I_C_Soldier_Para_1_F",1],
			["I_C_Soldier_Para_8_F",1],
			["I_C_Soldier_Para_4_F",1],
			["I_C_Soldier_Para_3_F",1],
			["I_C_Soldier_Para_2_F",1],
			["I_C_Soldier_Para_7_F",1],
			["I_C_Soldier_Para_6_F",1],
			["I_C_Soldier_Bandit_5_F",1],
			["I_C_Soldier_Bandit_6_F",1],
			["I_C_Soldier_Bandit_3_F",1],
			["I_C_Soldier_Bandit_8_F",1],
			["I_C_Soldier_Bandit_2_F",1],
			["I_C_Soldier_Bandit_4_F",1],
			["I_C_Soldier_Bandit_7_F",1],
			["I_C_Soldier_Bandit_1_F",1],
			["I_G_Sharpshooter_F",1]];
	};
	
	if (_type == Civilian) then
	{
				_soldats = [["C_man_1",1],
		["C_man_1_1_F",1],
		["C_man_1_2_F",1],
		["C_man_1_3_F",1],
		["C_man_polo_1_F",1],
		["C_man_polo_2_F",1],
		["C_man_polo_3_F",1],
		["C_man_polo_4_F",1],
		["C_man_polo_5_F",1],
		["C_man_polo_6_F",1],
		["C_Orestes",1],
		["C_Nikos",1],
		["C_man_p_fugitive_F",1],
		["C_man_p_fugitive_F_afro",1],
		["C_man_p_fugitive_F_euro",1],
		["C_man_p_fugitive_F_asia",1],
		["C_man_p_beggar_F",1],
		["C_man_p_beggar_F_afro",1],
		["C_man_p_beggar_F_euro",1],
		["C_man_p_beggar_F_asia",1],
		["C_man_w_worker_F",1],
		["C_man_hunter_1_F",1],
		["C_man_p_shorts_1_F",1],
		["C_man_p_shorts_1_F_afro",1],
		["C_man_p_shorts_1_F_euro",1],
		["C_man_p_shorts_1_F_asia",1],
		["C_man_shorts_1_F",1],
		["C_man_shorts_1_F_afro",1],
		["C_man_shorts_1_F_euro",1],
		["C_man_shorts_1_F_asia",1],
		["C_man_shorts_2_F",1],
		["C_man_shorts_2_F_afro",1],
		["C_man_shorts_2_F_euro",1],
		["C_man_shorts_2_F_asia",1],
		["C_man_shorts_3_F",1],
		["C_man_shorts_3_F_afro",1],
		["C_man_shorts_3_F_euro",1],
		["C_man_shorts_3_F_asia",1],
		["C_man_shorts_4_F",1],
		["C_man_shorts_4_F_afro",1],
		["C_man_shorts_4_F_euro",1],
		["C_man_shorts_4_F_asia",1],
		["C_man_pilot_F",1],
		["C_man_polo_1_F_afro",1],
		["C_man_polo_1_F_euro",1],
		["C_man_polo_1_F_asia",1],
		["C_man_polo_2_F_afro",1],
		["C_man_polo_2_F_euro",1],
		["C_man_polo_2_F_asia",1],
		["C_man_polo_3_F_afro",1],
		["C_man_polo_3_F_euro",1],
		["C_man_polo_3_F_asia",1],
		["C_man_polo_4_F_afro",1],
		["C_man_polo_4_F_euro",1],
		["C_man_polo_4_F_asia",1],
		["C_man_polo_5_F_afro",1],
		["C_man_polo_5_F_euro",1],
		["C_man_polo_5_F_asia",1],
		["C_man_polo_6_F_afro",1],
		["C_man_polo_6_F_euro",1],
		["C_man_polo_6_F_asia",1]];
	};
};

diag_log format ["Creation d'un groupe aux coordonnées %1", _position];

for "_i" from 0 to (_nombre - 1) do 
{
	([_soldats] call BwS_fn_pick_random) createUnit [_position, _group, "", 0.7];
	// ([_soldats] call BwS_fn_pick_random) createUnit [_position, _group, "this addItem ""NVGoggles""; this assignItem ""NVGoggles"" ", 1];
};

{	[_x] spawn BwS_fn_gestion_radio;	} forEach units _group;

if (_type != WEST) then
{
	_suicideBombers = (units _group) select {if (random 100 < 10) then {true} else {false}};
	{
		_unit = _x;
		_unit setVariable ["BwS_IED_est_un_IED", true, true];
		_explosif1 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
		_explosif1 attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis"];
		_explosif1 setVectorDirAndUp [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ];
		_explosif2 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
		_explosif2 attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
		_explosif2 setVectorDirAndUp [ [1, 0, 0], [0, 1, 0] ];
		_explosif3 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
		_explosif3 attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis"];
		_explosif3 setVectorDirAndUp [ [0.5, -0.5, 0], [0.5, 0.5, 0] ];
	} forEach _suicideBombers;

	_intels = (units _group) select {if (random 100 < 25) then {true} else {false}};
	{
		[[_x], "BwS_fn_ajouter_rens_npc", west, true] call BIS_fnc_MP;
	} forEach _intels;
};

_group enableDynamicSimulation true; 

_group
