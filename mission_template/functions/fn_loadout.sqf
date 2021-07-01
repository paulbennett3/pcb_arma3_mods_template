params ["_this", "_role"];

// "clear the palate" ...
removeallweapons _this;  
removeGoggles _this;
removeHeadgear _this;
removeVest _this;
removeAllAssignedItems _this;
removeBackpack _this;

_this setUnitTrait ["medic", false]; 
_this setUnitTrait ["engineer", false]; 
_this setUnitTrait ["explosiveSpecialist", false]; 

_this forceAddUniform "SGA_SG1_Uniform_desert";
_this addMagazine "50Rnd_570x28_SMG_03";
_this addWeapon "SMG_03C_TR_black";
_this addgoggles "G_Shades_Black";
//_this removeItem "ItemMap";
_this linkItem "ItemMap";
_this linkItem "ItemWatch";
_this linkItem "ItemCompass";
_this linkItem "ItemRadio";
_this addMagazines ["HandGrenade", 2];
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "50Rnd_570x28_SMG_03";
_this addItemToUniform "50Rnd_570x28_SMG_03";
_this addvest "V_PlateCarrier1_blk";
_this addItemToVest "50Rnd_570x28_SMG_03";
_this addItemToVest "50Rnd_570x28_SMG_03";
_this addPrimaryWeaponItem "acc_flashlight";
_this addPrimaryWeaponItem "optic_ACO_grn_smg";
_this addbackpack "B_AssaultPack_blk";

switch (_role) do
{
    case "Medic":
    {
        _this setUnitTrait ["medic", true]; 
        _this addItemTobackpack "Medikit";
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        _this addHeadgear "H_Cap_red";
    };
    case "Leader":
    {
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        _this addWeapon "Binocular";
        _this addHeadgear "H_Cap_blu";
    };
    case "Engineer":
    {
        _this setUnitTrait ["engineer", true];
        _this setUnitTrait ["explosiveSpecialist", true];
        _this setvariable["sga_skills",["Engineer"],true];
        _this addItemTobackpack "ToolKit";
        _this addItemTobackpack "MineDetector";
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        //_this addItem "Item_B_UavTerminal"; // for MALP driving
        _this addHeadgear "H_Bandanna_surfer_grn";
    };
    case "Heavy":
    {
        _this addMagazine "RPG7_F";
        _this addWeapon "launch_RPG7_F";
        (unitBackpack _this) addmagazineCargo ["RPG7_F", 2]; 
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        _this addHeadgear "H_Cap_blk";
    };
    case "Jaffa":
    {
        removeallweapons _this;  
        _this addMagazine "sga_staffweapon_mag_on";
        _this addWeapon "sga_staffweapon";
        _this addMagazine "sga_zat_mag_closed";
        _this addWeapon "sga_zat";
        _this setvariable["sga_skills",["Engineer"],true];
    };
    case "Scholar":
    {
        _this addMagazine "sga_zat_mag_closed";
        _this addWeapon "sga_zat";
        //_this addItem "Item_B_UavTerminal"; // for MALP driving
        _this setUnitTrait ["scholar", true, true];
    };
};
(unitBackpack _this) addmagazineCargo ["50Rnd_570x28_SMG_03", 3];
