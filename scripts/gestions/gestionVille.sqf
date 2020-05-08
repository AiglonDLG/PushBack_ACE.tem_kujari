scriptName "BwS_fn_gestion_ville";

_position = _this select 0;

// création du marqueur
_marqueur = createMarker [format ["zone_%1", _position], _position];

_marqueur setMarkerColor 	"ColorRed";
_marqueur setMarkerShape	"RECTANGLE";
_marqueur setMarkerSize 	[BwS_var_taille_zone/2, BwS_var_taille_zone/2];
_marqueur setMarkerBrush 	"DiagGrid"; 

[_position] spawn BwS_fn_peupler;

sleep 5;

_zoneActivee = true;
// _zoneActivee = false;

_continuer = true;
while {_continuer} do
{
	// si plus d'opfor en ville et plus de mine, ca passe vert, sinon : ca reste rouge
	_nombreENI = {_x inArea _marqueur && side _x == BwS_var_side_ennemie} count allUnits ;
	_nombreBLU = {_x inArea _marqueur && ((position _x) select 2) < 20 && speed _x < 20} count allPlayers ;
	
	if (!_zoneActivee) then
	{
		_zoneActivee = if (_nombreBLU != 0 && ({side _x == BwS_var_side_ennemie} count allUnits) < 100 ) then 
		{
			// activation zone
			[_position] spawn BwS_fn_peupler;
			true
		} else {false};
	};
	
	if (_nombreENI == 0 && _zoneActivee) then
	{
		_marqueur setMarkerColor "ColorGreen";
		_continuer = false;
	}
	else
	{
		if !(_zoneActivee) then {_marqueur setMarkerColor "ColorOrange";}
		else {_marqueur setMarkerColor "ColorRed";};
	};
	sleep 1;
};

private ["_credits"];
_credits = usine_us getVariable "R3F_LOG_CF_credits";
_credits = _credits + 50000;
usine_us setVariable ["R3F_LOG_CF_credits", _credits, true];

sleep 300; // 5 minutes
deleteMarker _marqueur;