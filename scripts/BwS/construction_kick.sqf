BwS_MENU_ADMIN_KICK = [["Kick", true]];
{
	BwS_MENU_ADMIN_KICK pushBack ([name _x, [_forEachIndex+2], "", -5, [["expression", format ["[""ia773"", %1] remoteExec [""serverCommand"", 2]", format ["""#kick %1""", parsetext getplayeruid _x]]]], "1", "1"]);
} forEach allPlayers;