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
_this addWeapon "arifle_MXC_F";
_this addPrimaryWeaponItem "acc_flashlight";
_this addPrimaryWeaponItem "optic_Hamr";
_this addPrimaryWeaponItem "100Rnd_65x39_caseless_mag";
_this addWeapon "hgun_Rook40_F";
_this addHandgunItem "30Rnd_9x21_Green_Mag";


comment "Add containers";
_this forceAddUniform "U_B_CTRG_Soldier_Arid_F";
_this addVest "V_PlateCarrier2_rgr_noflag_F";
_this addBackpack "B_Kitbag_rgr";

comment "Add items to containers";
_this addItemToUniform "FirstAidKit";
//_this addItemToUniform "DSA_Detector";
_this addItemToUniform "B_UavTerminal";
for "_i" from 1 to 2 do {_this addItemToVest "DemoCharge_Remote_Mag";};
_this addItemToVest "30Rnd_9x21_Green_Mag";
_this addItemToVest "30Rnd_9x21_Green_Mag";
for "_i" from 1 to 5 do {_this addItemToBackpack "100Rnd_65x39_caseless_mag_Tracer";};
_this addHeadgear "H_HelmetB_TI_arid_F";
_this addGoggles "G_Balaclava_TI_G_blk_F";
_this addItemToBackpack "SmokeShellRed";
_this addItemToBackpack "SmokeShellRed";
_this addItemToBackpack "Chemlight_red";
_this addItemToBackpack "acc_pointer_IR";



comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ChemicalDetector_01_watch_F";
_this linkItem "ItemRadio";
// _this linkItem "B_UavTerminal";
_this linkItem "NVGogglesB_blk_F";
_this linkItem "DSA_Detector";


