
waitUntil {!isNull player};
sleep 1;
if (joueurEOD) then 
{
	BwS_joueur_est_en_train_de_detecter = false;

	player addAction 	
		["Activer le détecteur de mines", 
		{BwS_joueur_est_en_train_de_detecter = true; player forceWalk true;},
		[], 
		1.5, 
		false, 
		true, 
		"", 
		"((""MineDetector"" in (items player + assignedItems player)) && !BwS_joueur_est_en_train_de_detecter)"];

	player addAction 
		["Désactiver le détecteur de mines", 
		{BwS_joueur_est_en_train_de_detecter = false; player forceWalk false;},
		[], 
		1.5, 
		false, 
		true, 
		"", 
		"((""MineDetector"" in (items player + assignedItems player)) && BwS_joueur_est_en_train_de_detecter)"];
};

// player addAction  [
	// "<t color='#00FF00'>S'équiper</t>", 
	// {showCommandingMenu "#USER:BwS_MENU_STUFF"}, 
	// [], 
	// 1, 
	// false, 
	// true, 
	// "",
	// "player distance markerPos ""PC"" < 300"
// ];

// player addAction ["<t color='#ffff33'>Mettre les bouchons d'oreille</t>",{
					// _s = _this select 0;
					// _i = _this select 2;
					// if (soundVolume != 1) then {
						// 1 fadeSound 1;
						// _s setUserActionText [_i,"<t color='#ffff33'>Mettre les bouchons d'oreille</t>"];
					// } else {
						// 1 fadeSound 0.25;
						// _s setUserActionText [_i,"<t color='#ffff33'>Enlever les bouchons d'oreille</t>"];
					// }
				// },[],-90,false,true,"gunElevDown","_target == vehicle player"];
				
// player addAction 
    	// ["<t color='#CC2222'>Espace de Bataille Numérique (EBN)</t>", 
		// {showCommandingMenu "#USER:BwS_MENU_EBN"}, 
		// [], 
		// 1, 
		// false, 
		// true, 
		// "User1",
		// "((""B_UavTerminal"" in (items player + assignedItems player)) || ((typeof vehicle player == ""BwS_Fennek"") && (commander vehicle player == player))) || joueurBwS"];	

// player addAction
	// ["Options", 
	// {showCommandingMenu "#USER:BwS_MAIN_MENU"},
	// [], 
	// 1.5, 
	// false, 
	// true, 
	// "", 
	// "true"];