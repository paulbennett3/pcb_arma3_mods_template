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
_obj addItemCargoGlobal ["hgun_Rook40_F", 2];
_obj addItemCargoGlobal ["Laserdesignator", 1];
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 20, 100];
_obj addMagazineAmmoCargo ["30Rnd_65x39_caseless_mag_Tracer", 20, 30];
_obj addMagazineAmmoCargo ["30Rnd_9x21_Green_Mag", 10, 30];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 4, 1];
// item
_obj addItemCargoGlobal ["FirstAidKit", 5];
_obj addItemCargoGlobal ["Medikit", 1];
_obj addItemCargoGlobal ["ToolKit", 1];
_obj addItemCargoGlobal ["DSA_Detector", 1];
_obj addItemCargoGlobal ["B_UavTerminal", 1];
_obj addItemCargoGlobal ["MineDetector", 1];

// backpack
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
_obj addBackpackCargoGlobal ["B_UGV_02_Demining_backpack_F", 1];
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 2];

