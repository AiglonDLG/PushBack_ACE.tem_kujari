player sideChat "Cliquez sur la carte à l'endroit où faire apparaitre une zone à nettoyer !";
onMapSingleClick 
{
	// [_pos] spawn BwS_fn_zone; 
	[_pos] remoteExec ["BwS_fn_gestion_ville", 2, false];
	player sideChat "Ce sera fait !";
	onMapSingleClick ""
}