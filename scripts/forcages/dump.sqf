_variables_demandees = ["BwS_var_TIC", "BwS_var_pat_attaquants"];

{[clientOwner, _x] remoteExec ["publicVariableClient", 2]} forEach _variables_demandees;

systemChat format ["Nombre d'IA ennemies : %1", count (allUnits select {side _x == BwS_var_side_ennemie})];
systemChat format ["Nombre d'IA civiles : %1", count (allUnits select {side _x == civilian})];
systemChat format ["Nombre d'IA total : %1", count allUnits];
systemChat format ["Nombre de groupes ennemis : %1", count (allGroups select {side _x == BwS_var_side_ennemie})];
systemChat format ["Nombre de TIC (vivants, morts) : %1, %2", count (BwS_var_TIC select {alive _x}), count BwS_var_TIC];
systemChat format ["Nombre de pat attaquantes : %1", count BwS_var_pat_attaquants];