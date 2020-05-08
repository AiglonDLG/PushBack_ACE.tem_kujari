// _group = (_this select 0);

// [_group, (position leader _group), 500] call BIS_fnc_taskPatrol;

diag_log "Gestion patrouille RUNNING";
_nombrePrecedent = count allPlayers;
while {true} do
{	
	if (_nombrePrecedent != count allPlayers) then
	{
		{
			_x enableSimulationGlobal !(count allPlayers == 0);
		} forEach allUnits;
	};
	_nombrePrecedent = count allPlayers;
	sleep 10;
};
/*
_temps_avant_prochaine_embuscade = 0;

while {true} do
{
	call BwS_fn_tri_des_unites;
	{
		_group = _x;
		if (side _group == BwS_var_side_ennemie) then
		{
			_nearestPlayer = [leader _group] call BwS_fn_nearestPlayer;
			
			{	
				if (_x in BwS_var_unites) then 
				{
					_x enableSimulationGlobal true;	
					_mechant = _x;
					{_x reveal _mechant} forEach allPlayers;
				}
				else
				{
					_x enableSimulationGlobal false;
				};
				
				if ((_x in BwS_var_homed) && (_nearestPlayer distance _x < 10) && (random 1 <= 0.50)) then
				{
					_x move (position _nearestPlayer);
					_group setBehaviour "COMBAT";
				};
				
			} forEach units _group;

			if !(_group in BwS_var_groupes_a_exclure) then 
			{
				if ((_nearestPlayer distance (getMarkerPos "PC")) > 500) then // si le joueur le plus proche est à plus de 500m de la base on peut l'attaquer
				{
					if (([_nearestPlayer] call BwS_fn_sont_ils_en_groupe) || 
						([_nearestPlayer] call BwS_fn_sont_ils_en_convoi)) then // si c'est un groupe => + de 3 unités à - de 20m de _nearestPlayer ou si c'est un convoi (3 vehicules au moins) => permet les URR 
					{
						if ((_nearestPlayer distance (leader _group)) < 2000) then 
						{
							// _group move position _nearestPlayer;
							// _group setFormation (selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"]);
							// _group setSpeedMode "NORMAL";
							if (time >= _temps_avant_prochaine_embuscade) then
							{
								_temps_avant_prochaine_embuscade = time + 3600;
								if([_nearestPlayer] call BwS_fn_sont_ils_en_convoi) then
								{
									// [_nearestPlayer] spawn BwS_fn_embuscade_convoi;
								};
								
								if ([_nearestPlayer] call BwS_fn_sont_ils_en_groupe) then
								{
									// [_nearestPlayer] spawn BwS_fn_embuscade_groupe;
								};
							};
						};
					}
					else
					{
						_group move [((position leader _group) select 0)-100+random(200), ((position leader _group) select 1)-100+random(200)];
					};
				};
			};
		}; 
		
	} forEach (allGroups-BwS_var_groupes_a_exclure_simulation);
	
	{
		_x enableSimulationGlobal true;
	} forEach allDead;
	
	sleep 10;
};*/