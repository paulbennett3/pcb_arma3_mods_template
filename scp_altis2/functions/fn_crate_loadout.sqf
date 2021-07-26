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
_obj addItemCargoGlobal ["arifle_MXC_F", 4];
_obj addItemCargoGlobal ["arifle_MXM_F", 4];
_obj addItemCargoGlobal ["arifle_MX_F", 4];
_obj addItemCargoGlobal ["arifle_MX_GL_F", 4];
_obj addItemCargoGlobal ["arifle_MX_SW_F", 4];
_obj addItemCargoGlobal ["hgun_P07_F", 4];
_obj addItemCargoGlobal ["launch_Titan_F", 1];
_obj addItemCargoGlobal ["launch_Titan_short_F", 1];
_obj addItemCargoGlobal ["vn_izh54_p", 2];
_obj addItemCargoGlobal ["Binocular", 2];
_obj addItemCargoGlobal ["Laserdesignator", 2];
_obj addItemCargoGlobal ["Rangefinder", 2];
_obj addItemCargoGlobal ["vn_m79_p", 2];
sleep .1;
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 40, 100];
_obj addMagazineAmmoCargo ["30Rnd_65x39_caseless_mag", 40, 30];
_obj addMagazineAmmoCargo ["30Rnd_9x21_Mag_SMG_02", 40, 30]; // gendarmes
_obj addMagazineAmmoCargo ["16Rnd_9x21_Mag", 40, 30]; // gendarmes, pistols
_obj addMagazineAmmoCargo ["HandGrenade", 8, 1];
_obj addMagazineAmmoCargo ["MiniGrenade", 8, 1];
_obj addMagazineAmmoCargo ["vn_molotov_grenade_mag", 8, 1];
_obj addMagazineAmmoCargo ["vn_m14_grenade_mag", 8, 1];
_obj addMagazineAmmoCargo ["vn_m18_green_mag", 8, 1];

_obj addMagazineAmmoCargo ["1Rnd_HE_Grenade_shell", 20, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeGreen_Grenade_shell", 5, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeYellow_Grenade_shell", 5, 1];
_obj addMagazineAmmoCargo ["APERSBoundingMine_Range_Mag", 2, 1];
_obj addMagazineAmmoCargo ["APERSMine_Range_Mag", 2, 1];
_obj addMagazineAmmoCargo ["APERSTripMine_Wire_Mag", 2, 1];
_obj addMagazineAmmoCargo ["ATMine_Range_Mag", 2, 1];
_obj addMagazineAmmoCargo ["ClaymoreDirectionalMine_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 8, 1];
_obj addMagazineAmmoCargo ["Laserbatteries", 2, 1];
_obj addMagazineAmmoCargo ["SatchelCharge_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["SLAMDirectionalMine_Wire_Mag", 2, 1];
_obj addMagazineAmmoCargo ["Titan_AA", 2, 1];
_obj addMagazineAmmoCargo ["Titan_AP", 2, 1];
_obj addMagazineAmmoCargo ["Titan_AT", 2, 1];
_obj addMagazineAmmoCargo ["UGL_FlareGreen_F", 4, 1];
_obj addMagazineAmmoCargo ["UGL_FlareWhite_F", 4, 1];
_obj addMagazineAmmoCargo ["vn_izh54_mag", 10, 1];
_obj addMagazineAmmoCargo ["Chemlight_green", 4, 1];
// item
_obj addItemCargoGlobal ["acc_flashlight", 4];
_obj addItemCargoGlobal ["acc_pointer_IR", 4];
_obj addItemCargoGlobal ["FirstAidKit", 20];
_obj addItemCargoGlobal ["ItemGPS", 4];
_obj addItemCargoGlobal ["Medikit", 2];
_obj addItemCargoGlobal ["muzzle_snds_H", 2];
_obj addItemCargoGlobal ["muzzle_snds_H_SW", 2];
_obj addItemCargoGlobal ["optic_Aco", 2];
_obj addItemCargoGlobal ["optic_DMS", 2];
_obj addItemCargoGlobal ["optic_Hamr", 2];
_obj addItemCargoGlobal ["optic_Holosight", 2];
_obj addItemCargoGlobal ["optic_LRPS", 2];
_obj addItemCargoGlobal ["optic_MRD", 2];
_obj addItemCargoGlobal ["optic_NVS", 2];
_obj addItemCargoGlobal ["optic_SOS", 2];
_obj addItemCargoGlobal ["optic_tws", 2];
_obj addItemCargoGlobal ["optic_tws_mg", 2];
_obj addItemCargoGlobal ["ToolKit", 2];
_obj addItemCargoGlobal ["DSA_Detector", 4];
_obj addItemCargoGlobal ["B_UavTerminal", 4];
_obj addItemCargoGlobal ["ItemWatch", 2];
_obj addItemCargoGlobal ["ItemRadio", 4];
_obj addItemCargoGlobal ["ItemMap", 2];
_obj addItemCargoGlobal ["NVGoggles_OPFOR", 4];
_obj addItemCargoGlobal ["ItemCompass", 4];
_obj addItemCargoGlobal ["ChemicalDetector_01_watch_F", 4];

// backpack
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 4];
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 4];


// ---

