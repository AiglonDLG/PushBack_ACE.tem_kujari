/*
*	config.sqf
*	[B.w.S] SoP
*	
*	19/7/2018
*/

// lieux où des civils vivront
BwS_CBS_cfg_locations = [];

// nombre max de civils présents sur la carte entière
BwS_CBS_cfg_nombre_max_civils = 40;

// nombre moyen d'habitants par type de location
BwS_CBS_cfg_habitants_par_location = 
[
	["NameCityCapital", 30],
	["NameCity", 20],
	["NameVilllage", 20],
	["CityCenter", 20]
];

// taille de la sphère d'influence d'un civil (mètres)
BwS_CBS_cfg_taille_sphere_influence_civil = 100;

// distance min pour spawn
BwS_CBS_cfg_distance_apparition_civil = 500;

// types de civils
BwS_CBS_cfg_types_civils = 
[
	"C_man_1",
	"C_man_1_1_F",
	"C_man_1_2_F",
	"C_man_1_3_F",
	"C_man_polo_1_F",
	"C_man_polo_2_F",
	"C_man_polo_3_F",
	"C_man_polo_4_F",
	"C_man_polo_5_F",
	"C_man_polo_6_F",
	"C_Orestes",
	"C_Nikos",
	"C_man_p_fugitive_F",
	"C_man_p_fugitive_F_afro",
	"C_man_p_fugitive_F_euro",
	"C_man_p_fugitive_F_asia",
	"C_man_p_beggar_F",
	"C_man_p_beggar_F_afro",
	"C_man_p_beggar_F_euro",
	"C_man_p_beggar_F_asia",
	"C_man_w_worker_F",
	"C_man_hunter_1_F",
	"C_man_p_shorts_1_F",
	"C_man_p_shorts_1_F_afro",
	"C_man_p_shorts_1_F_euro",
	"C_man_p_shorts_1_F_asia",
	"C_man_shorts_1_F",
	"C_man_shorts_1_F_afro",
	"C_man_shorts_1_F_euro",
	"C_man_shorts_1_F_asia",
	"C_man_shorts_2_F",
	"C_man_shorts_2_F_afro",
	"C_man_shorts_2_F_euro",
	"C_man_shorts_2_F_asia",
	"C_man_shorts_3_F",
	"C_man_shorts_3_F_afro",
	"C_man_shorts_3_F_euro",
	"C_man_shorts_3_F_asia",
	"C_man_shorts_4_F",
	"C_man_shorts_4_F_afro",
	"C_man_shorts_4_F_euro",
	"C_man_shorts_4_F_asia",
	"C_man_pilot_F",
	"C_man_polo_1_F_afro",
	"C_man_polo_1_F_euro",
	"C_man_polo_1_F_asia",
	"C_man_polo_2_F_afro",
	"C_man_polo_2_F_euro",
	"C_man_polo_2_F_asia",
	"C_man_polo_3_F_afro",
	"C_man_polo_3_F_euro",
	"C_man_polo_3_F_asia",
	"C_man_polo_4_F_afro",
	"C_man_polo_4_F_euro",
	"C_man_polo_4_F_asia",
	"C_man_polo_5_F_afro",
	"C_man_polo_5_F_euro",
	"C_man_polo_5_F_asia",
	"C_man_polo_6_F_afro",
	"C_man_polo_6_F_euro",
	"C_man_polo_6_F_asia"
];

BwS_CBS_cfg_center = createCenter civilian;
