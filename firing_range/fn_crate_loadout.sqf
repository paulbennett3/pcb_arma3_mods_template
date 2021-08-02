/* ------------------------------------------------------
                   crate_loadout

For setting up the loadout on "crates" 

_crate -- the item to set the loadout on
_loadout_name - string specifying loadout type(s)
------------------------------------------------------- */

params ["_obj"];

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

// weapon
_obj addItemCargoGlobal ["arifle_MXC_F", 1];
_obj addItemCargoGlobal ["arifle_MXM_F", 1];
_obj addItemCargoGlobal ["arifle_MX_GL_F", 1];
_obj addItemCargoGlobal ["launch_Titan_short_F", 1];
_obj addItemCargoGlobal ["vn_izh54_p", 1];
_obj addItemCargoGlobal ["Binocular", 1];
_obj addItemCargoGlobal ["Laserdesignator", 1];
_obj addItemCargoGlobal ["Rangefinder", 1];
_obj addItemCargoGlobal ["vn_m79_p", 1];
_obj addItemCargoGlobal ["vn_m72", 8];
_obj addItemCargoGlobal ["vn_m79", 1];

_obj addItemCargoGlobal ["vn_m72_mag", 8];
_obj addItemCargoGlobal ["vn_40mm_m576_buck_mag", 40];
_obj addItemCargoGlobal ["vn_40mm_m381_he_mag", 40];


sleep .1;
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 40, 100];
_obj addMagazineAmmoCargo ["30Rnd_65x39_caseless_mag", 40, 30];
_obj addMagazineAmmoCargo ["HandGrenade", 8, 1];
_obj addMagazineAmmoCargo ["MiniGrenade", 8, 1];

_obj addMagazineAmmoCargo ["1Rnd_HE_Grenade_shell", 80, 1];
_obj addMagazineAmmoCargo ["1Rnd_SmokeGreen_Grenade_shell", 5, 1];
_obj addMagazineAmmoCargo ["APERSBoundingMine_Range_Mag", 2, 1];
_obj addMagazineAmmoCargo ["APERSMine_Range_Mag", 2, 1];
_obj addMagazineAmmoCargo ["APERSTripMine_Wire_Mag", 2, 1];
_obj addMagazineAmmoCargo ["ATMine_Range_Mag", 2, 1];
_obj addMagazineAmmoCargo ["ClaymoreDirectionalMine_Remote_Mag", 4, 1];
_obj addMagazineAmmoCargo ["Laserbatteries", 2, 1];
_obj addMagazineAmmoCargo ["Titan_AA", 2, 1];
_obj addMagazineAmmoCargo ["Titan_AP", 2, 1];
_obj addMagazineAmmoCargo ["Titan_AT", 2, 1];
_obj addMagazineAmmoCargo ["UGL_FlareGreen_F", 4, 1];
_obj addMagazineAmmoCargo ["vn_izh54_mag", 10, 1];
// item
_obj addItemCargoGlobal ["acc_flashlight", 1];
_obj addItemCargoGlobal ["acc_pointer_IR", 1];
_obj addItemCargoGlobal ["optic_Aco", 1];
_obj addItemCargoGlobal ["optic_DMS", 1];
_obj addItemCargoGlobal ["optic_Hamr", 1];
_obj addItemCargoGlobal ["optic_Holosight", 1];
_obj addItemCargoGlobal ["optic_LRPS", 1];
_obj addItemCargoGlobal ["optic_MRD", 1];
_obj addItemCargoGlobal ["optic_NVS", 1];
_obj addItemCargoGlobal ["optic_SOS", 1];
_obj addItemCargoGlobal ["optic_tws", 1];
_obj addItemCargoGlobal ["optic_tws_mg", 1];

// backpack
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 1];
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];

