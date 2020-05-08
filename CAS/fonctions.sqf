/*
*	fonctions.sqf
*	[B.w.S] SoP
*	fichier des fonctions du script Close Air Support
*	24/10/2017
*/

BwS_CAS_var_request_QRF = [false, "XRay"];
BwS_CAS_var_request_drone = [false, "XRay"];

BwS_CAS_server_loop = 
{
	while {true} do
	{
		if (BwS_CAS_var_request_QRF select 0) then
		{
			[BwS_CAS_var_request_QRF select 1] spawn BwS_CAS_fn_send_QRF;
			BwS_CAS_var_request_QRF set [0, false];
			publicVariable "BwS_CAS_var_request_QRF";
		};

		if (BwS_CAS_var_request_drone select 0) then
		{
			[BwS_CAS_var_request_drone select 1] spawn BwS_CAS_send_drone;
			BwS_CAS_var_request_drone set [0, false];
			publicVariable "BwS_CAS_var_request_drone";
		};
	sleep 0.1;
	};
};


BwS_CAS_fn_loop_client =
{

};

BwS_CAS_fn_send_QRF =
{
	_positionRequester = markerPos format ["BwS_EBN_marqueur_groupe_%1", _this select 0];
	_departQRF = markerPos "depart_QRF";
	// spawn à la base 1 VBCI, 1 fennek contenant un groupe de combat
	// fennek : capitaine, radio(sgt), medic(adj) "BwS_Fennek"
	// VBCI : pilote (2cl), commander (sch), tireur (cpl), 2xcch, 2xAT4(1cl), 2xminimi(1cl) 2xGV(2cl) "BwS_VBCI"
	_biff = [_departQRF, 11, West, West] call BwS_fn_spawnGroup;
	_strass = [_departQRF, 3, West, West] call BwS_fn_spawnGroup;
	
	_c = "CAS\class\";

	_capitaine = leader _strass;
	_medic = (((units _strass)-[_capitaine]) select 1);
	_radio = (((units _strass)-[_capitaine]) select 0);
	_capitaine execVM _c+"capitaine.sqf";
	_radio execVM _c+"radio.sqf";
	_medic execVM _c+"infirmier.sqf";

	_units = units _biff;

	_pilote = (_units select 0);
	_commander = (_units select 1);
	_tireur = (_units select 2);

	_pilote execVM _c+"GV.sqf";
	_commander execVM _c+"sch.sqf";
	_tireur execVM _c+"cpl.sqf";
	(_units select 3) execVM _c+"GV.sqf";
	(_units select 4) execVM _c+"GV.sqf";
	(_units select 5) execVM _c+"AT4.sqf";
	(_units select 6) execVM _c+"AT4.sqf";
	(_units select 7) execVM _c+"minimi.sqf";
	(_units select 8) execVM _c+"minimi.sqf";
	(_units select 9) execVM _c+"cch.sqf";
	(_units select 10) execVM _c+"cch.sqf";

	_fennek = createVehicle ["BwS_Fennek", _departQRF, [], 20, "NONE"];
	_VBCI = createVehicle ["BwS_VBCI", _departQRF, [], 20, "NONE"];

	_capitaine moveInDriver _fennek;
	_radio moveInCargo _fennek;
	_medic moveInCargo _fennek;

	_pilote moveInDriver _VBCI;
	_commander moveInCommander _VBCI;
	_tireur moveInGunner _VBCI;

	{
		_x moveInCargo _VBCI;
	} forEach (units _biff)-[_pilote, _commander, _tireur];

	
	// se mouvoir jusque _positionRequester
	_biff move _positionRequester;
	_strass move _positionRequester;
	sleep 3;
	[_biff, (currentWaypoint _biff)] setWaypointType "GETOUT";
	[_strass, (currentWaypoint _strass)] setWaypointType "GETOUT";

	// dismount
	waitUntil { unitReady (driver _fennek) and unitReady (driver _VBCI) };

	sleep 1;

	_biff leaveVehicle _VBCI;
	_strass leaveVehicle _fennek;

	_pilote assignAsDriver _VBCI;
	_commander assignAsCommander _VBCI;
	_tireur assignAsGunner _VBCI;
	
	// on informe les nouveaux des menaces alentours
	{	
		_mechant = _x;
		{
			_x reveal [_mechant, 4];
		} forEach _units;
	} forEach (allUnits select {_capitaine distance _x < 600});
	// on reste sur zone 10min
	sleep 600;

	if ({alive _x} count _units > 0) then
	{
		// RTB
		_capitaine assignAsDriver _fennek;
		_radio assignAsCargo _fennek;
		_medic assignAsCargo _fennek;		
		[_capitaine, _radio, _medic] orderGetIn true;


		{_x assignAsCargo _VBCI} forEach (units _biff select {vehicle _x == _x});
		(units _biff select {vehicle _x == _x}) orderGetIn true;
	};
	sleep 60;
	_biff move _departQRF;
	_strass move _departQRF;

	waitUntil { unitReady (driver _fennek) and unitReady (driver _VBCI) };
	deleteVehicle _VBCI; deleteVehicle _fennek; 
	{ deleteVehicle _x} forEach (units _biff)+(units _strass);
};

BwS_CAS_send_drone =
{
	// creation drone en l'air
	// deplacement loiter autour groupe
	// active la connectabilité
	// si detruit : retrait de crédits
};

BwS_CAS_fn_request = 
{
	if ("QRF" in _this) then
	{
		BwS_CAS_var_request_QRF = [true, (player getVariable ["BwS_groupe", "XRay"])]; 
		publicVariable "BwS_CAS_var_request_QRF";
	};

	if ("drone" in _this) then
	{
		BwS_CAS_var_request_drone = [true, (player getVariable ["BwS_groupe", "XRay"])]; 
		publicVariable "BwS_CAS_var_request_drone";
	};
};