
// LAND LIFE MANAGER

_compil = [] execVM "LLM\compilation.sqf";

waitUntil {scriptDone _compil};

[] execVM "LLM\config.sqf";
sleep 1;

if (isServer) then
{
	nul = [] execVM "LLM\loop.sqf";
};

if (hasInterface) then 
{
	sleep 3;
};