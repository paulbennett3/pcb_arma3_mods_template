/* ------------------------------------------------------
                   crate_loadout

For setting up the loadout on "crates" 

_crate -- the item to set the loadout on
_loadout_name - string specifying loadout type(s)
------------------------------------------------------- */

params ["_obj", "_loadout_name"];

if (! isServer) exitWith { diag_log "fn_crate_loadout called on non-server"; };
sleep .1;
clearItemCargoGlobal _obj;
sleep .1;
clearWeaponCargoGlobal _obj;
sleep .1;
clearMagazineCargoGlobal _obj;
sleep .1;
clearBackpackCargoGlobal _obj;
sleep .1;
diag_log "Cleared loadout crate";
diag_log (str (magazineCargo _obj));
diag_log (str (magazinesAmmoCargo _obj));
diag_log (str (weaponCargo _obj));
diag_log (str (weaponsItemsCargo _obj));
diag_log (str (itemCargo _obj));
sleep 1;

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

sleep .1;
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 60, 100];
_obj addMagazineAmmoCargo ["30Rnd_9x21_Green_Mag", 20, 30];

_obj addMagazineAmmoCargo ["1Rnd_HE_Grenade_shell", 40, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeGreen_Grenade_shell", 8, 1];
_obj addMagazineAmmoCargo ["ClaymoreDirectionalMine_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 8, 1];
_obj addMagazineAmmoCargo ["Titan_AP", 8, 1];
_obj addMagazineAmmoCargo ["UGL_FlareGreen_F", 8, 1];
// item
_obj addItemCargoGlobal ["FirstAidKit", 20];
_obj addItemCargoGlobal ["Medikit", 2];
_obj addItemCargoGlobal ["muzzle_snds_H", 1];
_obj addItemCargoGlobal ["optic_DMS", 4];
_obj addItemCargoGlobal ["optic_Hamr", 4];
_obj addItemCargoGlobal ["optic_LRPS", 4];
_obj addItemCargoGlobal ["optic_MRD", 4];
_obj addItemCargoGlobal ["optic_NVS", 4];
_obj addItemCargoGlobal ["optic_SOS", 4];
_obj addItemCargoGlobal ["optic_tws", 4];
_obj addItemCargoGlobal ["optic_tws_mg", 4];
_obj addItemCargoGlobal ["ToolKit", 2];

// backpack
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 2];
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 2];

