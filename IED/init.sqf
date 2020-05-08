/*

	Script d'IEDs créé par [B.w.S] SoP pour la mission Operation PushBack

	Réalisé en prenant les meilleurs morceaux du script de [EPD] Brian

	http://www.armaholic.com/page.php?id=23995

	WIP

*/

call compile preprocessFile "IED\config.sqf";
sleep 0.01;
call compile preprocessFile "IED\fonctions.sqf";
call compile preprocessFile "IED\ExplosionEffects.sqf";

sleep 0.01;

if (isServer) then
{
	BwS_IEDs = [];
	0 spawn BwS_IED_fn_init;
};

if (hasInterface) then // cote client
{
	0 spawn BwS_IED_fn_loop;
};

