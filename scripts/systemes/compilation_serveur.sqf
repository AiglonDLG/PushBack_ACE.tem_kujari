_path = "scripts\invasions\";

call compile preprocessFile "scripts\systemes\fonctions_serveur.sqf";

call compile preprocessFile "scripts\RADIO\fonctions.sqf";
BwS_fn_brouilleur = compile preprocessFile "scripts\RADIO\brouilleur.sqf";

BwS_fn_gestion_ville = compile preprocessFile "scripts\gestions\gestionVille.sqf";
BwS_fn_gestion_artillerie = compile preprocessFile (_path+"artillerie.sqf");

BwS_fn_gestionPatrol = compile preprocessFile (_path+"gestionPatrouille.sqf");
BwS_fn_chasseur = compile preprocessFile (_path+"chasseur.sqf");
BwS_fn_zone = compile preprocessFile (_path+"zone.sqf");
BwS_fn_peupler = compile preprocessFile (_path+"peupler.sqf");
BwS_fn_mortier = compile preprocessFile (_path+"mortier.sqf");
BwS_fn_pickups = compile preprocessFile (_path+"pickups.sqf");
BwS_fn_artillerie = compile preprocessFile (_path+"artillerie.sqf");
BwS_fn_camp = compile preprocessFile (_path+"camp.sqf");
BwS_fn_raid = compile preprocessFile (_path+"raid.sqf");
BwS_fn_embuscade_convoi = compile preprocessFile (_path+"embuscade_convoi.sqf");
BwS_fn_embuscade = compile preprocessFile (_path+"embuscade_groupe.sqf");


// spawn fnct only NO CALL ^

BwS_fn_spawnGroup = compile preprocessFile "scripts\spawnGroup.sqf";

// call fnct only NO SPAWN ^