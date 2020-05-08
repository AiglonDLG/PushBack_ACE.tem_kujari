#include "\task_force_radio\functions\common.sqf";

tf_no_auto_long_range_radio = true;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;

_settingsSw = false call TFAR_fnc_generateSwSettings;
sleep 0.01;
_settingsSw set [2, ["32","64","128","256","512","81","243","125"]];
tf_freq_guer = _settingsSw;	
tf_freq_west = _settingsSw;
tf_freq_east = _settingsSw;

_settingsLr = false call TFAR_fnc_generateLrSettings;
sleep 0.01;
_settingsLr set [2, ["32","64","128","256","512","81","243","125"]];
tf_freq_guer_lr = _settingsLr;
tf_freq_west_lr = _settingsLr;
tf_freq_east_lr = _settingsLr;
