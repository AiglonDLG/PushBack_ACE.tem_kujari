BwS_IED_fn_robot_ouvreur =
{
	_drone = _this select 0;

	while {alive _drone} do
	{
		_distance = 10;
		_IEDs = ((_drone nearObjects _distance) select {_x getVariable ["BwS_IED_est_un_IED", false]});
		
		if (count _IEDs > 0) then // s'il y a des IED à - de _distance m
		{
			_ied = ((nearestObjects [_drone, [], _distance]) select {_x getVariable ["BwS_IED_est_un_IED", false]}) select 0;
			
			if (_ied getVariable ["BwS_IED_RC", false]) then // si l'IED est contrôlé à distance
			{
				if (alive (_ied getVariable ["BwS_IED_controleur", objNull])) then // si le déclencheur est vivant, peu importe EOD ou pas, boum
				{
					[_ied] call BwS_IED_fn_Explose_IED;
				}
				else // l'observateur n'est plus vivant, l'objet n'est plus un IED
				{
					_ied setVariable ["BwS_IED_est_un_IED", false, true];
				};
			}
			else
			{
				if (!(call BwS_IED_cfg_joueur_EOD) || (abs(speed _drone) >= 6)) then // si le joueur n'est pas EOD ou s'il va trop vite
				{
					[_ied] call BwS_IED_fn_Explose_IED; // boom
				};
			};
		};
		sleep 1;
	};
};