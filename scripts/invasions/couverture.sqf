for "_x" from 0 to 9 do 
{
	for "_y" from 0 to 9 do
	{
		_pos = [_x*BwS_var_taille_zone,_y*BwS_var_taille_zone];
		
		if (!(surfaceIsWater _pos) && ({_x} count [
			!(surfaceIsWater [(_pos select 0) - BwS_var_taille_zone,	(_pos select 1) + BwS_var_taille_zone]),
			!(surfaceIsWater [(_pos select 0) + 0, 					(_pos select 1) + BwS_var_taille_zone]),
			!(surfaceIsWater [(_pos select 0) + BwS_var_taille_zone, 	(_pos select 1) + BwS_var_taille_zone]),
			!(surfaceIsWater [(_pos select 0) + BwS_var_taille_zone, 	(_pos select 1) + 0]),
			!(surfaceIsWater [(_pos select 0) + BwS_var_taille_zone, 	(_pos select 1) - BwS_var_taille_zone]),
			!(surfaceIsWater [(_pos select 0) + 0, 					(_pos select 1) - BwS_var_taille_zone]),
			!(surfaceIsWater [(_pos select 0) - BwS_var_taille_zone, 	(_pos select 1) - BwS_var_taille_zone]),
			!(surfaceIsWater [(_pos select 0) - BwS_var_taille_zone, 	(_pos select 1) - 0])]) >= 6 &&
			(_pos distance FOBa > 2000) && 
			(_pos distance FOBb > 2000)) then {[_pos] spawn BwS_fn_zone};
	};
};