// Création du marqueur
private ["_array"];
_array = [];
_drapeauFOB = "";

if (side player == west) then 
{
	_array = [[FOBa, "FOB"]];
	_drapeauFOB = "flag_france";
};

if (side player == east) then 
{
	_array = [	[FOBA_R, "FOB Alpha"], 
				[FOBB_R, "FOB Bravo"]];
	_drapeauFOB = "rhs_flag_vdv";
};

{
	createMarkerLocal [(_x select 1), position (_x select 0)];
	(_x select 1) setMarkerTextLocal (_x select 1);
	(_x select 1) setMarkerTypeLocal _drapeauFOB;
	sleep 0.1;
} forEach _array;

// Déplacement du marqueur
while {true} do
{
	{
		if ((_x select 0) != objNull) then 
		{
			(_x select 1) setMarkerPosLocal position (_x select 0);
		};
		
		if ((_x select 0) getVariable ["BwS_FOB_var_deployee", false]) then
		{
			(_x select 0) setFuel 0;
		}
		else 
		{
			(_x select 0) setFuel 1;
		};
	} forEach _array;
	sleep 0.1;
};