// jusqu'à ce que y ait une maison, un mec sort avec un rpg, et seulement un rpg, et tire sur ce qu'il voit (reveal) puis une patrouille avec éventuellement un pickup armé sort de n'importe où autour
_joueur = _this select 0;

waitUntil {count ((position _joueur) nearObjects ["House", 350]) > 0};

_maisons = ((position _joueur) nearObjects ["House", 350]);

_pos = selectRandom ((selectRandom _maisons) buildingPos -1);

_group = createGroup BwS_var_side_ennemie;

"rhs_g_Soldier_AT_F" createUnit [_pos, _group, "", 1];

_unit = (units _group) select 0;

_unit reveal _joueur;

_unit move (position _joueur);
_unit doTarget _joueur;