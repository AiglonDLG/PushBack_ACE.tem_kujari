scriptName "BwS_fn_mortier";
// Création d'un binôme : chacun un sac.

private ["_vehicle"];

_position = _this select 0;

_vehicle = "I_G_Mortar_01_F" createVehicle _position;

_g = [_position, 2, BwS_var_side_ennemie, BwS_var_side_ennemie, "CAN_COLLIDE"] call BwS_fn_spawnGroup;
(units _g select 0) moveInGunner _vehicle;
[_vehicle] spawn BwS_fn_artillerie;