/* ------------------------------------------------------
                   crate_loadout

For setting up the loadout on "crates" 

_crate -- the item to set the loadout on
_loadout_name - string specifying loadout type(s)
------------------------------------------------------- */

params ["_obj", "_loadout_name"];

if (! isServer) exitWith { diag_log "fn_crate_loadout called on non-server"; };
clearItemCargoGlobal _obj;
clearWeaponCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearBackpackCargoGlobal _obj;

// weapon
_obj addItemCargoGlobal ["arifle_MXM_F", 8];
_obj addItemCargoGlobal ["arifle_MX_F", 8];
_obj addItemCargoGlobal ["arifle_MX_GL_F", 8];
_obj addItemCargoGlobal ["arifle_MX_SW_F", 8];
_obj addItemCargoGlobal ["hgun_Rook40_F", 8];
_obj addItemCargoGlobal ["launch_Titan_short_F", 8];
_obj addItemCargoGlobal ["Binocular", 4];
_obj addItemCargoGlobal ["Laserdesignator", 4];
_obj addItemCargoGlobal ["Rangefinder", 4];
_obj addItemCargoGlobal ["vn_m72", 8];
_obj addItemCargoGlobal ["vn_m79", 8];
_obj addItemCargoGlobal ["vn_m72_mag", 8];
_obj addItemCargoGlobal ["vn_m1897", 4];
_obj addItemCargoGlobal ["vn_m1897_fl_mag", 4]; // magazineAmmo?!?
_obj addItemCargoGlobal ["vn_m1897_buck_mag", 4]; // magazineAmmo?!?
_obj addItemCargoGlobal ["launch_RPG7_F", 4];
_obj addItemCargoGlobal ["RPG7_F", 4];

sleep .1;
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 60, 100];
_obj addMagazineAmmoCargo ["30Rnd_65x39_caseless_mag", 60, 30];
_obj addMagazineAmmoCargo ["30Rnd_9x21_Green_Mag", 20, 30];
_obj addMagazineAmmoCargo ["30Rnd_762x39_AK12_Mag_F",20,30];
_obj addMagazineAmmoCargo ["75rnd_762x39_AK12_Mag_Tracer_F",10,75];
_obj addMagazineAmmoCargo ["CUP_1Rnd_HEDP_M203",10,1];
_obj addMagazineAmmoCargo ["CUP_OG7_M",10,1];
_obj addMagazineAmmoCargo ["CUP_PG7V_M",10,1];
_obj addMagazineAmmoCargo ["CUP_1Rnd_SmokeGreen_GP25_M",10,1];
_obj addMagazineAmmoCargo ["CUP_IlumFlareGreen_GP25_M",10,1];
_obj addMagazineAmmoCargo ["CUP_1Rnd_HE_GP25_M",10,1];

_obj addMagazineAmmoCargo ["CUP_1Rnd_HEDP_M203", 40, 1];
_obj addMagazineAmmoCargo ["1Rnd_HE_Grenade_shell", 40, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeGreen_Grenade_shell", 8, 1];
_obj addMagazineAmmoCargo ["ClaymoreDirectionalMine_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 8, 1];
_obj addMagazineAmmoCargo ["Titan_AP", 8, 1];
_obj addMagazineAmmoCargo ["UGL_FlareGreen_F", 8, 1];
_obj addMagazineAmmoCargo ["Chemlight_green", 8, 1];
_obj addMagazineAmmoCargo ["Chemlight_blue", 8, 1];
_obj addMagazineAmmoCargo ["Chemlight_red", 8, 1];
// item
_obj addItemCargoGlobal ["FirstAidKit", 20];
_obj addItemCargoGlobal ["Medikit", 2];
_obj addItemCargoGlobal ["muzzle_snds_H", 1];
_obj addItemCargoGlobal ["optic_ACO_grn", 4];
_obj addItemCargoGlobal ["optic_Aco", 4];
_obj addItemCargoGlobal ["optic_DMS", 4];
_obj addItemCargoGlobal ["optic_Hamr", 4];
_obj addItemCargoGlobal ["optic_LRPS", 4];
_obj addItemCargoGlobal ["optic_MRD", 4];
_obj addItemCargoGlobal ["optic_NVS", 4];
_obj addItemCargoGlobal ["optic_SOS", 4];
_obj addItemCargoGlobal ["optic_tws", 4];
_obj addItemCargoGlobal ["optic_tws_mg", 4];
_obj addItemCargoGlobal ["ToolKit", 2];
_obj addItemCargoGlobal ["MineDetector", 2];
_obj addItemCargoGlobal ["acc_flashlight", 2];
_obj addItemCargoGlobal ["B_UavTerminal", 2];

// backpack
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 2];
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
_obj addBackpackCargoGlobal ["B_UGV_02_Demining_backpack_F", 1];
_obj addBackpackCargoGlobal ["B_UGV_02_Science_backpack_F", 1];
