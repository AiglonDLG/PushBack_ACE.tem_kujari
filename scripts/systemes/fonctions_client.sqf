BwS_fn_chargement = 
{
	startLoadingScreen ["Chargement en cours"]; 
	waituntil {preloadCamera position player}; 
	endLoadingScreen;
}; 

BwS_fn_creerMarqueur =
{
	scriptName "BwS_fn_creerMarqueur"; 
	private ["_nomMarker", "_text", "_position", "_marker", "_couleur"];
	
    //[input,index,(defaultValue,dataTypes,requiredCount)] call BIS_fnc_param; 
	
	_text = _this select 0;
	_position = [_this, 1, [0, 0, 0], [[]], 3] call BIS_fnc_param;
	_couleur = [_this, 2, "Default", [""]] call BIS_fnc_param;
	
	_nomMarker = format ["%1", random 10000];
	
	_marker = createMarker [_nomMarker, _position];

	_nomMarker setMarkerColor _couleur;
	_nomMarker setMarkerShape "ICON";
	_nomMarker setMarkerType "hd_dot"; 
	_nomMarker setMarkerAlpha 1;
	_nomMarker setMarkerText format ["%1", _text];
	sleep 60;
	deleteMarker _nomMarker;
};

BwS_fn_RADAR_effacer_marqueurs = {
	scriptName "BwS_fn_RADAR_effacer_marqueurs";
	{ 
		private ["_a"]; 
		_a = toArray _x; 
		_a resize 5;
		if (toString _a == "radar") then 
		{ 
			deleteMarker _x; 
		};
	} forEach allMapMarkers;
};

BwS_fn_afficher_marqueurs =
{
	scriptName "BwS_fn_afficher_marqueurs";
	_marqueurs = ["PC"];
	
	{
		_x setMarkerAlphaLocal 1;
	} forEach _marqueurs;
	
	sleep 60;
	
	{
		_x setMarkerAlphaLocal 0;
	} forEach _marqueurs;
};

