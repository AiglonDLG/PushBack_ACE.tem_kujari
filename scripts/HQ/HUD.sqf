// [31000,30000,0]

hintsilent parseText "<t size='3' color='#00ff00'>Entrée dans<br/>PC</t>";
sleep 1;
while {playerInHq} do
{
	private ["_text"];
	_text = "<t size='2' color='#00ff00'>Poste<br/>de<br/>Commandement</t>";
	
	// On capte tous les aériens aliés
	private ["_aeriens", "_allies"];
	_aeriens = (position (nearestObject [player, "Land_Cargo_Tower_V1_F"]) nearEntities ["Air", 20000]);
	_allies = [];
	
	{if ((side _x == side player) && (position _x select 2 > 20)) then {_allies = _allies + [_x]}} forEach _aeriens;
	
	// Création du texte pour chaque aériens
	private ["_textCourent"];
	{
		_textCourent = "";

		_vehicle = _x;
		{
			private ["_arme"];
			_arme = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
			
			_textCourent = format ["%1%2", _textCourent, composeText [(format ["<br /><t align='left' size='0.9'>%1</t>", _arme]), (format ["<t size='0.9' align='right'>%1</t>", (_vehicle) ammo _x])]];
		} forEach weapons _vehicle;
		
		_text = format ["%1%2%3%4%5", 
						_text, 
						"<br /><br />", 
						format ["%1 - %2", getText(configFile >> "CfgVehicles" >> (typeof _vehicle) >> "displayName"), name driver _vehicle], 
						format ["<br /><t size='0.9' align='left'>Dommages : %1%2</t><t size='0.9' align='right'>Fuel : %3%2</t>", damage _vehicle *100, "%", fuel _vehicle *100], 
						_textCourent];
	} forEach _allies;

	// Hint final
	hintsilent parseText _text;
	
	sleep 1;
};
hintsilent parseText "<t size='3' color='#ff0000'>Sortie du<br/>PC</t>";
