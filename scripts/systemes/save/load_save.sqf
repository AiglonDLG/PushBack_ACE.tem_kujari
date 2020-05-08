// TBD...

BwS_var_save_loaded = false;
nul = [] execVM "scripts\systemes\save\config.sqf";
sleep 3;
// recuperation des objets savegradés
_objects_saved = profileNamespace getVariable ["pushback_save", []];

if (count _objects_saved > 0) then
{
	{
		_caracteristiques = _x;
		_typeOf = _caracteristiques select 0;
		_position = _caracteristiques select 1;
		_direction = _caracteristiques select 2;
		_damage = _caracteristiques select 3;


		_obj = createVehicle [_typeOf, [0,0,500+random(10000)], [], 0, "CAN_COLLIDE"];
		_obj setVectorDirAndUp _direction;
		sleep 0.01;
		_obj setPos _position;
		_obj setDamage _damage;
		_obj setVariable ["R3F_LOG_CF_depuis_usine", true, true];
		
		if ((count _caracteristiques) > 4) then
		{
			_contenu = _caracteristiques select 4;
			_armes = _contenu select 0;
			_items = _contenu select 1;
			_sacs = _contenu select 2;
			_mag = _contenu select 3;
			
			clearItemCargoGlobal _obj; 
			clearMagazineCargoGlobal _obj; 
			clearWeaponCargoGlobal _obj;
			clearBackpackCargo _obj;

			{_obj addWeaponCargoGlobal _x} forEach _armes;
			{_obj addItemCargoGlobal _x} forEach _items;
			{_obj addBackpackCargoGlobal _x} forEach _sacs;
			{_obj addMagazineCargoGlobal _x} forEach _mag;
		};		
		if (getNumber (configFile >> "CfgVehicles" >> (typeOf _obj) >> "isUav") == 1) then
		{
			createVehicleCrew _obj;
		};
	} forEach _objects_saved;
	diag_log format ["%1 objets charges", count _objects_saved];
};

_caracteristiques = profileNamespace getVariable ["pushback_save2", []];
// positions : [fob a, fob b, conteneur, conteneur 2, remise 1, remise 2, arsenal 1, arsenal 2]
if (count _caracteristiques > 0) then
{
	{
		_veh = _x;
		_veh setPos [0,0,500+random(10000)];
		_veh setDir ((_caracteristiques select _forEachIndex) select 1);
		sleep 0.01;
		_veh setPos ((_caracteristiques select _forEachIndex) select 0);
		_variables = (_caracteristiques select _forEachIndex) select 2;
		

		{
			_var = _x select 0;
			_val = _x select 1;
			_veh setVariable [_var, _val, true];
		} forEach _variables;

		

	} forEach BwS_save_var_vehicules_a_sauver;
};
// pour chaque objet, création

_marqueurs = profileNamespace getVariable ["pushback_save_marqueurs", []];

{
	_name = _x select 0;
	_alpha = _x select 1;
	_brush = _x select 2;
	_col = _x select 3;
	_dir = _x select 4;
	_pos = _x select 5;
	_shape = _x select 6;
	_size = _x select 7;
	_text = _x select 8;
	_type = _x select 9;

	_mrkr = createMarker [_name, _pos];
	_mrkr setMarkerAlpha _alpha;
	_mrkr setMarkerBrush _brush;
	_mrkr setMarkerColor _col;
	_mrkr setMarkerDir _dir;
	_mrkr setMarkerPos _pos;
	_mrkr setMarkerShape _shape;
	_mrkr setMarkerSize _size;
	_mrkr setMarkerText _text;
	_mrkr setMarkerType _type;

} forEach  _marqueurs;

BwS_var_save_loaded = true;

nul = [] execVM "scripts\systemes\save\save_manager.sqf";