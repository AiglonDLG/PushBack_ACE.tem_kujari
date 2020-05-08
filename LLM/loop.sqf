BwS_LLM_var_terrestres_en_route = [];

while {true} do
{
	if (count BwS_LLM_var_terrestres_en_route < BwS_LLM_cfg_min_terrestres_en_route && count allPlayers > 0) then 
	{
		[] spawn BwS_LLM_fn_nouveau_terrestre;
	};
	sleep 1;
};