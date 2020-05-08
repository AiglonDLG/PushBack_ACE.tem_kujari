execVM "ARS\guidage.sqf";

BwS_ARS_fn_HUD =
{
	_radar = switch (_this) do {
		case 0:  {true};
		case 1: {false};
		default {true};
	};
	showHUD [(shownHUD select 0), (shownHUD select 1), _radar, (shownHUD select 3), (shownHUD select 4), (shownHUD select 5), (shownHUD select 6), (shownHUD select 7), (shownHUD select 8)];
};

BwS_ARS_fn_loop =
{
	addMissionEventHandler ["Draw3D", 
	{ 
				
		_leurres = BwS_ARS_var_leurres apply {_x select 0};
		_mechants = ((vehicles select 
					{
						(_x getVariable ["BwS_ARS_var_est_illumine", false] || 
						_x getVariable ["BwS_ARS_var_est_identifie", false] || 
						_x getVariable ["BwS_ARS_var_radar_actif", false]) && 
						(side _x != side player)
					})+((BwS_ARS_var_missiles+_leurres) select {([(vehicle player), _x, 120] call BwS_ARS_fn_cible_inAngleSector)})-[vehicle player, player]);
		_cibles = _mechants select {([(vehicle player), _x, 60] call BwS_ARS_fn_cible_inAngleSector)};

		if (typeOf vehicle player in (BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) || count(nearestObjects [(position player), BwS_ARS_cfg_vehicules_radar, 20, true]) > 0) then 
		{ 
			{ 
				if ([(vehicle player), _x, 120] call BwS_ARS_fn_cible_inAngleSector) then  
				{ 
					_pos = position _x; 
					_texte = if (_pos select 2 >= 40) then {
						format ["VIT %1km/h AZT %2 RNG %3m ALT %4m", round(speed _x), round(getDir _x), round(_x distance player), round(position _x select 2)]; 
					} else
					{
						""
					};
					_couleur = if (_x getVariable ["BwS_ARS_var_est_identifie", false] && side _x == side player) then {[0.1,0.1,1,1]} else {[0.9,0.6,0,1]}; 
					_brouillage = _x getVariable ["BwS_ARS_var_ECM_actif", false]; 
					
					_couleur = if (_pos select 2 <= 40) then {[0.1,1,0.1,1]} else {_couleur};
					
					_couleur = if (((vehicle player getVariable ["BwS_ARS_var_cible", objNull]) isEqualTo _x) && (_brouillage isEqualTo false)) then {[1,0.1,0.1,1]} else {_couleur};
					_afficher = if (_brouillage) then { if (random BwS_ARS_cfg_portee_radar >= (_x distance player)) then {true} else {false} } else {true}; 
					
					_ressource = if (_x in _cibles || _x in BwS_ARS_var_missiles) then {if (_x in _cibles) then {"\a3\ui_f\data\gui\cfg\cursors\track_gs.paa"} else {"\a3\ui_f\data\gui\cfg\cursors\hc_overmission_gs.paa"}} else {"\a3\ui_f\data\gui\cfg\cursors\hc_overenemy_gs.paa"};
					
					if (_afficher) then {drawIcon3D [_ressource, _couleur, _pos, 1, 1, 0, _texte, 0, 0.025, "PuristaSemibold"];}; 
				}; 
			} forEach _mechants;

			_gps_targets = (allMapMarkers select {[(markerText _x) find "GPS TARGET"] call BwS_fn_toBool});
			
			{
				_pos = markerPos _x;
				_couleur = if (_x isEqualTo (vehicle player getVariable ["BwS_ARS_GBU_var_cible", ""])) then {[1,0.1,0.1,1]} else {[0.1,1,0.1,1]};
				drawIcon3D ["\a3\ui_f\data\gui\cfg\cursors\hc_overmission_gs.paa", _couleur, _pos, 1, 1, 0, format ["%2 - RNG %1", _pos distance player, markerText _x], 0, 0.025, "PuristaSemibold"];
			} forEach _gps_targets;
		}; 
	}];
	
	player addEventHandler ["GetInMan", 
	{
		if (typeOf (_this select 2) in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) then
		{
			[(_this select 2)] call BwS_ARS_fn_monte_dans_un_avion;
		};
	}];
		
	player addAction BwS_ARS_addAction_menu;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_menu}];

	// ACTIVER LE RADAR
	player addAction BwS_ARS_addAction_activer_radar;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_activer_radar}];
	// DESACTIVER LE RADAR
	player addAction BwS_ARS_addAction_desactiver_radar;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_desactiver_radar}];
	
	// ACTIVER BROUILLAGE
	//player addAction BwS_ARS_addAction_activer_brouillage;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_activer_brouillage}];	
	
	// ACTIVER BROUILLAGE
	//player addAction BwS_ARS_addAction_echo_fantome;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_echo_fantome}];	
	
	// CIBLE SUIVANTE
	player addAction BwS_ARS_addAction_locker_suivant;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_locker_suivant}];
	// CIBLE GPS SUIVANTE
	//player addAction BwS_ARS_GBU_addAction_locker_suivant;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_GBU_addAction_locker_suivant}];
	// PAS DE CIBLE
	player addAction BwS_ARS_addAction_pas_de_cible;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_pas_de_cible}];
	
	// ACTIVER LE SUIVI
	//player addAction BwS_ARS_addAction_activer_tracking;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_activer_tracking}];
	// DESACTIVER LE SUIVI
	//player addAction BwS_ARS_addAction_desactiver_tracking;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_desactiver_tracking}];	
	
	// ACTIVER LE TRANSPONDEUR
	player addAction BwS_ARS_addAction_activer_transpondeur;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_activer_transpondeur}];
	// DESACTIVER LE TRANSPONDEUR
	player addAction BwS_ARS_addAction_desactiver_transpondeur;
	player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_desactiver_transpondeur}];
	
	// COUPER ALARME
	//player addAction BwS_ARS_addAction_couper_alarme;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_couper_alarme}];
	// LAISSER ALARME
	//player addAction BwS_ARS_addAction_laisser_alarme;
	//player addEventHandler ["Respawn", {player addAction BwS_ARS_addAction_laisser_alarme}];	

	_prochainBip = 0;
	BwS_ARS_var_missiles_a_surveiller = [];
	BwS_ARS_var_missiles_a_surveiller_prev = [];
	
	while {true} do
	{
		if (typeOf vehicle player in BwS_ARS_cfg_avions+BwS_ARS_cfg_AA_sol) then
		{
			// 1 call BwS_ARS_fn_HUD;
			(vehicle player) setVariable [
				"BwS_ARS_var_est_illumine", 
				(count ((vehicles select 
					{
						(_x getVariable ["BwS_ARS_var_radar_actif", false]) && 
						(_x distance player <= BwS_ARS_cfg_portee_radar) && 
						(side _x != side player) &&
						([_x, (vehicle player), 120] call BwS_ARS_fn_cible_inAngleSector)
					})-[vehicle player, player]) > 0), 
				true];

			_estIllumine =	 	(vehicle player) getVariable ["BwS_ARS_var_est_illumine", false];
			_alarme = 			(vehicle player) getVariable ["BwS_ARS_var_alarme_off", false];
			_prisPourCible = 	(vehicle player) getVariable ["BwS_ARS_var_pris_pour_cible", false];
			_ECM = 				(vehicle player) getVariable ["BwS_ARS_var_ECM_actif", false];
			_tracking = 		(vehicle player) getVariable ["BwS_ARS_var_tracking", false];
			_cible =			(vehicle player) getVariable ["BwS_ARS_var_cible", objNull];
			_cibleGPS = 		getMarkerPos ((vehicle player) getVariable ["BwS_ARS_GBU_var_cible", ""]);
			
			if (_cible getVariable ["BwS_ARS_var_ECM_actif", false]) then {(vehicle player) setVariable ["BwS_ARS_var_cible", objNull, true];};
			if (position _cible select 2 < 40) then {(vehicle player) setVariable ["BwS_ARS_var_cible", objNull, true];};
			
			if (_tracking) then
			{
				if (_cible isEqualTo objNull && !(_cibleGPS isEqualTo [0,0,0])) then 
				{
					(vehicle player) setPilotCameraTarget (AGLToASL _cibleGPS);
				} 
				else
				{
					(vehicle player) setPilotCameraTarget _cible;
				};
			};
			
			BwS_ARS_var_missiles = BwS_ARS_var_missiles - [objNull];
			BwS_ARS_var_missiles_a_surveiller = BwS_ARS_var_missiles select {_x distance (vehicle player) <= BwS_ARS_cfg_portee_MAWS};
			if (count BwS_ARS_var_missiles_a_surveiller == 0) then 
			{
				(vehicle player) setVariable ["BwS_ARS_var_pris_pour_cible", false];
			};
			
			{
				if !(_x in BwS_ARS_var_missiles_a_surveiller_prev) then
				{
					_x spawn BwS_ARS_fn_surveiller_missile; 
				};
			} forEach BwS_ARS_var_missiles_a_surveiller;
			
			{
				if (time > (_x select 2)) then
				{
					deleteVehicle (_x select 0);
					BwS_ARS_var_leurres = BwS_ARS_var_leurres - [_x];
				};
			} forEach BwS_ARS_var_leurres;
			
			if ((_estIllumine && !_alarme) || _prisPourCible) then
			{
				if !(_ECM) then 
				{
					if (time >= _prochainBip) then
					{
						playSound "AlarmCar";
						_prochainBip = if (_prisPourCible) then
											{
												// Accroché !!
												(time + 1)
											} else 
											{
												(time + 2)
											};
					};
				};
			};	
			BwS_ARS_var_missiles_a_surveiller_prev = BwS_ARS_var_missiles_a_surveiller;
		}
		else
		{
			// 0 call BwS_ARS_fn_HUD;
		};
		
		sleep 0.01;
	};
};

BwS_ARS_fn_monte_dans_un_avion = 
{
	_avion = (_this select 0);
	_avion setVariable ["BwS_ARS_var_est_identifie", false, true];
	_avion setVariable ["BwS_ARS_var_radar_actif", false, true];
	_avion setVariable ["BwS_ARS_var_ECM_actif", false, true];
	_avion addEventHandler ["Fired",
	{
		_avion = (_this select 0);
		_missile = (_this select 6);

		if (_missile isKindOf "MissileBase") then
		{	
			diag_log typeOf _missile;
			BwS_ARS_var_missiles pushBack _missile;
			publicVariable "BwS_ARS_var_missiles";
			
			if !((_avion getVariable ["BwS_ARS_var_cible", objNull]) isEqualTo objNull) then
			{
				if (typeOf _missile in BwS_ARS_cfg_missiles_AGM) then
				{
					nul = [_missile, (_avion getVariable ["BwS_ARS_var_cible", ""]), "missile", "agm"] spawn BwS_ARS_GBU_fn_guidage;
				};
				if (typeOf _missile in BwS_ARS_cfg_missiles_AA) then 
				{
					nul = [_missile, (_avion getVariable ["BwS_ARS_var_cible", objNull])] spawn BwS_ARS_fn_guidage;
				};
			};
			if ((!((_avion getVariable ["BwS_ARS_GBU_var_cible", ""]) isEqualTo "")) && 
				(typeOf _missile in BwS_ARS_cfg_missiles_AGM) && 
				((_avion getVariable ["BwS_ARS_var_cible", objNull]) isEqualTo objNull)) then
			{
				nul = [_missile, (getMarkerPos (_avion getVariable ["BwS_ARS_GBU_var_cible", ""])), "missile"] spawn BwS_ARS_GBU_fn_guidage;
			};
		};
		
		if (_missile isKindOf "BombCore") then
		{
			nul = [_missile, (getMarkerPos (_avion getVariable ["BwS_ARS_GBU_var_cible", ""]))] spawn BwS_ARS_GBU_fn_guidage;
		};
		
		if ((_this select 1) == "CMFlareLauncher") then
		{
			// _avion setAmmo [(_this select 1), (_avion ammo (_this select 1)) +2];
			(_this select 0) setVariable ["BwS_ARS_var_leurres_meca_actif", time+BwS_ARS_cfg_duree_brouillage_mecanique, true];
			_pos = position (_this select 0);
			for "_i" from 0 to 3+round(random(4)) do 
			{
				_pos2 = [((_pos select 0) - 15 + random 30), ((_pos select 1) - 15 + random 30), ((_pos select 2) - 15 + random 30)];
				_leurre = "Chemlight_green" createVehicle _pos2;
				BwS_ARS_var_leurres pushBack [_leurre, time, time+BwS_ARS_cfg_duree_brouillage_mecanique, velocity (_this select 0)];
			};
			publicVariable "BwS_ARS_var_leurres";
		};
	}];
	_avion addEventHandler ["Killed", 
	{
		_avion = (_this select 0);
		_avion setVariable ["BwS_ARS_var_est_identifie", false, true];
		_avion setVariable ["BwS_ARS_var_radar_actif", false, true];
		_avion setVariable ["BwS_ARS_var_ECM_actif", false, true];
	}];
	_avion addEventHandler ["IncomingMissile", {(_this select 0) spawn {_this setVariable ["BwS_ARS_var_pris_pour_cible", true]; sleep 5; _this setVariable ["BwS_ARS_var_pris_pour_cible", false];}}];
};

BwS_ARS_fn_echo_fantome = {
	_avion = vehicle (_this select 0);
	_pos = position _avion;
	if (driver _avion in allPlayers) then {vehicle player vehicleChat format ["ECM : Création echo fantôme - %1 secondes", BwS_ARS_cfg_duree_brouillage_electronique]};	
	_pos2 = [((_pos select 0) - 50 + random 100), ((_pos select 1) - 50 + random 100), ((_pos select 2) - 50 + random 100)];
	_leurre = "Chemlight_green" createVehicle _pos2;
	_leurre setVelocity (velocity _avion);
	BwS_ARS_var_leurres pushBack [_leurre, time, time+BwS_ARS_cfg_duree_brouillage_electronique, velocity (_this select 0)];
	publicVariable "BwS_ARS_var_leurres";
};

BwS_ARS_fn_demande_debut_ECM =
{
	_avion = vehicle (_this select 0);
	if (driver _avion in allPlayers) then {vehicle player vehicleChat format ["ECM : Démarrage ECM - %1 secondes", BwS_ARS_cfg_duree_brouillage_electronique]};
	_avion setVariable ["BwS_ARS_var_ECM_actif", true, true];
	_avion setVariable ["BwS_ARS_var_ECM_dispo", false];
	_avion setVariable ["BwS_ARS_var_ECM_prochaine_dispo", time+2*BwS_ARS_cfg_duree_brouillage_electronique];
	_avion setVariable ["BwS_ARS_var_ECM_fin", time+BwS_ARS_cfg_duree_brouillage_electronique];
		
	
	waitUntil {time > (_avion getVariable ["BwS_ARS_var_ECM_fin", 0])};
	if (driver _avion in allPlayers) then {vehicle player vehicleChat "ECM : Fin ECM - disponible dans 10 secondes"};
	_avion setVariable ["BwS_ARS_var_ECM_actif", false, true];
	waitUntil {time > (_avion getVariable ["BwS_ARS_var_ECM_prochaine_dispo", 0])};
	if (driver _avion in allPlayers) then {vehicle player vehicleChat "ECM : ECM disponible"};
	_avion setVariable ["BwS_ARS_var_ECM_dispo", true];
};

BwS_ARS_fn_cible_inAngleSector =
{
	//[<tireur>, <cible>, <angle>] call BwS_ARS_fn_cible_inAngleSector;
	private ["_ret", "_unit", "_angle"];
	_unit = _this select 0;
	_cible = _this select 1;
	_angle = _this select 2;
	_ret = false;
	if ([position _unit, getdir _unit, _angle, position _cible] call BIS_fnc_inAngleSector) then
	{
		_ret = true;
	};
	_ret
};

BwS_ARS_fn_cible_inAngleSector_pos =
{
	//[<tireur>, <position cible>, <angle>] call BwS_ARS_fn_cible_inAngleSector;
	private ["_ret", "_unit", "_angle"];
	_unit = _this select 0;
	_cible = _this select 1;
	_angle = _this select 2;
	_ret = false;
	if ([position _unit, getdir _unit, _angle, _cible] call BIS_fnc_inAngleSector) then
	{
		_ret = true;
	};
	_ret
};

BwS_ARS_fn_surveiller_missile =
{
	_objet = _this;
	// sur 5 secondes, on le suit
	_fin = time +5;
	_dist = _objet distance (vehicle player);
	_dist_prev = _objet distance (vehicle player);
	_notDisplayed = true;
	while {time <= _fin} do
	{
		// type radar doppler
		_dist = _objet distance (vehicle player);
		
		if (_dist < _dist_prev && _notDisplayed) then
		{
			(vehicle player) vehicleChat "MAWS ALERT : Incoming Missile";
			_notDisplayed = false;
			vehicle player setVariable ["BwS_ARS_var_pris_pour_cible", true];
		};
		_dist_prev = _dist;
		sleep 0.5; // 0.5 seconde
	};
	BwS_ARS_var_missiles_a_surveiller_prev = BwS_ARS_var_missiles_a_surveiller_prev - [_objet];
	BwS_ARS_var_missiles_a_surveiller = BwS_ARS_var_missiles_a_surveiller - [_objet];
};
