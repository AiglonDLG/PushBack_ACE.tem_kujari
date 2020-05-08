private ["_hopital"];

_hopital = _this select 0;
_hopital allowDamage false;

_hopital addAction ["<t color='#0000FFDF'>SE SOIGNER</t>", 
{
	private ["_caller"];
	
	_caller = _this select 1;
	
	_chn = ""; 
	_butee = (damage _caller) * 100; 
	
	for "_i" from 0 to _butee do 
	{
		hint format ["[%1]\n%2%3 terminés", _chn, floor(_i*100/_butee), "%"]; 
		_chn = _chn + "="; 
		sleep 1;
	}; 
	
	_caller setDamage 0;
	_caller setVariable ["agm_blood", 1, true];
	_caller setVariable ["agm_pain", 0, true];
	
	hint "Terminé !";
}, [], 1.5, true, true, "", "(damage _this != 0) or (_this getVariable ""agm_blood"" != 1) or (_this getVariable ""agm_pain"" != 0)"];