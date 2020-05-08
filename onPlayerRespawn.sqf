if (hasInterface) then {[player] execVM "scripts\systemes\surveillerJoueur.sqf";};

[player] join grpNull;
BwS_MUTEX_peut_rejoindre_champ_de_bataille = false;

execVM "scripts\systemes\addActions.sqf";