[] execVM "scripts\EBN\constructions.sqf";
[] execVM "scripts\EBN\marquer.sqf";

BwS_EBN_fn_calculs_art = {
	scriptName "BwS_EBN_fn_calculs_art";
	player sideChat "Cliquez sur votre position sur la carte";
	
	onMapSingleClick 
	{		
		[_pos] spawn
		{
			player sideChat "Cliquez sur la position de la cible sur la carte";
			
			[(_this select 0)] onMapSingleClick 
			{
				_positionTarget = _pos;
				_positionBatterie = (_this select 0);
				
				player sideChat format ["Distance : %1m; Difference de niveau : %2m", (_positionBatterie distance2D _positionTarget), (getTerrainHeightASL _positionBatterie)-(getTerrainHeightASL _positionTarget)];
				onMapSingleClick ""
			};
		};
	};

};