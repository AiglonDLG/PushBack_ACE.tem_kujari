_ecran = _this select 0;
sleep 2;

_nomDuStream = format ["stream%1", random 100];

_ecran setObjectTexture [0, format ["#(argb,512,512,1)r2t(%1,1.0)", _nomDuStream]];
_cam = "camera" createVehicleLocal [0, 0, 0];
_cam cameraEffect ["internal", "front", _nomDuStream];

_ecran addAction ["<t color='#ffff33'>Se connecter</t>",{
	_ecran = (_this select 3) select 0;
	_ecran setVariable ["controller", (_this select 1), true];
},[_ecran],-90,false,true,"","(_target getVariable [""controller"", objNull]) isEqualTo objNull"];

_ecran addAction ["<t color='#ffff33'>Se déconnecter</t>",{
	_ecran = (_this select 3) select 0;
	_ecran setVariable ["controller", objNull, true];
},[_ecran],-90,false,true,"","!((_target getVariable [""controller"", objNull]) isEqualTo objNull)"];

_ecran addAction ["<t color='#ffff33'>Contrôler</t>", 
{
	_ecran = (_this select 3) select 0;
	_ecran setVariable ["mode", 1, true];
	
}, [_ecran],-90,false,true,"","!((_target getVariable [""mode"", 0]) == 1)"];

_ecran addAction ["		Retour",
{
	_ecran = (_this select 3) select 0;
	_ecran setVariable ["mode", 0, true];
},[_ecran],-90,false,true,"","((_target getVariable [""mode"", 0]) == 1)"];

_ecran addAction ["		Thermique (blanc)",
{
	_ecran = (_this select 3) select 0;
	((_this select 3) select 1) setPiPEffect [2];
},[_ecran, _nomDuStream],-90,false,true,"","((_target getVariable [""mode"", 0]) == 1)"];

_ecran addAction ["		Thermique (noir)",
{
	_ecran = (_this select 3) select 0;
	((_this select 3) select 1) setPiPEffect [7];
},[_ecran, _nomDuStream],-90,false,true,"","((_target getVariable [""mode"", 0]) == 1)"];

_ecran addAction ["		Infrarouge",
{
	_ecran = (_this select 3) select 0;
	((_this select 3) select 1) setPiPEffect [1];
},[_ecran, _nomDuStream],-90,false,true,"","((_target getVariable [""mode"", 0]) == 1)"];

_ecran addAction ["		Normal",
{
	_ecran = (_this select 3) select 0;
	((_this select 3) select 1) setPiPEffect [0];
},[_ecran, _nomDuStream],-90,false,true,"","((_target getVariable [""mode"", 0]) == 1)"];

while {true} do {
	_cam setVectorDirAndUp [(eyeDirection (_ecran getVariable ["controller", objNull])), vectorUp (_ecran getVariable ["controller", objNull])];
	_ecran setObjectTexture [0, format ["#(argb,512,512,1)r2t(%1,1.0)", _nomDuStream]];
	_eyepos = ASLtoATL eyePos (_ecran getVariable ["controller", objNull]);
	_eyepos set [2, (_eyepos select 2) + 0.1];
	_cam setPos _eyepos;
	sleep 0.01;
};