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
private _helmet = "H_Cap_red";
private _goggles = "G_Shades_Black";

private _no_gun = false; // used to keep scholar and jaffa weapons
private _gun_grenadier = "";
private _gun_carbine = "";
private _gun_marksman = "";
private _gun_lmg = "";
private _scope_marksman = "";

if (pcb_mod_name isEqualTo "scp") then {
    _uniform = "YSA_Uniform_URBAN_MARPAT";
    _ammo = "30Rnd_65x39_caseless_black_mag";
    _gun = "arifle_MX_Black_F";
    _scope = "optic_Arco_blk_F";

    _gun_grenadier = "arifle_MX_GL_Black_F";
    _gun_carbine = "arifle_MXC_Black_F";

    _gun_marksman = "arifle_MXM_Black_F";  // MXM + DMS?
    _scope_marksman = "optic_tws_mg";

    _gun_lmg = "arifle_MX_SW_Black_F";   // MX-SW  TWS-MG
    _helmet = "H_PASGT_basic_black_F";
    _goggles = "G_Combat";
};

_this forceAddUniform _uniform;
_this linkItem "ItemMap";
_this linkItem "ItemWatch";
_this linkItem "ItemCompass";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
_this addGoggles _goggles;
_this addMagazines ["HandGrenade", 2];
_this addItemToUniform "FirstAidKit";

_this addVest "V_PlateCarrier1_blk";
_this addbackpack "B_AssaultPack_blk";

switch (_role) do
{
    case "Medic":
    {
        _this setUnitTrait ["medic", true]; 

        _this addItemTobackpack "Medikit";
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 

        if (pcb_mod_name isEqualTo "stargate") then { 
            _this addHeadgear "H_Cap_red";
        } else {
            _this addHeadgear _helmet;
            _this linkItem "NVGoggles_OPFOR";  // night vision!
            _gun = _gun_carbine;
        };
    };
    case "Leader":
    {
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        _this addWeapon "Binocular";

        if (pcb_mod_name isEqualTo "stargate") then { 
            _this addHeadgear "H_Cap_blu";
        } else {
            _this addHeadgear _helmet;
            _this linkItem "NVGoggles_OPFOR";  // night vision!
        };
    };
    case "Engineer":
    {
        _this setUnitTrait ["engineer", true];
        _this setUnitTrait ["explosiveSpecialist", true];
        _this setvariable["sga_skills",["Engineer"],true];

        _this addItemTobackpack "ToolKit";
        _this addItemTobackpack "MineDetector";
        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
        _this addItem "B_UavTerminal"; // for MALP driving

        if (pcb_mod_name isEqualTo "stargate") then { 
            _this addHeadgear "H_Bandanna_surfer_grn";
        } else {
            _this addHeadgear _helmet;
            _gun = _gun_carbine;
        };
    };
    case "Machine Gunner":
    {
        _gun = _gun_lmg;   // MX-SW  TWS-MG

        (unitBackpack _this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 

        if (pcb_mod_name isEqualTo "stargate") then { 
            _this addHeadgear "H_Cap_blk";
        } else {
           //_this addItem "bipod_01_f_blk";
           _this addHeadgear _helmet;
        };
    };
    case "Scholar":
    {
        _this setUnitTrait ["scholar", true, true];

        if (pcb_mod_name isEqualTo "stargate") then {
            _this addHeadgear "H_Cap_blk";
        } else {
           _gun = _gun_carbine;
           _this addHeadgear _helmet;
        };
    };
    case "Marksman":
    {
        _gun = _gun_marksman;  // MXM + DMS?
        _scope = _scope_marksman;

        if (pcb_mod_name isEqualTo "stargate") then { 
        } else {
           _this addItem "bipod_01_f_blk";
           _this addHeadgear _helmet;
        };
    };
    case "Grenadier":
    {
        _gun = _gun_grenadier;
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_HE_Grenade_shell";
        _this addItemToVest "1Rnd_SmokeRed_Grenade_shell";
        _this addItemToVest "1Rnd_SmokeGreen_Grenade_shell";
        _this addItemToVest "3Rnd_UGL_FlareGreen_F";
  
        // flares? smoke?

        if (pcb_mod_name isEqualTo "stargate") then { 
        } else {
           _this addHeadgear _helmet;
        };
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

        if (pcb_mod_name isEqualTo "stargate") then { 
        } else {
           _this addHeadgear _helmet;
        };
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
    _this addWeaponItem [_gun, "1Rnd_HE_Grenade_shell"];
};


// top up with some more ammo
(unitBackpack _this) addmagazineCargo [_ammo, 3];
_this addItemToUniform _ammo;
_this addItemToUniform _ammo;
_this addItemToVest _ammo;
_this addItemToVest _ammo;

