params ["_this", "_role"];

removeallweapons _this;  
removeGoggles _this;
removeHeadgear _this;
removeVest _this;
removeAllAssignedItems _this;

_this forceAddUniform "SGA_SG1_Uniform_desert";
_this addHeadgear "H_Cap_oli";
_this addMagazine "50Rnd_570x28_SMG_03";
_this addWeapon "SMG_03C_black";
_this addvest "V_PlateCarrier1_blk";
_this addgoggles "G_Shades_Black";
_this removeItem "ItemMap";
_this linkItem "ItemWatch";
_this linkItem "ItemCompass";
_this linkItem "ItemRadio";
_this addItemToVest "FirstAidKit";
_this addPrimaryWeaponItem "acc_flashlight";
_this addPrimaryWeaponItem "optic_Aco";
_this addMagazine "HandGrenade";
_this addMagazine "HandGrenade";
_this addbackpack "B_AssaultPack_blk";
_this addmagazineCargo ["DemoCharge_Remote_Mag", 1];
(unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
_this addItemToVest "50Rnd_570x28_SMG_03";
_this addItemToVest "50Rnd_570x28_SMG_03";
_this addItemTobackpack "50Rnd_570x28_SMG_03";
_this addItemTobackpack "50Rnd_570x28_SMG_03";
if (_role == "Medic") then {
    _this setUnitTrait ["medic", true]; 
    _this addItemTobackpack "Medikit";
};
_this setUnitTrait ["engineer", false];
_this setUnitTrait ["explosiveSpecialist", false];
_this setvariable["sga_skills",["Engineer"],true];
