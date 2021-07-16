params ["_this"];

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add weapons";
_this addWeapon "arifle_MX_SW_F";
_this addPrimaryWeaponItem "acc_flashlight";
_this addPrimaryWeaponItem "100Rnd_65x39_caseless_mag";
_this addPrimaryWeaponItem "bipod_01_F_snd";
_this addWeapon "hgun_Pistol_heavy_01_F";
_this addHandgunItem "acc_flashlight_pistol";
_this addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_this forceAddUniform "U_B_CTRG_Soldier_Arid_F";
_this addVest "V_PlateCarrier2_rgr_noflag_F";
_this addBackpack "B_Kitbag_rgr";

comment "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "DSA_Detector";
_this addItemToUniform "Chemlight_green";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
_this addItemToVest "SmokeShell";
for "_i" from 1 to 2 do {_this addItemToVest "DemoCharge_Remote_Mag";};
for "_i" from 1 to 2 do {_this addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 3 do {_this addItemToBackpack "100Rnd_65x39_caseless_mag_Tracer";};
_this addHeadgear "H_HelmetB_TI_arid_F";
_this addGoggles "G_Balaclava_TI_G_blk_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ChemicalDetector_01_watch_F";
_this linkItem "ItemRadio";
_this linkItem "B_UavTerminal";
_this linkItem "NVGogglesB_blk_F";

