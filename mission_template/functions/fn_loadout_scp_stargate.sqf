// Defines loadouts for both SCP and Stargate ARMA missions
// Switch between the two with
// pcb_mod_name = "scp" or pcb_mod_name = "stargate"
params ["_this", "_role"];

// ------------------------------------------------------
// "clear the palate" ...
// ------------------------------------------------------
removeallweapons _this;  
removeGoggles _this;
removeHeadgear _this;
removeVest _this;
removeAllAssignedItems _this;
removeBackpack _this;

_this setUnitTrait ["medic", false]; 
_this setUnitTrait ["engineer", false]; 
_this setUnitTrait ["explosiveSpecialist", false]; 
_this setUnitTrait ["scholar", false, true]; 
_this setUnitTrait ["arcane", false, true]; 
// ------------------------------------------------------


// default is stargate
private _ammo = "50Rnd_570x28_SMG_03";
private _gun = "SMG_03C_TR_black";
private _uniform = "SGA_SG1_Uniform_desert";
private _scope = "optic_ACO_grn_smg";

private _no_gun = false; // used to keep scholar and jaffa weapons

if (pcb_mod_name isEqualTo "scp") then {
    _uniform = "U_B_CombatUniform_mcam";
    _ammo = "30Rnd_65x39_caseless_mag";
    _gun = "arifle_MX_Black_F";
    _scope = "optic_tws";

    _gun_grenadier = "arifle_MX_GL_Black_F";
    _gun_carbine = "arifle_MXC_Black_F";

    _gun_marksman = "arifle_MXM_Black_F";  // MXM + DMS?
    _scope_marksman = "optic_tws_mg";

    _gun_lmg = "arifle_MX_SW_Black_F";   // MX-SW  TWS-MG
    _scope_lmg = "optic_tws_mg";
    _ammo_lmg = "100Rnd_65x39_caseless_mag";

    _this linkItem "NVGoggles_OPFOR";  // night vision!
};

_this addgoggles "G_Shades_Black";
_this linkItem "ItemMap";
_this linkItem "ItemWatch";
_this linkItem "ItemCompass";
_this linkItem "ItemRadio";
_this addMagazines ["HandGrenade", 2];
_this addItemToUniform "FirstAidKit";
_this addItemToUniform _ammo;
_this addItemToUniform _ammo;
_this addvest "V_PlateCarrier1_blk";
_this addItemToVest _ammo;
_this addItemToVest _ammo;

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
        _this addHeadgear "H_Bandanna_surfer_grn";
        _this addItem "B_UavTerminal"; // for MALP driving
    };
    case "Machine Gunner":
    {
        _this removemagazines _ammo;
        _gun = _gun_lmg;   // MX-SW  TWS-MG
        _scope = _scope_lmg;
        _ammo = _ammo_lmg;

        //_this addMagazine "RPG7_F";
        //_this addWeapon "launch_RPG7_F";
        //(unitBackpack _this) addmagazineCargo ["RPG7_F", 2]; 

        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        _this addHeadgear "H_Cap_blk";

        // bipod?
        if (pcb_mod_name isEqualTo "scp") then { 
           _this addItem "bipod_01_f_blk";
        };
    };
    case "Scholar":
    {
        //_this removeWeapon _gun;
        //_this removemagazines _ammo;
        _this setUnitTrait ["scholar", true, true];

        if (pcb_mod_name isEqualTo "stargate") then {
        //    //_this addMagazine "sga_zat_mag_closed";
        //    //_this addWeapon "sga_zat";
        //    _ammo = "16Rnd_9x21_Mag";
        //    _this addMagazine _ammo;
        //    _this addWeapon "hgun_P07_blk_F";
        //    _this addHandgunItem "acc_flashlight_pistol";
        //    
        //    _no_gun = true;
        } else {
           _gun = _gun_carbine;
        };
    };
    case "Marksman":
    {
        _gun = _gun_marksman;  // MXM + DMS?
        _scope = _scope_marksman;
        _this addItem "bipod_01_f_blk";
    };
    case "Grenadier":
    {
        _gun = _gun_grenadier;
        _this addItemToVest "3Rnd_HE_Grenade_shell";
        _this addItemToVest "3Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_SmokeRed_Grenade_shell";
        _this addItemToVest "1Rnd_SmokeGreen_Grenade_shell";
        _this addItemToVest "3Rnd_UGL_FlareGreen_F";
  
        // flares? smoke?
    };
    case "Jaffa":
    {
        _this removeWeapon _gun;
        _this removemagazines _ammo;
        _this addMagazine "sga_staffweapon_mag_on";
        _this addWeapon "sga_staffweapon";
        _this addMagazine "sga_zat_mag_closed";
        _this addWeapon "sga_zat";
        _this setvariable["sga_skills",["Engineer"],true];
        //_this setObjectTextureGlobal [0, "sga_jaffa\data\tat\chronos_silv_ca.paa"];
        _no_gun = true;
    };
};

// down here to allow roles to change scope, gun
_this addMagazine _ammo;
if (! _no_gun) then {
    _this addWeapon _gun;
    _this addPrimaryWeaponItem "acc_flashlight";
    _this addPrimaryWeaponItem _scope;
};

if (_role isEqualTo "Grenadier") then {
    this addWeaponItem [_gun, "1Rnd_HE_Grenade_shell"];
};


// top up with some more ammo
(unitBackpack _this) addmagazineCargo [_ammo, 3];
