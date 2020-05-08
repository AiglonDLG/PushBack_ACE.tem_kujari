private ["_sign"];

_sign = _this select 0;

_sign allowDamage false;

_sign addAction ["<t color='#FFFF00'>REPARER</t>", 
{
	BwS_MUTEX_action_en_cours = true;
	_sign = (_this select 0); 
	_chn = ""; 
	_butee = (random 10)+10; 
	for "_i" from 0 to _butee do 
	{
		hintSilent format ["[%1]\n%2%3 terminés", _chn, floor(_i*100/_butee), "%"]; 
		_chn = _chn + "="; 
		sleep 1;
	}; 
	
	{
		_x setDamage 0;
	} forEach ((position _sign) nearEntities [["LandVehicle", "Air", "autonomous", "ship"], 20]);
	
	hint "Terminé !";
	BwS_MUTEX_action_en_cours = false;
}, [], 1.5, true, true, "", "!BwS_MUTEX_action_en_cours"];

