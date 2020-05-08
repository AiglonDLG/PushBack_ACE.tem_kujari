scriptName "BwS_fn_embuscade";
diag_log "Embuscade déclenchée";

//_groups = allGroups select {((position leader _x) distance ([leader _x] call BwS_fn_nearestPlayer) < 3000) && (side _x == resistance) && !(_x in BwS_var_groupes_a_exclure) && (_x in (BwS_var_unites_de_caserne+BwS_var_unites_d_usine))};
_group = _this select 0;
	
// exclusions de ces groupes
BwS_var_groupes_a_exclure = BwS_var_groupes_a_exclure + [_group];
BwS_var_groupes_a_exclure_simulation = BwS_var_groupes_a_exclure_simulation + [_group];
		
{_x enableSimulationGlobal true} forEach units _group;

// mouvement sur endroit d'embuscade
_nearestPlayer = [leader _group] call BwS_fn_nearestPlayer;

_roads = ROADS select {([_x, (leader _group), _nearestPlayer] call BwS_fn_route_entre_a_et_b)};

_road = selectRandom _roads;

_group move (position _road);
_group setSpeedMode "FULL";

sleep 1;

waitUntil {unitReady leader _group};

_group setFormation "VEE";
_group setBehaviour "STEALTH";

BwS_var_groupes_a_exclure_simulation = BwS_var_groupes_a_exclure_simulation - [_group];
