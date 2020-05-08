
BwS_compilation_client = [] execVM "scripts\systemes\compilation_client.sqf";

waitUntil {scriptDone BwS_compilation_client};

if (hasInterface) then 
{
	// startLoadingScreen ["Loading mission, please wait..."];
	
	BwS_MUTEX_action_en_cours = false;
	BwS_MUTEX_peut_rejoindre_champ_de_bataille = true;
	BwS_var_dommages_autorises = true;
	BwS_joueur_est_en_train_de_detecter = false;
	
	nul = [] execVM "scripts\FOB.sqf";
//	nul = [] execVM "scripts\gestions\COPs_client.sqf";
	nul = [] execVM "Inits\initFOBs.sqf";
	nul = [] execVM "Inits\initMenus.sqf";
	nul = [] execVM "Inits\initMarkers.sqf";
	nul = [] execVM "scripts\detecteurMines.sqf";
	nul = [] execVM "Inits\briefing.sqf";
	
	if (!(["[B.w.S]", name player] call BIS_fnc_inString)) then {nul = [] execVM "intro.sqf";};

	if ("task_force_radio" in activatedAddons) then 
	{
		["TFAR_EH_communique", "OnTangent", {
			_unit = _player select 0;
			_est_en_train_de_parler = _player select 4;
			_unit setVariable ["BwS_var_est_en_train_de_transmettre", _est_en_train_de_parler, true];
		}, player] call TFAR_fnc_addEventHandler;
	};

	player addEventHandler ["FiredNear", {[] spawn {BwS_thirdPerson_allowed = false; sleep 120; BwS_thirdPerson_allowed = true;}}];

	["BwS_EH_gestion_3rd_personne", "onEachFrame", 
	{	
		if (!BwS_thirdPerson_allowed) then 
		{
			if (cameraView == "EXTERNAL") then 
			{	
				player switchCamera "INTERNAL";
			};
		};
	}, []] call BIS_fnc_addStackedEventHandler; 
	
	joueurDroniste = false;
	joueurEOD = false;
	joueurPilote = false;
	
	if ((player getVariable "pilote") isEqualTo true) then {joueurPilote = true;};
	if ((player getVariable "BwS_var_joueur_est_EOD") isEqualTo true) then {joueurEOD = true;};
	if ((player getVariable "droniste") isEqualTo true) then {joueurDroniste = true;};
	
	if (side player != BwS_var_side_ennemie) then 
	{
		removeAllWeapons player;
		removeAllItems player;
		removeAllAssignedItems player;
		removeUniform player;
		removeVest player;
		removeBackpack player;
		removeHeadgear player;
		removeGoggles player;

		player addWeapon "R3F_HK416M";
		player addPrimaryWeaponItem "R3F_30Rnd_556x45_HK416";

		player forceAddUniform "R3F_uniform_apso_DA";
		player addVest "R3F_veste_TAN";

		for "_i" from 1 to 2 do {player addItemToUniform "R3F_30Rnd_556x45_HK416";};
		for "_i" from 1 to 3 do {player addItemToUniform "R3F_securite_mag";};
		for "_i" from 1 to 2 do {player addItemToVest "ACE_morphine";};
		for "_i" from 1 to 2 do {player addItemToVest "ACE_packingBandage";};
		for "_i" from 1 to 2 do {player addItemToVest "ACE_elasticBandage";};
		player addItemToVest "ACE_tourniquet";
		for "_i" from 1 to 2 do {player addItemToVest "ACE_quikclot";};
		for "_i" from 1 to 5 do {player addItemToVest "ACE_fieldDressing";};
		for "_i" from 1 to 5 do {player addItemToVest "R3F_30Rnd_556x45_HK416";};
		for "_i" from 1 to 2 do {player addItemToVest "R3F_Grenade_df_mag";};
		player addHeadgear "R3F_casque_spectra_DA";

		[player,"OperationPushBack"] call BIS_fnc_setUnitInsignia;

		player linkItem "ItemMap";
		player linkItem "ItemCompass";
		player linkItem "tf_microdagr";
		player linkItem "tf_anprc152_1";
		player addItem "ace_earplugs";

		player setPos markerPos "respawn_west";
	};
	// nul = [] spawn BwS_fn_afficher_marqueurs;
	
};