/* ------------------------------------------------------
                   crate_loadout

For setting up the loadout on "crates" 

_crate -- the item to set the loadout on
_loadout_name - string specifying loadout type(s)
------------------------------------------------------- */

params ["_obj", "_loadout_name"];

clearItemCargoGlobal _obj;
clearWeaponCargo _obj;
clearMagazineCargo _obj;

// weapon
_obj addItemCargoGlobal ["arifle_MXC_F", 4];
_obj addItemCargoGlobal ["arifle_MXM_F", 4];
_obj addItemCargoGlobal ["arifle_MX_F", 4];
_obj addItemCargoGlobal ["arifle_MX_GL_F", 4];
_obj addItemCargoGlobal ["arifle_MX_SW_F", 4];
_obj addItemCargoGlobal ["hgun_P07_F", 4];
_obj addItemCargoGlobal ["launch_NLAW_F", 2];
_obj addItemCargoGlobal ["launch_Titan_F", 1];
_obj addItemCargoGlobal ["launch_Titan_short_F", 1];
_obj addItemCargoGlobal ["vn_m72", 4];
_obj addItemCargoGlobal ["vn_m1897", 4];
_obj addItemCargoGlobal ["vn_m79", 4];
_obj addItemCargoGlobal ["vn_izh54_p", 4];
_obj addItemCargoGlobal ["vn_m79_p", 4];
_obj addItemCargoGlobal ["Binocular", 4];
_obj addItemCargoGlobal ["Laserdesignator", 4];
_obj addItemCargoGlobal ["Rangefinder", 4];
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 20, 100];
_obj addMagazineAmmoCargo ["16Rnd_9x21_Mag", 10, 16];
_obj addMagazineAmmoCargo ["1Rnd_HE_Grenade_shell", 20, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeGreen_Grenade_shell", 5, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeYellow_Grenade_shell", 5, 1];
_obj addMagazineAmmoCargo ["30Rnd_65x39_caseless_mag", 30, 30];
_obj addMagazineAmmoCargo ["APERSBoundingMine_Range_Mag", 4, 1];
_obj addMagazineAmmoCargo ["APERSMine_Range_Mag", 4, 1];
_obj addMagazineAmmoCargo ["APERSTripMine_Wire_Mag", 4, 1];
_obj addMagazineAmmoCargo ["ATMine_Range_Mag", 4, 1];
_obj addMagazineAmmoCargo ["B_IR_Grenade", 4, 1];
_obj addMagazineAmmoCargo ["ClaymoreDirectionalMine_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["HandGrenade", 10, 1];
_obj addMagazineAmmoCargo ["Laserbatteries", 2, 1];
_obj addMagazineAmmoCargo ["MiniGrenade", 10, 1];
_obj addMagazineAmmoCargo ["NLAW_F", 10, 1];
_obj addMagazineAmmoCargo ["SatchelCharge_Remote_Mag", 10, 1];
_obj addMagazineAmmoCargo ["SLAMDirectionalMine_Wire_Mag", 4, 1];
_obj addMagazineAmmoCargo ["SmokeShellGreen", 5, 1];
_obj addMagazineAmmoCargo ["Titan_AA", 5, 1];
_obj addMagazineAmmoCargo ["Titan_AP", 5, 1];
_obj addMagazineAmmoCargo ["Titan_AT", 5, 1];
_obj addMagazineAmmoCargo ["UGL_FlareGreen_F", 4, 1];
_obj addMagazineAmmoCargo ["UGL_FlareWhite_F", 4, 1];
_obj addMagazineAmmoCargo ["vn_m1897_fl_mag", 20, 1];
_obj addMagazineAmmoCargo ["vn_m1897_buck_mag", 20, 1];
_obj addMagazineAmmoCargo ["vn_izh54_mag", 20, 1];
_obj addMagazineAmmoCargo ["Chemlight_green", 4, 1];
_obj addMagazineAmmoCargo ["Chemlight_red", 4, 1];
_obj addMagazineAmmoCargo ["Chemlight_yellow", 4, 1];
_obj addMagazineAmmoCargo ["Chemlight_blue", 4, 1];
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
_obj addItemCargoGlobal ["ItemWatch", 4];
_obj addItemCargoGlobal ["ItemRadio", 4];
_obj addItemCargoGlobal ["ItemMap", 4];
_obj addItemCargoGlobal ["NVGoggles_OPFOR", 4];
_obj addItemCargoGlobal ["ItemCompass", 4];
_obj addItemCargoGlobal ["ChemicalDetector_01_watch_F", 4];
