/* ********************************************************
                      populate cities

For all "cities" (including large and small, villages, ...),
place "something" with a random chance.  Could be good, 
could be bad ...
******************************************************** */
params ["_active_area"];

private _blacklist = ["water"];

// --------------------------------
// place stuff in "named" cities
// --------------------------------
private _cities = [epicenter, worldSize] call pcb_fnc_get_city_positions;
private _cities_in_active_area = _cities inAreaArray "mEPI";
private _code = {
    params ["_types", "_n", "_pos", "_side"];
    private _group = createGroup _side;
    for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
        private _type = selectRandom _types;
        private _veh = _group createUnit [_type, _pos, [], 200, 'NONE'];
        _veh triggerDynamicSimulation false; // won't wake up enemy units:wq
        [_veh] joinSilent _group;
    };

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    _group enableDynamicSimulation true;
    [_group, _pos] call BIS_fnc_taskDefend;
    sleep .1;
};

{
    // civilians
    if ((random 1) < 0.25) then {
        private _types = [
            "Max_Tak_woman1", "Max_Tak_woman2", "Max_Tak_woman3", "Max_Tak_woman4",
            "Max_Tak_woman5", "Max_Tak_woman6", "Max_Taky_woman1", "Max_Taky_woman2",
            "Max_Taky_woman3", "Max_Taky_woman4", "Max_Taky_woman5", "Max_Tak2_woman1",
            "Max_Tak2_woman2", "Max_Tak2_woman3", "Max_Tak2_woman4", "Max_Tak2_woman5",
            "Max_woman4", "Max_woman5", "Max_woman2", "Max_woman3", "Max_woman1",
            "vn_c_men_01", "vn_c_men_02", "vn_c_men_05", "vn_c_men_06",
            "vn_c_men_09", "vn_c_men_10", "vn_c_men_13", "vn_c_men_14",
            "vn_c_men_17", "vn_c_men_18", "vn_c_men_21", "vn_c_men_22",
            "vn_c_men_25", "vn_c_men_26", "vn_c_men_29", "vn_c_men_30",
            "vn_c_men_24", "vn_c_men_03", "vn_c_men_04", "C_IDAP_Man_AidWorker_01_F",
            "C_IDAP_Man_AidWorker_08_F", "C_IDAP_Man_AidWorker_05_F", "C_IDAP_Man_AidWorker_04_F",
            "C_IDAP_Man_AidWorker_03_F", "C_man_p_beggar_F_afro", "C_Man_casual_2_F_afro",
            "C_man_polo_1_F_afro", "C_man_shorts_2_F_afro", "C_Man_casual_8_F_asia", "C_man_polo_4_F_asia"
        ];
        private _n = 10 + (ceil (random 10));
        [_types, _n, _x, civilian] call _code;

    };   
    // looters
    if ((random 1) < 0.25) then {
        private _types = [
            "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
            "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F",
            "I_L_Looter_Rifle_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
            "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
            "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F"
        ];
        private _n = 3 + (ceil (random 7));
        [_types, _n, _x, independent] call _code;
    };   
    // zombies
    if ((random 1) < 0.25) then {
        private _types = [
            "RyanZombieC_man_1", "RyanZombieC_man_hunter_1_F", "RyanZombie19", "RyanZombie23",
            "RyanZombie29", "RyanZombieC_man_polo_4_F", "RyanZombieC_scientist_F", "RyanZombieB_Soldier_lite_F",
            "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_02_fmediumOpfor", "RyanZombieB_Soldier_02_f_1mediumOpfor",
            "RyanZombieB_Soldier_02_f_1_1mediumOpfor", "RyanZombieB_Soldier_03_fmediumOpfor",
            "RyanZombieB_Soldier_03_f_1mediumOpfor", "RyanZombieB_Soldier_03_f_1_1mediumOpfor",
            "RyanZombieB_Soldier_04_fmediumOpfor", "RyanZombieB_Soldier_04_f_1mediumOpfor",
            "RyanZombieB_Soldier_04_f_1_1mediumOpfor", "RyanZombieB_Soldier_lite_FmediumOpfor",
            "RyanZombieB_Soldier_lite_F_1mediumOpfor", "RyanZombieB_Soldier_02_fmediumOpfor",
            "RyanZombieB_Soldier_02_f_1mediumOpfor", "RyanZombieB_Soldier_02_f_1_1mediumOpfor"
        ];
        private _n = 10 + (ceil (random 20));
        [_types, _n, _x, east] call _code;
    };   
        
    if (pcb_DEBUG) then {
        private _mn = "MC" + (str _x);
        private _m = createMarker [_mn, _x];
        _m setMarkerType "KIA";
    };
} forEach _cities_in_active_area;

// --------------------------------
// place cargo crates (and possibly spooks etc) in military bases
// --------------------------------
private _types = ["Cargo_Tower_base_F", "Land_i_Barracks_V1_F",
                  "Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F",
                  "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F",
                  "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F",
                  "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F",
                  "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F"
];

private _military_objects = nearestObjects [epicenter, _types, worldSize];
private _military_objects_in_area = _military_objects inAreaArray "mEPI";
{
    private _crates = [
        "O_CargoNet_01_ammo_F",
        "C_IDAP_CargoNet_01_supplies_F",
        "I_E_CargoNet_01_ammo_F",
        "B_CargoNet_01_ammo_F"    
    ];
    private _building = nearestBuilding _x;
    private _positions = [_building] call BIS_fnc_buildingPositions;
    if ((count _positions) > 1) then {
        private _pos = selectRandom _positions;
        if (((_pos select 0) > 0) or ((_pos select 1) > 0)) then {
            private _object_type = selectRandom _crates;
            //_target = _object_type createVehicle _pos;
            _target = createVehicle [_object_type, _pos, [], 0, "NONE"];
            sleep 0.1;
        };
    };

    if (pcb_DEBUG) then {
        private _mn = "MC" + (str _x);
        private _m = createMarker [_mn, _x];
        _m setMarkerType "KIA";
        _m setMarkerColor "ColorRED";
    };
    private _roll = random 1; 
    if (_roll < 0.5) then {
        private _ztypes = [
            "RyanZombieC_scientist_F", "RyanZombieB_Soldier_lite_F",
            "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_02_fmediumOpfor", "RyanZombieB_Soldier_02_f_1mediumOpfor",
            "RyanZombieB_Soldier_02_f_1_1mediumOpfor", "RyanZombieB_Soldier_03_fmediumOpfor",
            "RyanZombieB_Soldier_03_f_1mediumOpfor", "RyanZombieB_Soldier_03_f_1_1mediumOpfor",
            "RyanZombieB_Soldier_04_fmediumOpfor", "RyanZombieB_Soldier_04_f_1mediumOpfor",
            "RyanZombieB_Soldier_04_f_1_1mediumOpfor", "RyanZombieB_Soldier_lite_FmediumOpfor",
            "RyanZombieB_Soldier_lite_F_1mediumOpfor", "RyanZombieB_Soldier_02_fmediumOpfor",
            "RyanZombieB_Soldier_02_f_1mediumOpfor", "RyanZombieB_Soldier_02_f_1_1mediumOpfor"
        ];
        private _n = 5 + (ceil (random 5));
        [_ztypes, _n, _x, east] call _code;
    };
    if ((_roll >= 0.5) and (_roll < 0.7)) then {
        private _types = [
            "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
            "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F",
            "I_L_Looter_Rifle_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
            "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
            "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F"
        ];
        private _n = 3 + (ceil (random 3));
        [_types, _n, _x, east] call _code;
    };
    
} forEach _military_objects_in_area;

