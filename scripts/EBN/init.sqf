_compil = [] execVM "scripts\EBN\compilation.sqf";
waitUntil {scriptDone _compil};

_compil = [] execVM "scripts\EBN\config.sqf";
waitUntil {scriptDone _compil};

_compil = [] execVM "scripts\EBN\menus.sqf";
waitUntil {scriptDone _compil};

if (isServer) then
{
	nul = [] execVM "scripts\EBN\markers.sqf"; 
};

if (hasInterface) then 
{
	waitUntil {!isNull player};
	sleep 3;
	BwS_EBN_var_action_EBN = 
		["<t color='#CC2222'>Espace de Bataille Numérique (EBN)</t>", 
		{showCommandingMenu "#USER:BwS_MENU_EBN"}, 
		[], 
		1, 
		false, 
		true, 
		"User1",
		BwS_EBN_cfg_condition_EBN];
	player addAction BwS_EBN_var_action_EBN;
	player addEventHandler ["Respawn", {player addAction BwS_EBN_var_action_EBN}];

	while {true} do
	{
		 call BwS_fn_construction_menus_marqueurs;
		 sleep 2; // pas besoin à chaque frame
	};
};