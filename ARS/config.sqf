BwS_ARS_cfg_portee_MAWS 					= 10000; // 10 km
BwS_ARS_cfg_portee_radar 					= 20000; // 20km
BwS_ARS_cfg_portee_radar_passif 			= 30000; // 30km
BwS_ARS_cfg_duree_brouillage_mecanique 		= 10; // 15 sec
BwS_ARS_cfg_duree_brouillage_electronique 	= 10; // 10 sec
BwS_ARS_cfg_lock_cone_missiles_cos			= 0.9;

BwS_ARS_cfg_vehicules_radar =
[
	"Land_Radar_F",
	"Land_Radar_Small_F"
];

BwS_ARS_cfg_avions = 
[
	"O_Plane_CAS_02_dynamicLoadout_F",
	"O_Plane_Fighter_02_Stealth_F",
	"O_Plane_Fighter_02_F",
	"O_T_VTOL_02_vehicle_F",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_F",
	"B_Plane_Fighter_01_Stealth_F",
	"B_T_VTOL_01_vehicle_F",
	"I_Plane_Fighter_03_dynamicLoadout_F",
	"I_Plane_Fighter_04_F",
	"RHS_Su25SM_vvsc",
	"B_Heli_Attack_01_F",
	"B_Heli_Attack_01_dynamicLoadout_F",
	"RHS_Mi24V_vvsc",
	"BwS_A10",
	"BwS_ALCA",
	"BwS_Commanche",
	"BwS_Dauphin",
	"BwS_NH90",
	"BwS_Lynx_Medic",
	"BwS_Lynx_Transport",
	"BwS_Lynx_arme",
	"BwS_Gazelle",
	"BwS_Gazelle_armee"
];
			
BwS_ARS_cfg_AA_sol = 
[
	"O_APC_Tracked_02_AA_F",
	"O_T_APC_Tracked_02_AA_ghex_F",
	"O_static_AA_F",
	"B_APC_Tracked_01_AA_F",
	"B_T_APC_Tracked_01_AA_F",
	"B_T_Static_AA_F",
	"B_static_AA_F",
	"rhs_p37",
	"rhs_gaz66_r142_msv",
	"rhs_zsu234_aa",
	"rhs_Igla_AA_pod_msv",
	"rhs_gaz66_zu23_msv",
	"RU_WarfareBAntiAirRadar",
	"USMC_WarfareBAntiAirRadar",
	"USMC_WarfareBArtilleryRadar",
	"RHS_M6_wd"
];

BwS_ARS_cfg_missiles_AA =
[
	"ammo_Missile_AA_R73",
	"ammo_Missile_AA_R77",
	"ammo_Missile_AMRAAM_C",
	"ammo_Missiles_ASRAAM_D",
	"ammo_Missile_AMRAAM_D",
	"ammo_Missiles_titan",
	"ammo_Missiles_Zephyr",
	"missiles_titan_static",
	"Missile_AA_04_Plane_CAS_01_F",
	"Missile_AA_03_Plane_CAS_02_F",
	"M_Air_AA",
	"M_Air_AA_MI02",
	"M_Titan_AA",
	"M_Titan_AA_long",
	"M_Titan_AA_static",
	"Missile_AA_04_F",
	"Missile_AA_03_F",
	"M_Zephyr",
	"rockets_230mm_GAT",
	"R_230mm_HE",
	"ammo_Missile_BIM9X",
	"ammo_Missile_rim116",
	"ammo_Missile_rim162"
];

BwS_ARS_cfg_missiles_AGM =
[
	"Missile_AGM_02_F",
	"Missile_AGM_01_F",
	"M_Scalpel_AT",
	"M_PG_AT",
	"ammo_Bomb_LaserGuidedBase"
];

BwS_ARS_addAction_activer_radar = ["<t color='#00FF00'>Activer RADAR actif</t>", 
		{vehicle player setVariable ["BwS_ARS_var_radar_actif", true, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && !(vehicle player getVariable [""BwS_ARS_var_radar_actif"", false])"];
BwS_ARS_addAction_desactiver_radar = ["<t color='#FF0000'>Desactiver RADAR actif</t>", 
		{vehicle player setVariable ["BwS_ARS_var_radar_actif", false, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && (vehicle player getVariable [""BwS_ARS_var_radar_actif"", false])"];

BwS_ARS_addAction_activer_brouillage = ["<t color='#00FF00'>Activer BROUILLAGE (ECM)</t>", 
		{[(_this select 0)] spawn BwS_ARS_fn_demande_debut_ECM}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && (vehicle player getVariable [""BwS_ARS_var_ECM_dispo"", true])"];
BwS_ARS_addAction_echo_fantome = ["<t color='#00FF00'>Echo fantôme (ECM)</t>", 
		{[(_this select 0)] spawn BwS_ARS_fn_echo_fantome}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol)"];
BwS_ARS_addAction_desactiver_brouillage = ["<t color='#FF0000'>Desactiver BROUILLAGE (ECM)</t>", 
		{[(_this select 0)] spawn BwS_ARS_fn_demande_fin_ECM}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && (vehicle player getVariable [""BwS_ARS_var_ECM_actif"", false])"];

BwS_ARS_addAction_activer_transpondeur = ["<t color='#00FF00'>Activer TRANSPONDEUR</t>", 
		{vehicle player setVariable ["BwS_ARS_var_est_identifie", true, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && !(vehicle player getVariable [""BwS_ARS_var_est_identifie"", false])"];
BwS_ARS_addAction_desactiver_transpondeur = ["<t color='#FF0000'>Desactiver TRANSPONDEUR</t>", 
		{vehicle player setVariable ["BwS_ARS_var_est_identifie", false, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && (vehicle player getVariable [""BwS_ARS_var_est_identifie"", false])"];
		
BwS_ARS_addAction_activer_tracking = ["<t color='#00FFFF'>Activer suivi cible</t>", 
		{vehicle player setVariable ["BwS_ARS_var_tracking", true, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && !(vehicle player getVariable [""BwS_ARS_var_tracking"", false])"];
BwS_ARS_addAction_desactiver_tracking = ["<t color='#FF0000'>Desactiver suivi cible</t>", 
		{vehicle player setVariable ["BwS_ARS_var_tracking", false, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && (vehicle player getVariable [""BwS_ARS_var_tracking"", false])"];

BwS_ARS_addAction_menu = ["<t color='#00FFFF'>Menu principal</t>", 
		{showCommandingMenu "#USER:BwS_ARS_MENU_MAIN"}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol)"];

BwS_ARS_addAction_locker_suivant = ["<t color='#00FFFF'>Verrouiller suivant</t>", 
		{
			_leurres = BwS_ARS_var_leurres apply {_x select 0};
			vehicle player setVariable [
				"BwS_ARS_var_cible", 
				selectRandom((vehicles select 
					{
						(_x getVariable ["BwS_ARS_var_est_illumine", false] || 
						_x getVariable ["BwS_ARS_var_est_identifie", false] || 
						_x getVariable ["BwS_ARS_var_radar_actif", false]) && 
						(side _x != side player) &&
						([(vehicle player), _x, 60] call BwS_ARS_fn_cible_inAngleSector)
					})+(BwS_ARS_var_missiles+_leurres select {([(vehicle player), _x, 60] call BwS_ARS_fn_cible_inAngleSector)})), 
				true];
				_cible = vehicle player getVariable ["BwS_ARS_var_cible", objNull];
				_dist = _cible distance vehicle player;
				_vit = getNumber(configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> (currentMagazine vehicle player) >> "ammo") >> "maxSpeed") max 1;
				_dist_max = getNumber(configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> (currentMagazine vehicle player) >> "ammo") >> "missileLockMaxDistance") max 1;
				_ETA = _dist/_vit;
				if !(_cible isEqualTo objNull) then 
				{
					vehicle player vehicleChat "---------------------------";
					vehicle player vehicleChat format ["Ciblage : RNG %1m", round(vehicle player distance _cible)];
					vehicle player vehicleChat format ["Ciblage : ALT %1m", round(position _cible select 2)];
					vehicle player vehicleChat format ["Ciblage : ETA %1s", round(_ETA)];
					vehicle player vehicleChat format ["Ciblage : HIT%2 %1%2", round((abs(_dist_max/(vehicle player distance _cible)))*100), "%"];
				};
		}, 
		[], 
		1, 
		false, 
		true, 
		"User1",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol)"];
BwS_ARS_GBU_addAction_locker_suivant = ["<t color='#00FFFF'>Verrouiller suivant (GPS)</t>", 
		{
			vehicle player setVariable [
				"BwS_ARS_GBU_var_cible", 
				selectRandom(allMapMarkers select {[(markerText _x) find "GPS TARGET"] call BwS_fn_toBool})];
				_cible = markerPos (vehicle player getVariable ["BwS_ARS_GBU_var_cible", ""]);
				_dist = _cible distance vehicle player;
				
				if !(_cible isEqualTo [0,0,0]) then 
				{
					vehicle player vehicleChat format ["Ciblage %2 : RNG %1m", round(_dist), markerText (vehicle player getVariable ["BwS_ARS_GBU_var_cible", ""])];
				};
		}, 
		[], 
		1, 
		false, 
		true, 
		"User1",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol)"];
		
BwS_ARS_addAction_pas_de_cible = ["<t color='#00FFFF'>Annuler les cibles</t>", 
		{vehicle player setVariable ["BwS_ARS_var_cible", objNull, true];
		vehicle player setVariable ["BwS_ARS_GBU_var_cible", ""]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol)"];
		
BwS_ARS_addAction_couper_alarme = ["<t color='#00FF00'>Couper ALARME</t>", 
		{vehicle player setVariable ["BwS_ARS_var_alarme_off", true, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && !(vehicle player getVariable [""BwS_ARS_var_alarme_off"", false])"];
BwS_ARS_addAction_laisser_alarme = ["<t color='#FF0000'>Laisser ALARME</t>", 
		{vehicle player setVariable ["BwS_ARS_var_alarme_off", false, true]}, 
		[], 
		1, 
		false, 
		true, 
		"",
		"((typeOf (vehicle player)) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) && (vehicle player getVariable [""BwS_ARS_var_alarme_off"", false])"];
		
BwS_fn_toBool ={if ((_this select 0) == -1) then {false} else {true}};
