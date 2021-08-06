/* --------------------------------------------------------------------------
                              get random vehicle

given a type (car, heli) and other qualifiers, return random type string
-------------------------------------------------------------------------- */

params ["_class", "_size", ["_civ", true]];
private _result = objNull;

// -----------------------------------------------------
private _large_helis = [ 
    "B_Heli_Transport_03_F",
    "I_Heli_Transport_02_F",
    "O_Heli_Transport_04_F",
    "O_Heli_Attack_02_dynamicLoadout_F"
];

private _med_helis = [
    "vn_b_air_ah1g_02",
    "vn_b_air_ah1g_04",
    "vn_b_air_ch34_04_03",
    "vn_i_air_ch34_02_02",
    "vn_b_air_uh1c_07_07",
    "vn_b_air_uh1c_02_07",
    "B_Heli_Attack_01_dynamicLoadout_F",
    "B_CTRG_Heli_Transport_01_tropic_F",
    "B_CTRG_Heli_Transport_01_sand_F",
    "B_Heli_Transport_01_F",
    "I_Heli_light_03_dynamicLoadout_F",
    "O_Heli_Light_02_dynamicLoadout_F"
];

private _small_helis = [
    "vn_b_air_oh6a_01",
    "vn_b_air_oh6a_03",
    "B_Heli_Light_01_F",
    "C_Heli_Light_01_civil_F",
    "B_Heli_Light_dynamicLoadout_01_F"
];
// -----------------------------------------------------



// -----------------------------------------------------
if (_class isEqualTo "heli") then {
    switch {_size} do {
        case "small": {
            _result = selectRandom _small_helis;
        };
        case "medium": {
            _result = selectRandom _med_helis;
        };
        case "large": {
            _result = selectRandom _large_helis;
        };
        default {
            _result = selectRandom (_small_helis + _med_helis + _large_helis);
        };
    };
};

private _chance_mil = 10;

if (_class isEqualTo "car") then {
    switch {_size} do {
        case "small": {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (types_hash get "car small mil");
            } else {
                _result = selectRandom (types_hash get "car small civ");
            };
        };
        case "medium": {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (types_hash get "car medium mil");
            } else {
                _result = selectRandom (types_hash get "car medium civ");
            };
        };
        case "large": {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (types_hash get "car large mil");
            } else {
                _result = selectRandom (types_hash get "car large civ");
            };
        };
        default {
            _result = selectRandom (
               (types_hash get "car small mil") +
               (types_hash get "car small civ") +
               (types_hash get "car medium mil") +
               (types_hash get "car medium civ") +
               (types_hash get "car large mil") +
               (types_hash get "car large civ") 
            );
        };
    };
};


_result;
