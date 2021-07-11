/* --------------------------------------------------------------------------
                              get random helicopter

given a size (small, medium, large, any), return the type string from
a random helicopter
-------------------------------------------------------------------------- */

params ["_size"];

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

private _result = objNull;
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

_result;
