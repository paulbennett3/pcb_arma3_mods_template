/* ------------------------------------------------------
                   loot_crate

Create a "loot" crate (ie, what Looter faction might have)

Works if you put valid items in it ...

_pos -- where to put it
------------------------------------------------------- */

params ["_pos", ["_obj", objNull]];

// ----------------------
// first, create a crate
// ----------------------
private _types = [
    "Land_MetalCase_01_large_F",
    "Land_MetalCase_01_medium_F",
    "Land_MetalCase_01_small_F",
    "Land_PlasticCase_01_large_black_F",
    "Land_PlasticCase_01_large_black_CBRN_F",
    "Land_PlasticCase_01_large_CBRN_F",
    "Land_vn_plasticcase_01_large_gray_f",
    "Land_PlasticCase_01_large_idap_F",
    "Land_PlasticCase_01_medium_olive_CBRN_F",
    "Land_PlasticCase_01_small_CBRN_F"
];

private _type = objNull;
if (isNull _obj) then {
    _type = selectRandom _types;
    _obj = _type createVehicle _pos;
};

// ----------------------
// clear it out
// ----------------------
clearItemCargoGlobal _obj;
clearWeaponCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearBackpackCargoGlobal _obj;
sleep .1;

private _loots = [
"DSA_Detector",
"dmpAntibiotics",
"dmpAntidote",
"RyanZombiesAntiVirusCure_Item",
"RyanZombiesAntiVirusTemporary_Item",
"dmpBandage",
"dmpBeans",
"dmpCampingLamp",
"dmpCash",
"dmpCereal",
"dmpEnergyDrink",
"FirstAidKit",
"dmpFlashDrive",
"dmpFranta",
"dmpHeatpack",
"dmpMatches",
"dmpPainkillers",
"dmpSmartphone",
"dmpTacticalBacon",
"dmpWallet",
"vn_b_item_wiretap"
];

// items
private _str = "";
private _n = 3 + ceil (random 10);
for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
    private _t = selectRandom _loots;
    _obj addItemCargoGlobal [_t, 1];
    _str = _str + " " + _t;
};
hint _str;

// weapon
//_obj addItemCargoGlobal ["arifle_MXC_F", 4];
// mag
//_obj addMagazineAmmoCargo ["100Rnd_65x39_caseless_mag_Tracer", 20, 100];
// item

// backpack
//_obj addBackpackCargo ["B_Kitbag_rgr", 4];
//_obj addBackpackCargoGlobal ["B_UAV_06_backpack_F", 4];


