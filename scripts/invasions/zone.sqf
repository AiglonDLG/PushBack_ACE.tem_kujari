
scriptName "BwS_fn_zone";
// d�finition du lieu
_center = (_this select 0);

// cr�ation de la t�che (optionnel), du marqueur etc 
[_center] spawn BwS_fn_gestion_ville;
