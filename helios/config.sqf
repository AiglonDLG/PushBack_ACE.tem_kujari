/*
*	config.sqf
*	[B.w.S] SoP
*	config.sqf du script Helios
*	23/7/2017
*/

nul = 0 execVM "helios\menus.sqf";

BwS_cfg_fn_condition_configurer_helios = "true";

BwS_cfg_fn_condition_configurer_ecran = "(typeOf cursorObject) in [""Land_TripodScreen_01_large_F"", ""Land_Laptop_device_F"", ""Land_Laptop_unfolded_F"", ""Land_Tablet_02_F"", ""Land_PCSet_01_screen_F"", ""Land_BriefingRoomScreen_01_F""]";

BwS_helios_cfg_action_station_helios = ["<t color='#22FF22'>CONFIGURER HELIOS</t>", {showCommandingMenu "#USER:BwS_HELIOS_MAIN_MENU"}, [], 1.5, false, true, "", BwS_cfg_fn_condition_configurer_helios];

BwS_helios_cfg_action_ecran = ["<t color='#22FF22'>CONFIGURER ECRAN</t>", {showCommandingMenu "#USER:BwS_HELIOS_MENU_ECRAN"}, [], 1.5, false, true, "", BwS_cfg_fn_condition_configurer_ecran];
