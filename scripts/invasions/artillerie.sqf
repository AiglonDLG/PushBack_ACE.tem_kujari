scriptName "BwS_fn_artillerie";
#define HEURE 3600
#define MINUTE 60

private ["_mortier", "_tempsEntreFrappes", "_ammo"];

_mortier = (_this select 0);

_ammo = switch (typeOf _mortier) do
{
	case "O_Mortar_01_F": {"8Rnd_82mm_Mo_shells"};
	case "I_G_Mortar_01_F": {"8Rnd_82mm_Mo_shells"};
	case "B_MBT_01_mlrs_F": {"12Rnd_230mm_rockets"};
	case "O_MBT_02_arty_F": {"32Rnd_155mm_Mo_shells"};
	case "rhs_2b14_82mm_ins": {"rhs_mag_3vo18_10"};
	default { "" };
};

_tempsEntreFrappes = 15*MINUTE; // toutes les 15 minutes

while {alive _mortier} do 
{
	BwS_nombreJoueurs = count allPlayers;
	if (BwS_nombreJoueurs > 0) then
	{
		{
			if ((position _x) inRangeOfArtillery [[gunner _mortier], _ammo]) then
			{
				_pos = [(position _x select 0)+round(random(300))-150, (position _x select 1)+round(random(300))-150, 0];
				_burst = 3+round(random(5));
				(gunner _mortier) doArtilleryFire [_pos, _ammo, _burst];
			};
		} forEach allPlayers;
	};
	
	(vehicle _mortier) setVehicleAmmoDef 1;
	
	sleep _tempsEntreFrappes;	
};