/* ------------------------------------------------------
                   vehicle_loadout

For setting up the loadout on SCP vehicles

_obj -- the item to set the loadout on
------------------------------------------------------- */

params ["_obj"];

clearItemCargoGlobal _obj;
clearWeaponCargo _obj;
clearMagazineCargo _obj;


// weapon
_obj addItemCargoGlobal ["arifle_MXC_F", 2];
_obj addItemCargoGlobal ["hgun_P07_F", 2];
_obj addItemCargoGlobal ["Binocular", 1];
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 50, 100];
_obj addMagazineAmmoCargo ["16Rnd_9x21_Mag", 10, 16];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 5, 1];
_obj addMagazineAmmoCargo ["SatchelCharge_Remote_Mag", 1, 1];
_obj addMagazineAmmoCargo ["Chemlight_green", 4, 1];
// item
_obj addItemCargoGlobal ["acc_flashlight", 2];
_obj addItemCargoGlobal ["FirstAidKit", 10];
_obj addItemCargoGlobal ["Medikit", 1];
_obj addItemCargoGlobal ["ToolKit", 1];
_obj addItemCargoGlobal ["DSA_Detector", 1];
_obj addItemCargoGlobal ["B_UavTerminal", 1];
_obj addItemCargoGlobal ["ItemCompass", 1];

// backpack
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 2];

