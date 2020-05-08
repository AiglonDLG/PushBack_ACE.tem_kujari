BwS_fn_initCivil = 
{
	_unit = (_this select 0);

	_wanted = if (random 100 > 95 || (isPlayer _unit)) then {true} else {false};
	_raisons = ["A commis un meurtre.", "Possède à  son domicile des images pédo-pornographiques.", "A commis un vol à l'étalage.", "A commis un vol à l'arraché.", "Vendeur à la sauvette.", "Outrage à agent.", "Non assistance à personne en danger et délit de fuite.", "Association de malfaiteur.", "Conspirateur.", "Association de malfaiteur en relation avec une entreprise terroriste.", "Vendeur de kébab avarié"];

	_unit setVariable ["BwS_age", (20 + random(30)), true];
	_unit setVariable ["BwS_wanted", _wanted, true];
	_unit setVariable ["BwS_alcool", random 1, true];

	if (_wanted) then {
		_unit setVariable ["BwS_raison", (selectRandom _raisons), true];
	};

    if (isPlayer _unit) then
    {
        _unit setVariable ["BwS_raison", "Association de malfaiteur en relation avec une entreprise terroriste.", true];
    };

	[[_unit], "BwS_fn_controle", west, true] call BIS_fnc_MP;
	[[_unit], "BwS_fn_interroger", west, true] call BIS_fnc_MP;
};

BwS_fn_controle =
{
	(_this select 0) addAction [
	"<t color='#ff0000'>Contrôler</t>",
	{
		_unit = (_this select 0);
		_splittedName = (name _unit splitString " ");
		
		_debut = "<t align='right'>"; _fin = "</t>";
		
		_nom = if (count _splittedName == 2) then {_debut + (_splittedName select 1) + _fin} else {"<t align='right'>Refuse de décliner son nom</t>"};
		_prenom = _debut + (_splittedName select 0) + _fin;
		_age = _debut + str (floor (_unit getVariable ["BwS_age", random(30)+20])) + _fin;
		_wanted = "<t align='right'>" + (if ((_unit getVariable "BwS_wanted")) then { format ["Oui<br/><t align='left'>Motif : </t>%1", (_unit getVariable "BwS_raison")] } else {"Non"}) + "</t>";
		hint parseText format ["%1%2%3%4%5%6%7%8%9",
		"<t size='1.5' color='#00ff00'>Contrôle</t><br/>",
		"<t align='left'>Nom : </t>", _nom,
		"<br/><t align='left'>Prénom : </t>", _prenom,
		"<br/><t align='left'>Age : </t>", _age,
		"<br/><t align='left'>Recherché : </t>", _wanted
		];
		
	},
	[],
	1.5,
    true,
    true,
    "",
    "((player distance _target) < 2) && (speed _target == 0) && (alive _target)"];
};

BwS_fn_interroger =
{
	// (_this select 0) addAction [
	// "<t color='#ff0000'>Interroger</t>",
	// {
		// _unit = (_this select 0);
		// _position = position _unit;
		// _mine = selectRandom ((allMines+BwS_IEDs+BwS_var_homed) select {_x distance _unit < 300})+[objNull];
		
		// if (_mine != objNull) then 
		// {
			// [format ["Un civil a repéré un objet étrange aux coordonnées %1 !", position _mine], {player sideChat _this}] remoteExec ["call", 0];
			// [position _mine, "hd_dot", "ColorRed", "Chose suspecte", 180] call BwS_EBN_fn_placer_marqueur;
		// }
		// else
		// {
			// [format ["Ce civil ne sait rien.", position _mine], {player sideChat _this}] remoteExec ["call", 0];
		// };
		// [(_this select 0), (_this select 2)] remoteExec ["removeAction", 0, false];
		// [[_this select 0, _this select 2], {(_this select 0) removeAction (_this select 1)}] remoteExec ["call", 0];
	// },
	// [],
	// 1.5,
    // true,
    // true,
    // "",
    // "((player distance _target) < 2) && (speed _target == 0)"];
	
	[
		(_this select 0),
		"Interroger",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa",
		"((player distance _target) < 2) && (speed _target == 0) && (alive _target)",
		"((player distance _target) < 2) && (speed _target == 0) && (alive _target)",
		{}, // start
		{}, // progress
		{
			_unit = (_this select 0);
			_position = position _unit;
			_mine = selectRandom (((allMines+BwS_IEDs+BwS_var_homed) select {_x distance _unit < 300})+[objNull]);
			
			if !(isNull _mine) then 
			{
				[format ["Un civil a repéré un objet étrange aux coordonnées %1 !", position _mine], {player sideChat _this}] remoteExec ["call", 0];
				[position _mine, "hd_dot", "ColorRed", "Chose suspecte", 180] spawn BwS_EBN_fn_placer_marqueur;
			}
			else
			{
				[format ["Ce civil ne sait rien.", position _mine], {player sideChat _this}] remoteExec ["call", 0];
			};
			// [(_this select 0), (_this select 2)] remoteExec ["removeAction", 0, false];
			// [[_this select 0, _this select 2], {(_this select 0) removeAction (_this select 1)}] remoteExec ["call", 0];
			[(_this select 0), (_this select 2)] remoteExec ["bis_fnc_holdActionRemove", 0, false];	
		},
		{}, // interrupted
		[],
		5, // 5 secondes
		10,
		true,
		false] call bis_fnc_holdActionAdd;
};

BwS_fn_ajouter_rens_npc =
{
	[
		(_this select 0),
		"Chercher des renseignements",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa",
		"(player distance _target) < 3",
		"(player distance _target) < 3",
		{}, // start
		{}, // progress
		{
			_grp = selectRandom (allGroups select {side _x == BwS_var_side_ennemie});
			_pos = position (units _grp select 0);

			[format ["Nous avons trouvé qu'il y a un groupe ennemi en %1 !", _pos], {player sideChat _this}] remoteExec ["call", 0];
			[_pos, "hd_dot", "ColorRed", "PAX", 180] spawn BwS_EBN_fn_placer_marqueur;
			[(_this select 0), (_this select 2)] remoteExec ["bis_fnc_holdActionRemove", 0, false];	
		},
		{}, // interrupted
		[],
		5, // 5 secondes
		10,
		true,
		false] call BIS_fnc_holdActionAdd;
};

BwS_fn_pick_random =
{
	private ["_list", "_modifiedList", "_retour"];
	_list = (_this select 0);

    _modifiedList = [];    

	{
		_elmt = _x;
		for "_i" from 0 to (_elmt select 1) do
		{
			_modifiedList pushback (_elmt select 0);
		};
	} forEach _list;
	_retour = selectRandom _modifiedList;
	_retour
};

BwS_fn_findSafePos =
{

	/*
		File: findSafePos.sqf
		Author: Joris-Jan van 't Land modified by SoP for this mission

		Description:
		Function to retrieve and dynamic position in the world according to several parameters.

		Parameter(s):
		_this select 0: center position (Array)
							Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
		_this select 1: minimum distance from the center position (Number)
		_this select 2: maximum distance from the center position (Number)
							Note: passing -1, the world's safePositionRadius entry will be used.
		_this select 3: minimum distance from the nearest object (Number)
		_this select 4: water mode (Number)
							0: cannot be in water
							1: can either be in water or not
							2: must be in water
		_this select 5: maximum terrain gradient (average altitude difference in meters - Number)
		_this select 6: shore mode (Number):
							0: does not have to be at a shore
							1: must be at a shore
		_this select 7: (optional) blacklist (Array of Arrays):
							(_this select 7) select X: Top-left and bottom-right coordinates of blacklisted area (Array)
		_this select 8: (optional) default positions (Array of Arrays):
							(_this select 8) select 0: default position on land (Array)
							(_this select 8) select 1: default position on water (Array)
		
		Returns:
		Coordinate array with a position solution.
		
		TODO:
		* Maybe allow passing several combinations of position, min and max dist ... so that you can 
		avoid several things?
		* Interpretation of minDist / maxDist is wrong. It's not true distance that is used. Too bad?
	*/

	scopeName "main";

	private ["_pos", "_minDist", "_maxDist", "_objDist", "_waterMode", "_maxGradient", "_shoreMode", "_defaultPos", "_blacklist"];
	_pos = _this select 0;
	_minDist = _this select 1;
	_maxDist = _this select 2;
	_objDist = _this select 3;
	_waterMode = _this select 4;
	_maxGradient = _this select 5;
	_shoreMode = _this select 6;

	if (_shoreMode == 0) then {_shoreMode = false} else {_shoreMode = true};

	_blacklist = [];
	if ((count _this) > 7) then 
	{
		_blacklist = _this select 7;
	};

	_defaultPos = [];
	if ((count _this) > 8) then 
	{
		_defaultPos = _this select 8;
	};

	//See if default world values should be used.
	if ((count _pos) == 0) then 
	{
		_pos = getArray(configFile >> "CfgWorlds" >> worldName >> "safePositionAnchor");
	};
	if ((count _pos) == 0) exitWith {debugLog "Log: [findSafePos] No center position was passed!"; []}; //TODO: instead return defaults below.

	if (_maxDist == -1) then 
	{
		_maxDist = getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
	};

	//TODO: Validate parameters.

	private ["_newPos", "_posX", "_posY"];
	_newPos = [];
	_posX = _pos select 0;
	_posY = _pos select 1;


	//Limit the amount of attempts at finding a good location.
	private ["_attempts"];
	_attempts = 0;
	while {_attempts < 1000} do
	{
		private ["_newX", "_newY", "_testPos"];
		_newX = _posX + (_maxDist - (random (_maxDist * 2)));
		_newY = _posY + (_maxDist - (random (_maxDist * 2)));
		_testPos = [_newX, _newY];

		//Blacklist check.
		//TODO: Do not use function when the blacklist is empty?
		//if (!([_testPos, _blacklist] call BIS_fnc_isPosBlacklisted)) then
		//{
				if ((_pos distance _testPos) >= _minDist) then
				{
					if (!((count (_testPos isFlatEmpty [_objDist, 0, _maxGradient, _objDist max 5, _waterMode, _shoreMode, objNull])) == 0)) then 
					{
						_newPos = _testPos;
						breakTo "main";
					};
				};
		//};

		_attempts = _attempts + 1;
	};

	//No position was found, use defaults.
	if ((count _newPos) == 0) then
	{
		if (_waterMode == 0) then
		{
			if ((count _defaultPos) > 0) then 
			{
				_newPos = _defaultPos select 0;
			} 
			else 
			{
				//Use world Armory default position:
				_newPos = getArray(configFile >> "CfgWorlds" >> worldName >> "Armory" >> "positionStart");
			};
		}
		else
		{
			if ((count _defaultPos) > 1) then 
			{
				_newPos = _defaultPos select 1;
			} 
			else 
			{
				//Use world Armory default water position:
				_newPos = getArray(configFile >> "CfgWorlds" >> worldName >> "Armory" >> "positionStartWater");
			};
		};
	};

	if ((count _newPos) == 0) then 
	{
		//Still nothing was found, use world center positions.
		_newPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	};

	_newPos
};

