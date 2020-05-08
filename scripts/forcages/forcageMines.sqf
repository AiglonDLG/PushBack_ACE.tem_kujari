_markers = [];

{
	_nomMarker = format ["mine_%1", random 1000];
	_marker = createMarkerLocal [_nomMarker, position _x];

	_markers = _markers + [_marker];
	
	_nomMarker setMarkerShapeLocal "ICON";
	_nomMarker setMarkerTypeLocal "hd_dot"; 
	_nomMarker setMarkerAlphaLocal 1;
	_nomMarker setMarkerTextLocal format ["mine"];
	_nomMarker setMarkerColorLocal "ColorEast";
} forEach allMines+BwS_IEDs;

sleep 60;

{ deleteMarker _x; } forEach _markers;