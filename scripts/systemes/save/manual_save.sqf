// TBD...

private ["_center", "_to_save", "_objets"];

_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

profileNameSpace setVariable ["pushback_save", []];
profileNameSpace setVariable ["pushback_save2", []];
saveProfileNameSpace;
_to_save = [];

_objets = _center nearObjects 30000;

_objets = _objets select {_x getVariable ["R3F_LOG_CF_depuis_usine", false] || ((typeOf _x) in ["ACE_envelope_small", "ACE_envelope_big"])};

{
	_caracteristiques = 
	[
		typeOf _x,
		position _x,
		[vectorDir _x, vectorUp _x],
		damage _x,
		_x call fn_contenu 
	];
	_to_save pushBack _caracteristiques;
} forEach _objets;
diag_log format ["%1 objets a sauver", count _to_save];

profileNameSpace setVariable ["pushback_save", _to_save];
_to_save = [];
{
	_veh = _x;
	_var = (allVariables _x) select {["r3f", _x] call BIS_fnc_inString};
	_var = _var apply {[_x, _veh getVariable _x]};
	_to_save pushBack [(position _veh), getDir _veh, _var];
} forEach BwS_save_var_vehicules_a_sauver;
profileNameSpace setVariable ["pushback_save2", _to_save];
_marqueurs = [];

{
	if (["USER", _x] call BIS_fnc_inString) then
	{
		_alpha = markerAlpha _x;
		_brush = markerBrush _x;
		_col = markerColor _x;
		_dir = markerDir _x;
		_pos = markerPos _x;
		_shape = markerShape _x;
		_size = markerSize _x;
		_text = markerText _x;
		_type = markerType _x;
		_marqueurs pushBack [_x, _alpha, _brush, _col, _dir, _pos, _shape, _size, _text, _type];
	};
} forEach allMapMarkers;

profileNameSpace setVariable ["pushback_save_marqueurs", _marqueurs];
saveProfileNamespace;

// function version
manualSave = {
	private ["_center", "_to_save", "_objets"];

_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

profileNameSpace setVariable ["pushback_save", []];
profileNameSpace setVariable ["pushback_save2", []];
saveProfileNameSpace;
_to_save = [];

_objets = _center nearObjects 30000;

_objets = _objets select {_x getVariable ["R3F_LOG_CF_depuis_usine", false] || ((typeOf _x) in ["ACE_envelope_small", "ACE_envelope_big"])};

{
	_caracteristiques = 
	[
		typeOf _x,
		position _x,
		[vectorDir _x, vectorUp _x],
		damage _x,
		_x call fn_contenu 
	];
	_to_save pushBack _caracteristiques;
} forEach _objets;
diag_log format ["%1 objets a sauver", count _to_save];

profileNameSpace setVariable ["pushback_save", _to_save];
_to_save = [];
{
	_veh = _x;
	_var = (allVariables _x) select {["r3f", _x] call BIS_fnc_inString};
	_var = _var apply {[_x, _veh getVariable _x]};
	_to_save pushBack [(position _veh), getDir _veh, _var];
} forEach BwS_save_var_vehicules_a_sauver;
profileNameSpace setVariable ["pushback_save2", _to_save];
_marqueurs = [];

{
	if (["USER", _x] call BIS_fnc_inString) then
	{
		_alpha = markerAlpha _x;
		_brush = markerBrush _x;
		_col = markerColor _x;
		_dir = markerDir _x;
		_pos = markerPos _x;
		_shape = markerShape _x;
		_size = markerSize _x;
		_text = markerText _x;
		_type = markerType _x;
		_marqueurs pushBack [_x, _alpha, _brush, _col, _dir, _pos, _shape, _size, _text, _type];
	};
} forEach allMapMarkers;

profileNameSpace setVariable ["pushback_save_marqueurs", _marqueurs];
saveProfileNamespace;
};