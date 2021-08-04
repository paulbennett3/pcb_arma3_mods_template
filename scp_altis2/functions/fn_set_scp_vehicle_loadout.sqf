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
_obj addItemCargoGlobal ["Binocular", 1];
// mag
_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 10, 100];
_obj addMagazineAmmoCargo ["30Rnd_9x21_Green_Mag", 6, 30];
_obj addMagazineAmmoCargo ["DemoCharge_Remote_Mag", 4, 1];
// item
_obj addItemCargoGlobal ["FirstAidKit", 5];
_obj addItemCargoGlobal ["Medikit", 1];
_obj addItemCargoGlobal ["ToolKit", 1];

// backpack
_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
_obj addBackpackCargoGlobal ["B_Kitbag_rgr", 2];

