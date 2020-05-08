// ARG 1 : objet à traquer

private ["_objet", "_nomMarker", "_marker", "_couleur"];

_objet = _this select 0;

_nomMarker = format ["radar_%1", name _objet];

if (_this select 1 != 1) then
{
	switch (side _objet) do
	{
		case west: {_couleur = "ColorWEST"};
		case east: {_couleur = "ColorEAST"};
		case civilian:  {_couleur = "ColorCIV"};
		case resistance: {_couleur = "ColorGUER"};
		default {_couleur = "ColorUNKNOWN"};
	};


	if (alive _objet && getPosATL _objet select 2 > 20) then
	{
		_direction = vectorDir _objet;
		
		_marker = createMarkerLocal [_nomMarker, position _objet];

		_nomMarker setMarkerShapeLocal "ICON";
		_nomMarker setMarkerTypeLocal "mil_triangle"; 
		_nomMarker setMarkerAlphaLocal 1;
		_nomMarker setMarkerDirLocal (direction _objet);
		_nomMarker setMarkerTextLocal format ["ALT:%2m DIR:%3° VIT:%4km/h", (getText(configFile >> "CfgVehicles" >> typeof _objet >> "displayName")), floor (getPosATL _objet select 2), direction _objet, floor(speed _objet)];
		_nomMarker setMarkerColorLocal _couleur;
	};

	if (!alive _objet) then
	{
		_continuer = false;
	};
};