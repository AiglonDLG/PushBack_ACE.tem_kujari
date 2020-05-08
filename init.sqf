enableSaving [ false, false ];

//_R3F_AI = execVM "R3F_AiComTarget\init.sqf";
_R3F_LOG = execVM "R3F_LOG\init.sqf";
// _TFR = execVM "Inits\initTFR.sqf";

waituntil {/*scriptdone _R3F_AI && */scriptdone _R3F_LOG /*&& scriptdone _TFR*/};

nul = [] execVM "scripts\EBN\init.sqf"; // Espace de bataille numerique
nul = [] execVM "scripts\BwS\init.sqf";
nul = [] execVM "IED\init.sqf"; // improvised explosive device
nul = [] execVM "LLM\init.sqf"; // land life manager
nul = [] execVM "helios\init.sqf"; // satellite Helios
nul = [] execVM "CAS\init.sqf"; // script CAS
nul = [] execVM "ARS\init.sqf"; // Advanced Radar Simulation
nul = [] execVM "OPFOR\init.sqf"; // controle des IA
nul = [] execVM "CBS\init.sqf"; // civilian behaviour simulation

nul = execVM "scripts\systemes\compilation_fonctions_communes.sqf";


if (isServer) then
{
	// Suppression des cadavres des joueurs déconnectés
	addMissionEventHandler ["HandleDisconnect", {deleteVehicle (_this select 0); false}];
};
