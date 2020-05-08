
scriptName "BwS_fn_zone";
// définition du lieu
_center = (_this select 0);

// création de la tâche (optionnel), du marqueur etc 
[_center] spawn BwS_fn_gestion_ville;
