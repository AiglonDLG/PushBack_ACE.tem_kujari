scriptName "BwS_fn_raid";
diag_log "Raid déclenché";
// choix des groupes proches des joueurs
//_groups = allGroups select {((position leader _x) distance ([leader _x] call BwS_fn_nearestPlayer) < 3000) && (side _x == BwS_var_side_ennemie) && !(_x in BwS_var_groupes_a_exclure) && (_x in (BwS_var_unites_de_caserne+BwS_var_unites_d_usine))};
_groups = _this select 0;
_cible = _this select 1;
if (count _groups > 0) then
{
	// exclusions de ces groupes
	BwS_var_groupes_a_exclure = BwS_var_groupes_a_exclure + _groups;
	BwS_var_groupes_a_exclure_simulation = BwS_var_groupes_a_exclure_simulation + _groups;

	// regroupement de ces goupes
	_tx = 0;
	_ty = 0;
	
	{
		_tx = _tx + ((position leader _x) select 0);
		_ty = _ty + ((position leader _x) select 1);
	} forEach _groups;
	
	_ty = _ty/(count _groups);
	_tx = _tx/(count _groups);
	
	// fusion de ces groupes
	_mainGroup = (_groups select 0);
	
	{	
		_grp = _x;
		{deleteWaypoint [_grp, _forEachIndex]} forEach waypoints _grp;
		(units _grp) join _mainGroup;
	} forEach _groups;
			
	{_x enableSimulationGlobal true} forEach units _mainGroup;

	_mainGroup move [_tx, _ty];
	_mainGroup setSpeedMode "FULL";

	// mouvement sur joueurs
	waitUntil {(({(_x distance (leader _mainGroup) < 100)} count units _mainGroup) == (count units _mainGroup)) || (({unitReady _x} count units _mainGroup) == (count units _mainGroup))};
	
	while {({alive _x} count (units _mainGroup)) > 0} do
	{
		_mainGroup move (position _cible);
		sleep 10;
	};
};