/*
*	config.sqf
*	[B.w.S] SoP
*	fichier de configuration du script Close Air Support
*	24/10/2017
*/

//BwS_cfg_fn_condition_request = """item_R3F_SIT_COMDE"" in (items player)";
BwS_cfg_fn_condition_request = "false";
BwS_CAS_cfg_action_request = ["<t size='1.3'>Request support</t>", {showCommandingMenu "#USER:BwS_CAS_MENU_REQUEST"}, [], 1.5, false, true, "", BwS_cfg_fn_condition_request];