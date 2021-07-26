/* ****************************************************************************
                          do director spawn
**************************************************************************** */
private _did_spawn = false;

//Max_woman_soldier4
//Max_woman_soldier3
//Max_woman_soldier2
civ_list = [
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
publicVariable "civ_list";

// pick the player to spawn on
private _player = player;
if ((count playableUnits) > 0) then {
    _player = selectRandom playableUnits;
};

// limit the number of units in the area
if ((count (_player nearEntities 2000)) > 150) exitWith { false };

// randomly select which encounter to spawn, then call its setup script
private _options = [
    "animal_follower",
    "compound",
    "ambulance",
    "bandit_foot",
    "bandit_car",
    "bandit_car",
    "civ_foot",
    "civ_foot",
    "civ_foot_armed",
    "civ_foot_armed",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "police_vehicle",
    "police_vehicle",
    "police_foot",
    "police_foot",
    "zombies",
    "wendigo",
    "spooks",
    "demon",
    "civ_air",
    "civ_air",
    "civ_air"
];
private _option = selectRandom _options;
diag_log ("Spawning " + (str _option));
switch (_option) do {
    case "animal_follower" : {
        private _types = [0,0,0,0,1,1,1,1,2,2,2,2,2,2,2,3,4,5,6,7,8];
        private _result = [_player, selectRandom _types ] call pcb_fnc_animal_follower;
        _did_spawn = _result select 1;
        if (_did_spawn) then {
            private _animal = _result select 0;
            private _trg = createTrigger ["EmptyDetector", _animal, true];
            _trg setTriggerArea [ENC_MIN_PLAYER_DIST_DELETE, ENC_MIN_PLAYER_DIST_DELETE, 0, false];
            _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
            _trg setTriggerStatements ["this", "", ""];
            private _obj_list = [ _animal, _trg];
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            _entry = [false, _trg, _obj_list, false, objNull, objNull];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
        }
    };
    case "compound": {
        private _types_lists = [
            ["DSA_Wendigo"],
            ["DSA_Mindflayer"],
            ["DSA_Hatman"],
            ["DSA_Vampire"],
            [ 
                "RyanZombieboss1", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12",
                "RyanZombieboss13", "RyanZombieboss15", "RyanZombieboss30", "RyanZombieboss16",
                "RyanZombieboss28"
            ],
            [
                "I_L_Criminal_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_Pistol_F", 
                "I_L_Looter_SG_F", "I_L_Hunter_F"
            ],
            [
                "RyanZombieC_man_1", "RyanZombieC_man_hunter_1_F", "RyanZombie19", "RyanZombie23",
                "RyanZombie29", "RyanZombieC_man_polo_4_F", "RyanZombieC_scientist_F", "RyanZombieB_Soldier_lite_F",
                "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_02_fmediumOpfor", "RyanZombieB_Soldier_02_f_1mediumOpfor",
                "RyanZombieB_Soldier_02_f_1_1mediumOpfor", "RyanZombieB_Soldier_03_fmediumOpfor",
                "RyanZombieB_Soldier_03_f_1mediumOpfor", "RyanZombieB_Soldier_03_f_1_1mediumOpfor",
                "RyanZombieB_Soldier_04_fmediumOpfor", "RyanZombieB_Soldier_04_f_1mediumOpfor",
                "RyanZombieB_Soldier_04_f_1_1mediumOpfor", "RyanZombieB_Soldier_lite_FmediumOpfor",
                "RyanZombieB_Soldier_lite_F_1mediumOpfor", "RyanZombieB_Soldier_02_fmediumOpfor",
                "RyanZombieB_Soldier_02_f_1mediumOpfor", "RyanZombieB_Soldier_02_f_1_1mediumOpfor"
            ],
            [
                "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
                "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F",
                "I_L_Looter_Rifle_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
                "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
                "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F"
            ],
            [ "B_GEN_Commander_F", "B_GEN_Soldier_F"]
        ];
        private _types1 = selectRandom _types_lists;
        private _types2 = selectRandom _types_lists;
        private _g1 = [ _types1, east, 5, 9];
        private _g2 = [ _types2, independent, 5, 9];

        _did_spawn = [_player, _g1, _g2] call pcb_fnc_enc_compound;
    };
    case "spooks": {
            private _types = [
                "DSA_411",
                "DSA_Abomination",
                "DSA_Crazy",
                "DSA_Crazy",
                "DSA_Crazy",
                "DSA_Crazy",
                "DSA_Hatman",
                "DSA_Mindflayer",
                "DSA_Rake",
                "DSA_Shadowman",
                "DSA_Snatcher",
                "DSA_Vampire",
                "DSA_Wendigo",
                "DSA_Wendigo",
                "DSA_Wendigo",
                "DSA_Wendigo",
                "DSA_Wendigo"
            ];
            private _type = [selectRandom _types];
            _did_spawn = [_player, _type, independent, 1, 3, false] call pcb_fnc_enc_infantry;
        };
    case "wendigo": {
            private _type = ["DSA_Wendigo"];
            _did_spawn = [_player, _type, independent, 2, 5, false] call pcb_fnc_enc_infantry;
        };
    case "demon": {
            private _type = selectRandom [
                "RyanZombieboss1",
                "RyanZombieboss10",
                "RyanZombieboss11",
                "RyanZombieboss12",
                "RyanZombieboss13",
                "RyanZombieboss15",
                "RyanZombieboss30",
                "RyanZombieboss16",
                "RyanZombieboss28"
            ];
            _did_spawn = [_player, [_type], independent, 1, 2, false] call pcb_fnc_enc_infantry;
        };
    case "zombies": {
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
            _did_spawn = [_player, _types, independent, 3, 25, false] call pcb_fnc_enc_infantry;
        };
    case "ambulance": {
            _did_spawn = [_player, "C_Van_02_medevac_F", civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_vehicle": {
            private _type = selectRandom [
                "C_Hatchback_01_F",
                "C_Offroad_02_unarmed_F",
                "C_Offroad_01_F",
                "C_Offroad_01_comms_F",
                "C_Offroad_01_covered_F",
                "C_Offroad_01_repair_F",
                "C_Quadbike_01_F",
                "C_SUV_01_F",
                "C_Tractor_01_F",
                "C_Van_01_transport_F",
                "C_Van_01_box_F",
                "C_Van_02_vehicle_F",
                "C_Van_02_service_F",
                "C_Van_02_transport_F",
                "C_Truck_02_fuel_F",
                "C_Truck_02_box_F",
                "C_Truck_02_transport_F",
                "C_Truck_02_covered_F"
            ];

            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_foot": {
            private _types = civ_list;
            _did_spawn = [_player, _types, civilian] call pcb_fnc_enc_infantry;
        };
    case "civ_foot_armed": {
            private _types = [
                "I_L_Criminal_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Hunter_F"
            ];
            _did_spawn = [_player, _types, civilian] call pcb_fnc_enc_infantry;
        };
    case "bandit_foot": {
            private _types = [
                "I_L_Looter_Pistol_F",
                "I_L_Looter_SG_F",
                "I_L_Looter_Rifle_F",
                "I_L_Looter_SMG_F",
                "I_L_Criminal_SG_F",
                "I_L_Criminal_SMG_F",
                "I_L_Looter_Pistol_F",
                "I_L_Looter_SG_F",
                "I_L_Looter_Rifle_F",
                "I_C_Soldier_Bandit_4_F",
                "I_C_Soldier_Bandit_3_F",
                "I_C_Soldier_Bandit_7_F",
                "I_C_Soldier_Bandit_5_F",
                "I_C_Soldier_Bandit_6_F",
                "I_C_Soldier_Bandit_2_F",
                "I_C_Soldier_Bandit_8_F",
                "I_C_Soldier_Bandit_1_F",
                "I_L_Looter_Pistol_F",
                "I_L_Looter_SG_F",
                "I_L_Looter_Rifle_F"
            ]; 
            _did_spawn = [_player, _types, independent] call pcb_fnc_enc_infantry;
        };
    case "bandit_car": {
            private _type = selectRandom [
                "C_Truck_02_transport_F",
                "C_Quadbike_01_F",
                "C_Offroad_01_F",
                "C_Offroad_02_unarmed_F"
            ];
            _did_spawn = [_player, _type, independent] call pcb_fnc_enc_vehicle_patrol;
        };
    case "police_foot": {
            private _types = [
               "B_GEN_Commander_F",
               "B_GEN_Soldier_F",
               "B_GEN_Soldier_F",
               "B_GEN_Soldier_F",
               "B_GEN_Soldier_F",
               "B_GEN_Soldier_F",
               "B_GEN_Soldier_F",
               "B_GEN_Soldier_F"
            ]; 
            _did_spawn = [_player, _types, west] call pcb_fnc_enc_infantry;
        };
    case "police_vehicle": {
            private _type = selectRandom [
                "B_GEN_Offroad_01_gen_F",
                "B_GEN_Van_02_vehicle_F",
                "B_GEN_Van_02_transport_F",
                "B_GEN_Offroad_01_comms_F"
            ];
            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_air": {
            private _type = selectRandom [
                "C_Plane_Civil_01_F",
                "C_Heli_Light_01_civil_F",
                "C_Heli_Light_01_civil_F",
                "C_Heli_Light_01_civil_F",
                "C_Heli_Light_01_civil_F"
            ];
            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
};
diag_log ("Spawn success? " + (str _did_spawn));

_did_spawn;
