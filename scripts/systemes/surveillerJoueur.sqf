#define JOUEUR_EST_DANS_PC ((player distance (nearestObject [player, "Land_Cargo_Tower_V4_F"])) < 10) && ((getPosATL player select 2) > 12) && (playerInHQ isEqualTo false) && (((getMarkerPos "PC") distance (position player)) < 20) 

#define CONDITION_DRONISTE ((("B_UavTerminal" in (items player + assignedItems player)) || ("O_UavTerminal" in (items player + assignedItems player))) && !joueurDroniste)

#define CONDITION_INTERDICTION_UAV (backpack player == "B_UAV_01_backpack_F") || (backpack player == "O_UAV_01_backpack_F") || (backpack player == "I_UAV_01_backpack_F") || (backpack player == "B_rhsusf_B_BACKPACK")

#define CONDITION_TWS ("Weapon_optic_tws" in (primaryWeaponItems player)) || ("Weapon_optic_tws_mg" in (primaryWeaponItems player)) || ("Weapon_optic_Nightstalker" in (primaryWeaponItems player)) || ("optic_Nightstalker" in (primaryWeaponItems player)) 

#define CONDITION_JUMELLES ("ACE_MX2A" in [(binocular player)])

#define CONDITION_PILOTE ((vehicle player) isKindOf "Air" && !(joueurPilote && joueurBwS) && (driver vehicle player == player) && !(typeOf vehicle player isEqualTo "Steerable_Parachute_F"))

#define CONDITION_BULLE (!((vehicle player) isKindOf "Air") && ((player distance FOBb) > 2500 && (player distance FOBa) > 2500 && (player distance markerPos "PC") > 2500 && (player distance COP_USA_1) > 2500 && (player distance COP_USA_2 > 2500)))

waitUntil {scriptDone BwS_compilation_client};

/*---------- Initialisation des variables ------------*/
playerInHQ = false;

joueurDroniste = false;
joueurEOD = false;
joueurPilote = false;
chef_de_mission = false;

waitUntil {!isNull player};

joueurBwS = ["[B.w.S]", (name player)] call BIS_fnc_instring;
joueurAdmin = (getPlayerUID player) in 
[
	"76561198015997547", // Arsh
	"76561198067811595", // Red
	"76561198091898451", // Tatoune
	"76561198118269478", // SoP the best
	"76561198125151174", // Alex
	"76561198181657685"  // Haya
];

if ((player getVariable "pilote") isEqualTo true) then {joueurPilote = true;};
if ((player getVariable "BwS_var_joueur_est_EOD") isEqualTo true) then {joueurEOD = true;};
if ((player getVariable "droniste") isEqualTo true) then {joueurDroniste = true;};
if (player getVariable ["BwS_var_chef_de_mission", false]) then {chef_de_mission = true;};

if (joueurAdmin) then {player addAction ["MENU ADMIN", {showCommandingMenu "#USER:BwS_MENU_ADMIN"}, [], 1, false, true, ""];};
if (chef_de_mission) then {player addAction ["Commandement", {showCommandingMenu "#USER:BwS_MENU_CDM"}, [], 1, false, true, ""];};
onMapSingleClick "_shift";

[] spawn {
	scriptName "check in FOB";
	while {alive player} do {
		if ((vehicle player == FOBa) ||
			((typeOf (vehicle player)) in ["C_Plane_Civil_01_F", "BwS_Fennek_HQ", "rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy"])) then 
		{	
			if !(player getVariable ["tf_unable_to_use_radio", false]) then 
			{
				BwS_script_vehiculeRadar = [] execVM "scripts\vehiculeRadar.sqf";
				waitUntil {scriptDone BwS_script_vehiculeRadar};	
				BwS_marqueur_brouillage setMarkerAlphaLocal 0;
			}
			else
			{
				BwS_marqueur_brouillage setMarkerAlphaLocal 1;
				BwS_marqueur_brouillage setMarkerPosLocal (position vehicle player);
			};
		};
		sleep 0.01;
	};
};

BwS_MUTEX_peut_rejoindre_champ_de_bataille = true;

waituntil {preloadCamera position player};

player disableTIEquipment true;

while {alive player} do
{
	[player, "OperationPushBack"] call BIS_fnc_setUnitInsignia;
	
	if (JOUEUR_EST_DANS_PC) then
	{
		[player] execVM "scripts\HQ\HQ.sqf";
		playerInHQ = true;
				
		waitUntil {((player distance (nearestObject [player, "Land_Cargo_Tower_V4_F"])) > 10) || ((getPosATL player select 2) < 12)};
		
		playerInHQ = false;
	};
	
	if (CONDITION_DRONISTE) then // Pour le slot droniste
	{
		hintC "Vous devez être droniste pour contrôler un drone !";
		player unassignItem "B_UavTerminal";
		player unassignItem "O_UavTerminal";
		player removeItem "B_UavTerminal";
		player removeItem "O_UavTerminal";
	};
	
	if (CONDITION_INTERDICTION_UAV) then
	{
		removeBackpack player;
		hintC "Les UAV sont interdits via l'arsenal.";
	};
	
	if (CONDITION_TWS) then
	{
		player removePrimaryWeaponItem (primaryWeaponItems player select 2);
		hintC "Lunettes thermiques interdites.";
	};
	
	if (CONDITION_JUMELLES) then
	{
		player removeWeapon (binocular player);
	};
	
	if (CONDITION_PILOTE) then {moveOut player; hintC "Vous devez être pilote et membre BwS !"; }; // on jarte du véhicule s'il n'est pas pilote
	
	showChat true;
	
	if (vehicle player != player) then
	{
		if ((typeOf (vehicle player) == "BwS_VBCI_Medic") &&
			((gunner vehicle player == player) || (commander vehicle player == player))) then 
		{
			moveOut player;
		};
	};
	
	call BwS_fn_brouillage_local;
	// call BwS_fn_marqueur_joueur;
	
	sleep 0.1;
};