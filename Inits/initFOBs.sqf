sleep 5;

BwS_fn_addActions_FOB = {
	_fob = _this;
//	_fob addAction ["<t color='#555555'>COP #1</t>", {player moveInCargo COP_USA_1; [] spawn BwS_fn_chargement}];
//	_fob addAction ["<t color='#555555'>COP #2</t>", {player moveInCargo COP_USA_2; [] spawn BwS_fn_chargement}];
	_fob addAction ["<t color='#00FF00'>BASE</t>", {(_this select 1) setPos (getMarkerPos "respawn_west");}];
	
	
	_condition_commune = "(chef_de_mission || joueurAdmin) && ";
	BwS_FOB_var_condition_deployement = _condition_commune + "!(_target getVariable [""BwS_FOB_var_deployee"", false])";
	BwS_FOB_var_condition_repli = _condition_commune + "(_target getVariable [""BwS_FOB_var_deployee"", false]) && (serverTime > (_target getVariable [""BwS_FOB_var_prochain_repli"", 0]))";
	
	//_fob addAction ["<t color='#00FF00'>Déployer FOB</t>", {_this spawn BwS_FOB_fn_deployer_FOB}, [_fob], 1.5, false, true, "", BwS_FOB_var_condition_deployement];
	//_fob addAction ["<t color='#00FF00'>Replier FOB</t>", {_this spawn BwS_FOB_fn_replier_FOB}, [_fob], 1.5, false, true, "", BwS_FOB_var_condition_repli];
};

BwS_FOB_fn_deployer_FOB = 
{
	_fob = _this select 3 select 0;
	_fob setVariable ["BwS_FOB_var_deployee", true, true];
	_fob setVariable ["BwS_FOB_var_prochain_repli", serverTime+(7200), true]; // 2h avant de pouvoir replier
	[position _fob, 500, _fob] remoteExec ["BwS_fn_peupler", 0, true];
	
};

BwS_FOB_fn_replier_FOB = 
{
	_fob = _this select 3 select 0;
	_fob setVariable ["BwS_FOB_var_deployee", false, true];
};

{
	_x call BwS_fn_addActions_FOB;
//} forEach [FOBa, FOBb];
} forEach [FOBa];
