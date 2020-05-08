_entrees = [
	["Missions", 
		"<font size='20'>Opération Pushback - Lythium </font><br />
		<font color='#FFFF00' size='17'>Zones d'opérations des rebelles</font><br />
		Tout le pays est occupé par des forces rebelles
		Il peut se trouver dans la zone : <br />
			- des groupes de combat en mouvement <br />
			- des véhicules armés ou chargés d'hommes <br />
			- des IEDs sur les routes <br />
			- des occupations de maisons (homés) <br />
			- des mortiers <br />
			- des camps d'entrainement ennemis <br />
		<br />
		<font color='#FFFF00' size='17'>Matériel à disposition</font><br />
		Afin d'accomplir la mission, des matériels et technologies sont mis à votre disposition.<br />
		Fonctionnalités: <br />
		    - Intercepteur radio à bord des véhicules FOB et des ALSR (Avions légers de Surveillance et de Reconnaissance). Entrez dans un véhicule FOB ou dans le VIM (Véhicule d'Interception Mobile) et regardez votre carte. Des cercles concentriques apparaitront lorsqu'une emission radio sera détectée. <br />
			- EBN : Espace de bataille numérique. Il faut posséder sur soi une tablette SITCOM (R3F). Cette tablette donne accès à un menu qui permet de renseigner la carte. Divers types de marqueurs sont disponibles.<br />
			- Le détecteur de mines : utilisé par les EOD, il bip à proximité d'un IED ou d'une mine<br />
			- Hélicoptères <br />
			- Véhicules terrestres <br />
			- Véhicules sanitaires (hélicoptères et roulants)<br />
			- Tour de commandement avec détection radar et radio<br />
			- HELIOS : un système d'observation par satellite et de rediffusion en directe des flux vidéos des drones, accessible sur les écrans (orinateurs et sur pieds) ainsi qu'au CO, dans la tour de commandement. Le mode d'emplois est disponnible sur le forum.<br />
			- et de toutes les armes que proposent ArmA III et les addons !<br />
		<br />
		<font color='#FFFF00' size='17'>FOB</font><br />
		Les FOBs sont des camions de transports ouverts. Ils sont déplacés jusque dans la zone dans laquelle les joueurs souhaitent jouer. C'est l'occasion de faire un convoi et de déminer les potentiels IEDs sur la route...<br />
		<u>Conseil de missions</u> : les patrouilles à pied accompagné de véhicules sanitaires représenteront la majeure partie de vos opérations. La fouille des maisons n'est pas forcément obligatoire. En effet, seul 5% des maisons en moyenne représente un danger (homme armé ou mine). Les reconnaissances et l'établissement de points fortifiés dans les hauteurs sont recommandés. La mission sauvegarde les objets créés ainsi que les véhicules sortis d'usine (les véhicules présents sur base ne sont pas sauvés et réapparaitront à la base au redémarrage) ! Attention toutefois, les crédits de l'usine ne sont pas inépuisables et sont sauvegardés. Par ailleurs, les inventaires des véhicules sont sauvés."],
		["Crédits",
			"Mission par [B.w.S] SoP pour la team BwS <a href='http://www.armabws.com'>www.armabws.com</a>"]
	];
	
{player createDiaryRecord ["diary", _x]; } forEach _entrees;