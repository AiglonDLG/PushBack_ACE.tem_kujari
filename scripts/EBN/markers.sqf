
BwS_EBN_groupes = ["Alpha", "Bravo", "Charly", "Delta", "Echo", "Foxtrot", "Hotel", "X-Ray"];

BwS_EBN_marqueur_Alpha = createMarker ["BwS_EBN_marqueur_groupe_Alpha", [0, 0, 0]];
BwS_EBN_marqueur_Bravo = createMarker ["BwS_EBN_marqueur_groupe_Bravo", [0, 0, 0]];
BwS_EBN_marqueur_Charly = createMarker ["BwS_EBN_marqueur_groupe_Charly", [0, 0, 0]];
BwS_EBN_marqueur_Delta = createMarker ["BwS_EBN_marqueur_groupe_Delta", [0, 0, 0]];
BwS_EBN_marqueur_Echo = createMarker ["BwS_EBN_marqueur_groupe_Echo", [0, 0, 0]];
BwS_EBN_marqueur_Foxtrot = createMarker ["BwS_EBN_marqueur_groupe_Foxtrot", [0, 0, 0]];
BwS_EBN_marqueur_Hotel = createMarker ["BwS_EBN_marqueur_groupe_Hotel", [0, 0, 0]];
BwS_EBN_marqueur_XRay = createMarker ["BwS_EBN_marqueur_groupe_XRay", [0, 0, 0]];

BwS_EBN_marqueurs_groupes = [BwS_EBN_marqueur_Alpha, BwS_EBN_marqueur_Bravo, BwS_EBN_marqueur_Charly, BwS_EBN_marqueur_Delta, BwS_EBN_marqueur_Echo, BwS_EBN_marqueur_Foxtrot, BwS_EBN_marqueur_Hotel, BwS_EBN_marqueur_XRay];

{
	_x setMarkerAlpha 0;
	_x setMarkerColor "ColorBLUFOR";
	_x setMarkerShape "ICON";
	_x setMarkerType "b_inf"; 
	_x setMarkerText (BwS_EBN_groupes select _forEachIndex);
	
} forEach BwS_EBN_marqueurs_groupes;