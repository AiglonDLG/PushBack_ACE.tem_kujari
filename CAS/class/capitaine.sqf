comment "Exported from Arsenal by [B.w.S] SoP";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "BwS_T_CNE";
for "_i" from 1 to 2 do {_this addItemToUniform "SmokeShellBlue";};
for "_i" from 1 to 3 do {_this addItemToUniform "SmokeShell";};
_this addVest "BwS_Gilet";
for "_i" from 1 to 4 do {_this addItemToVest "R3F_APAV40";};
for "_i" from 1 to 2 do {_this addItemToVest "R3F_AC58";};
for "_i" from 1 to 8 do {_this addItemToVest "R3F_30Rnd_556x45_FAMAS";};
_this addItemToVest "HandGrenade";
_this addItemToVest "R3F_15Rnd_9x19_HKUSP";
_this addBackpack "BwS_Compact";
for "_i" from 1 to 3 do {_this addItemToBackpack "ACE_epinephrine";};
for "_i" from 1 to 3 do {_this addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_elasticBandage";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_packingBandage";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_quikclot";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 4 do {_this addItemToBackpack "ACE_tourniquet";};
_this addItemToBackpack "ACE_EarPlugs";
_this addHeadgear "BwS_Casque";

comment "Add weapons";
_this addWeapon "R3F_Famas_surb_HG";
_this addPrimaryWeaponItem "R3F_J4";
_this addWeapon "R3F_HKUSP";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "tf_microdagr";
_this linkItem "tf_anprc152_10";
_this linkItem "ItemGPS";

comment "Set identity";
_this setFace "WhiteHead_16";
_this setSpeaker "male01eng";
