/* -----------------------------------------------------------
                   subsample crate

Given a "reammo crate" (loaded) and a smaller crate (unloaded),
populate the smaller crate with a representative subset of the
loaded crate, without overloading it.

----------------------------------------------------------- */
params ["_large_crate", "_small_crate"];

// get the max load of the crates from the config file
private _name_large = typeOf _large_crate;
private _name_small = typeOf _small_crate;

private _max_weapons_l = getNumber (configFile >> "CfgVehicles" >> _name_large >> "transportMaxWeapons");
private _max_backpacks_l = getNumber (configFile >> "CfgVehicles" >> _name_large >> "transportMaxBackpacks");
private _max_magazines_l = getNumber (configFile >> "CfgVehicles" >> _name_large >> "transportMaxMagazines");
private _max_load_l = getNumber (configFile >> "CfgVehicles" >> _name_large >> "maximumLoad");
private _max_weapons_s = getNumber (configFile >> "CfgVehicles" >> _name_small >> "transportMaxWeapons");
private _max_backpacks_s = getNumber (configFile >> "CfgVehicles" >> _name_small >> "transportMaxBackpacks");
private _max_magazines_s = getNumber (configFile >> "CfgVehicles" >> _name_small >> "transportMaxMagazines");
private _max_load_s = getNumber (configFile >> "CfgVehicles" >> _name_small >> "maximumLoad");

private _weaponCargo = getWeaponCargo _large_crate;  // [["a", "b", ...], [3, 2, ...]]
private _backpackCargo = getBackpackCargo _large_crate;
private _magazineCargo = getMagazineCargo _large_crate;

private _cargoList = [];
for [{_i = 0 }, {_i < (count (_weaponCargo select 0))}, {_i = _i + 1}] do {
    private _type = (_weaponCargo select 0) select _i;
    for [{_j = 0 }, {_j < (count (_weaponCargo select 1))}, {_j = _j + 1}] do {
        _cargoList pushBack [_type, "w"];
    }; 
};
for [{_i = 0 }, {_i < (count (_backpackCargo select 0))}, {_i = _i + 1}] do {
    private _type = (_backpackCargo select 0) select _i;
    for [{_j = 0 }, {_j < (count (_backpackCargo select 1))}, {_j = _j + 1}] do {
        _cargoList pushBack [_type, "b"];
    }; 
};
for [{_i = 0 }, {_i < (count (_magazineCargo select 0))}, {_i = _i + 1}] do {
    private _type = (_magazineCargo select 0) select _i;
    for [{_j = 0 }, {_j < (count (_magazineCargo select 1))}, {_j = _j + 1}] do {
        _cargoList pushBack [_type, "m"];
    }; 
};

private _max_load_mass = 0.9 * _max_load_s;
private _done = false;
while { ! _done } do {
    _done = true;
    private _type_c = selectRandom _cargoList;
    private _type = _type_c select 0;
    private _c = _type_c select 1;
    switch (_c) do {
        case "w": {
           _small_crate addWeaponCargoGlobal [_type, 1];    
        };
        case "b": {
           _small_crate addBackpackCargoGlobal [_type, 1];    
        };
        case "m": {
           _small_crate addMagazineCargoGlobal [_type, 1];    
        };
    };
    if ((loadAbs _small_crate) >= _max_load_mass) then { _done = true; };
};
systemChat ("load: <" + (str (loadAbs _small_crate)) + "> of <" + (str _max_load_s) + "> <<" + (str (load _small_crate)) + ">>");

