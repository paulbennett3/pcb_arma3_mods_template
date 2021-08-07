/* ****************************************************************************
                          do director spawn
**************************************************************************** */
private _did_spawn = false;

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
    "ambulance",
    "bandit_foot",
    "bandit_foot",
    "bandit_car",
    "civ_foot",
    "civ_foot",
    "civ_foot",
    "civ_foot",
    "civ_foot",
    "civ_foot",
    "civ_foot",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "spooks",
    "police_vehicle",
    "police_vehicle",
    "police_foot",
    "police_foot",
    "civ_air",
    "civ_air"
];
//    "compound",
//    "boom_guy",
//    "zombies",
//    "spooks",
//    "demon",

private _option = selectRandom _options;
diag_log ("Spawning " + (str _option));
switch (_option) do {
    case "animal_follower" : {
        private _types = [0,0,0,0,1,1,1,1,2,2,2,2,2,2,2,3,4,5,6,7,8];
        private _result = [_player, selectRandom _types ] call pcb_fnc_animal_follower;
        _did_spawn = _result select 1;
        if (_did_spawn) then {
            private _animal = _result select 0;
            private _obj_list = [ _animal];
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            _entry = [false, objNull, _obj_list, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
        };
    };
    case "boom_animal" : {
        private _result = [_player getRelPos [300, 0], 1] call pcb_fnc_boom_animal;
        _did_spawn = _result select 0;
        if (_did_spawn) then {
            private _animal = _result select 1;
            private _obj_list = [ _animal];
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            _entry = [false, objNull, _obj_list, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
        };
    };
    case "boom_guy" : {
        private _result = [_player getRelPos [500 + (ceil (random 500)), 0]] call pcb_fnc_boom_guy;
        _did_spawn = _result select 0;
        if (_did_spawn) then {
            private _obj = _result select 1;
            private _obj_list = [ _obj];
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            _entry = [false, objNull, _obj_list, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
        };
    };
    case "compound": {
        private _types_lists = [
            types_hash get "looters",
            types_hash get "zombies"
        ];
        private _types1 = selectRandom _types_lists;
        private _types2 = selectRandom _types_lists;
        private _g1 = [ _types1, east, 3, 7];
        private _g2 = [ _types2, independent, 3, 7];

        _did_spawn = [_option, _player, _g1, _g2] call pcb_fnc_enc_compound;
    };
    case "spooks": {
            private _types = types_hash get "limited spooks";
            private _type = [selectRandom _types];
            ["   spook type <" + (str _type) + ">"] call pcb_fnc_debug;
            _did_spawn = [_option, _player, _type, independent, 2, 5, false] call pcb_fnc_enc_infantry;
        };
    case "demon": {
            private _types = types_hash get "demons";
            _did_spawn = [_option, _player, _types, independent, 1, 2, false] call pcb_fnc_enc_infantry;
        };
    case "zombies": {
            private _types = types_hash get "zombies"; 
            _did_spawn = [_option, _player, _types, independent, 2, 7, false] call pcb_fnc_enc_infantry;
        };
    case "ambulance": {
            _did_spawn = [_option, _player, (types_hash get "ambulance") select 0, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_vehicle": {
            private _type = selectRandom (types_hash get "civ vehicles");

            _did_spawn = [_option, _player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_foot": {
            private _types = types_hash get "civilians";
            _did_spawn = [_option, _player, _types, civilian] call pcb_fnc_enc_infantry;
        };
    case "bandit_foot": {
            private _types = types_hash get "looters";
            _did_spawn = [_option, _player, _types, independent] call pcb_fnc_enc_infantry;
        };
    case "bandit_car": {
            private _type = selectRandom (types_hash get "civ vehicles");
            _did_spawn = [_option, _player, _type, independent] call pcb_fnc_enc_vehicle_patrol;
        };
    case "police_foot": {
            private _types = types_hash get "police"; 
            _did_spawn = [_option, _player, _types, west] call pcb_fnc_enc_infantry;
        };
    case "police_vehicle": {
            private _type = selectRandom (types_hash get "police vehicles");
            _did_spawn = [_option, _player, _type, west] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_air": {
            private _type = selectRandom (types_hash get "civ air"); 
            _did_spawn = [_option, _player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
};
diag_log ("Spawn success? " + (str _did_spawn));

_did_spawn;
