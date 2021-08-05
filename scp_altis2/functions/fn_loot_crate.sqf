/* ------------------------------------------------------
                   loot_crate

Add loot to a container
------------------------------------------------------- */
params ["_obj", "_n"];

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
"dmpStims",
"dmpSmartphone",
"dmpTacticalBacon",
"dmpWallet",
"dmpWaterPurification",
"vn_b_item_wiretap",
"Chemlight_green",
"Chemlight_blue",
"vn_molotov_grenade_mag",
"U_C_FormalSuit_01_black_F",
"U_C_Uniform_Scientist_02_F",
"U_C_Uniform_Scientist_01_F",
"G_Aviator",
"Binocular",
"H_Cap_grn",
"vn_b_squares_tinted",
"vn_mk21_binocs"
];

// items
for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
    private _t = selectRandom _loots;
    _obj addItemCargoGlobal [_t, 1];
};

// Weapon sets (weapon and some ammo)
private _weapons = [
    ["vn_izh54_shorty", ["vn_izh54_so_mag", "vn_izh54_mag"]],
    ["vn_p38s", ["vn_m10_mag"]],
    ["sgun_HunterShotgun_01_sawedoff_F", ["2Rnd_12Gauge_Pellets", "2Rnd_12Gauge_Slug"]],
    ["hgun_Pistol_heavy_02_F", ["6Rnd_45ACP_Cylinder"]],
    ["vn_mc10", ["vn_mc10_mag"]],
    ["vn_m1911", ["vn_m1911_mag"]],
    ["vn_mat49", ["vn_mat49_mag"]]
];

private _n_guns = floor (random 3);
for [{_i = 0 }, {_i < _n_guns}, {_i = _i + 1}] do {
    private _tt = selectRandom _weapons;
    _t = _tt select 0;
    _obj addItemCargoGlobal [_t, 1];

    {
        _obj addItemCargoGlobal [_x, 1 + (ceil (random 6))];
    } forEach (_tt select 1);
};
