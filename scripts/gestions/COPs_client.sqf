// Création du marqueur
private ["_array", "_drapeauFOB", "_couleur"];
_array = [];
_drapeauFOB = "respawn_inf";
_couleur = "Default";

if (side player == west) then 
{
	_array = [	[COP_USA_1, "COP #1"], 
				[COP_USA_2, "COP #2"]];
				_couleur = "ColorBLUFOR";
};

if (side player == east) then 
{
	_array = [	[COP_RU_1, "COP #1"], 
				[COP_RU_2, "COP #2"]];
				_color = "ColorOPFOR";
};

{
	createMarkerLocal [(_x select 1), position (_x select 0)];
	(_x select 1) setMarkerTextLocal (_x select 1);
	(_x select 1) setMarkerTypeLocal _drapeauFOB;
	(_x select 1) setMarkerColorLocal _couleur;
	
} forEach _array;

// Déplacement du marqueur
while {true} do
{
	{
		if (!isNull (_x select 0)) then 
		{
			(_x select 1) setMarkerPosLocal position (_x select 0);
		};
	} forEach _array;
	sleep 10;
};