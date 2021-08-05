/* --------------------------------------------------------------------------
                              get random vehicle

given a type (car, heli) and other qualifiers, return random type string
-------------------------------------------------------------------------- */

params ["_class", "_size"];
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

private _large_cars = [ 
    "C_Van_02_medevac_F",
    "C_Van_02_transport_F",
    "C_Truck_02_fuel_F",
    "C_Truck_02_box_F",
    "C_Truck_02_transport_F",
    "C_Truck_02_covered_F",
    "vn_b_wheeled_m54_01",
    "vn_b_wheeled_m54_02",
    "vn_b_wheeled_m54_01_airport",
    "B_Truck_01_transport_F",
    "B_Truck_01_covered_F",
    "O_Truck_03_transport_F",
    "I_Truck_02_box_F",
    "vn_i_wheeled_m54_repair",
    "I_G_Offroad_01_repair_F",
    "I_G_Van_02_vehicle_F",
    "O_Truck_03_repair_F",
    "O_Truck_03_medical_F",
    "B_Truck_01_flatbed_F",
    "B_Truck_01_medical_F",
    "B_Truck_01_Repair_F"
];
private _med_cars = [ 
    "C_Van_01_fuel_F",
    "C_Offroad_01_F",
    "C_Offroad_01_comms_F",
    "C_Offroad_01_covered_F",
    "C_Offroad_01_repair_F",
    "C_Van_01_box_F",
    "C_Tractor_01_F",
    "C_Van_01_transport_F"
];
private _small_cars = [ 
    "vn_c_bicycle_01",
    "C_Hatchback_01_F",
    "C_Hatchback_01_sport_F",
    "C_Offroad_02_unarmed_F",
    "C_Quadbike_01_F"
];




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

if (_class isEqualTo "car") then {
    switch {_size} do {
        case "small": {
            _result = selectRandom _small_cars;
        };
        case "medium": {
            _result = selectRandom _med_cars;
        };
        case "large": {
            _result = selectRandom _large_large;
        };
        default {
            _result = selectRandom (_small_cars + _med_cars + _large_cars);
        };
    };
};


_result;
