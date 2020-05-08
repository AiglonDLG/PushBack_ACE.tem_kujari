BwS_fn_distance_detection =
{
	if (vehicle player != player) then
	{
		50
	}
	else
	{
		4
	};
};

while {true} do
{
	if (BwS_joueur_est_en_train_de_detecter) then
	{
		{
			if (player distance _x <= (call BwS_fn_distance_detection) && ([getPos player, getDir player, 70, getPos _x] call BIS_fnc_inAngleSector)) then
			{
				[player distance _x] call 
				{
					_volume = 25;
					_dir = player getDir _x;
					_angle = acos ([sin getDir player, cos getDir player, 0] vectorCos [sin _dir, cos _dir, 0]);
					_volume = 25 - (abs _angle);
					playSound3D ["A3\Sounds_f\sfx\Beep_Target.wss", player, false, getPosASL player, _volume, 1, 4];
					sleep ((_this select 0) / (call BwS_fn_distance_detection));
				};
			};
		} forEach (allMines+((player nearObjects (call BwS_fn_distance_detection)) select {_x getVariable ["BwS_IED_est_un_IED", false]}));	
	};
	sleep 0.01;
};