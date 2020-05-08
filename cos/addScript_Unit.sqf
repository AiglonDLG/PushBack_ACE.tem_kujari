/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/

_unit = (_this select 0);

{civilian revealMine _x} forEach allMines;

[_unit] spawn BwS_fn_initCivil;

if (random 100 <= 10) then {
	[_unit] join grpNull;

	_unit allowFleeing 0;
	_unit setSkill 1;
	_unit setVariable ["BwS_wanted", true, true];
	_unit setVariable ["BwS_raison", "Terrorisme", true];
	
	// le mec est un taleb
	// suicide bomber ou attaque à la kalash
	if ((random 100) < 50) then {
		// suicide bomber ! on lui ajoute une ceinture
		_unit setVariable ["BwS_IED_est_un_IED", true, true];
		_explosif1 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
		_explosif1 attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis"];
		_explosif1 setVectorDirAndUp [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ];
		_explosif2 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
		_explosif2 attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
		_explosif2 setVectorDirAndUp [ [1, 0, 0], [0, 1, 0] ];
		_explosif3 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
		_explosif3 attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis"];
		_explosif3 setVectorDirAndUp [ [0.5, -0.5, 0], [0.5, 0.5, 0] ];
		waituntil { if (count allPlayers != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); sleep 5; (_unit distance ([_unit] call BwS_fn_nearestPlayer)) < 10} else {false}; };
	} 
	else {
		// attaque à la kalash		
		// faire pop une kalash dans ses mains
		_unit addMagazine "30Rnd_762x39_Mag_F";
		_unit addWeapon "arifle_AKM_F";
		_unit addMagazine "30Rnd_762x39_Mag_F";
		_unit addMagazine "30Rnd_762x39_Mag_F";
		// attaquer les pax
		_unit doFire ([_unit] call BwS_fn_nearestPlayer);		
		
		// for "_i" from 0 to 5 do 
		// {
			// _unit forceWeaponFire [currentWeapon _unit, "FullAuto"];
			// sleep random 1;
		// };

		while {alive _unit} do { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); _unit doFire ([_unit] call BwS_fn_nearestPlayer); sleep 5;} else {false};};
	};
}
else
{
	_unit addEventHandler ["Killed", 
	{
		"Un civil a été tué. Pénalité financière de 2000 crédits !" remoteExec ["systemChat"];
		private ["_credits"];
		_credits = usine_us getVariable "R3F_LOG_CF_credits";
		_credits = _credits - 2000;
		usine_us setVariable ["R3F_LOG_CF_credits", _credits, true];
	}]; 
	
	/*_unit addeventhandler ['FiredNear', {
				(_this select 0) playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
				(_this select 0) stop true;
			}];*/
};