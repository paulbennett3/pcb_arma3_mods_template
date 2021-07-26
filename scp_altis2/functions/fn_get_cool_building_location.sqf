/* *********************************************************
              get cool building location

Find a "cool" building within _radius of _target_obj
returns object found
********************************************************* */
params ["_target_obj", ["_radius", worldSize]];

private _types = ["Cargo_Tower_base_F", "Land_Offices_01_V1_F", "Land_Hospital_Main_F", 
                  "Land_LightHouse_F", "Land_Castle_01_tower_F", "Land_d_Windmill01_F", "Land_i_Barracks_V1_F",
                  "Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F",
                  "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F",
                  "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F",
                  "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F",
                  "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F"
];
private _tries = 10;
private _pos = [0,0,0];
private _obj = objNull;

while {_tries > 0} do {
    _tries = _tries - 1;
    private _objects = nearestObjects [_target_obj, _types, _radius];
    if ((count _objects) < 1) then {
        _radius = _radius + 1000;
    } else {
        _obj = selectRandom _objects;
        _tries = 0;
    };
};

_obj
