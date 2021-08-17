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
//if ((count (_player nearEntities 2000)) > 250) exitWith { false };

// randomly select which encounter to spawn, then call its setup script
private _options_with_weights = types_hash get "background_options_with_weights"; 

private _options = [];
private _odx = 0;
// build our list of options with 1 entry per "weight" above
for [{_odx = 0}, {_odx < (count _options_with_weights)}, {_odx = _odx + 1}] do {
    private _x = _options_with_weights select _odx;
    private _type = _x select 0;
    private _w = _x select 1;
    private _wdx = 0;
    for [{_wdx = 0}, {_wdx < _w}, {_wdx = _wdx + 1}] do {
        _options pushBack _type;
    };
};

private _option = selectRandom _options;
[("Trying to spawn " + (str _option))] call pcb_fnc_debug;
switch (_option) do {
    case "animal_follower" : {
        private _types = [0,0,0,0,1,1,1,1,2,2,2,2,2,2,2,3,4,5,6,7,8];
        private _result = [_player, selectRandom _types ] call pcb_fnc_animal_follower;
        _did_spawn = _result select 1;
        if (_did_spawn) then {
            private _animal = _result select 0;
            private _obj_list = [ _animal];
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            private _entry = [false, objNull, _obj_list, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
        };
    };
    case "cultists": {
            private _ctypes = [ "O_Soldier_F" ];
            private _result = [_player] call pcb_fnc_get_random_position;
            private _pos = _result select 1;
            private _n = selectRandom [5,5,5,6,6,6,7,8,9,10,12];
            private _group = [_ctypes, _n, _pos, east, false] call pcb_fnc_spawn_squad;
            [_group] call pcb_fnc_spawn_cultists;
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            private _entry = [false, objNull, units _group, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
            [_group, _pos, 300] call BIS_fnc_taskPatrol;
            _did_spawn = true;
        };
    case "goblins": {
            private _n = selectRandom [1,1,1,2,2,3];
            private _result = [_player] call pcb_fnc_get_random_position;
            private _pos = _result select 1;
            private _group = [_pos, civilian, _n] call pcb_fnc_goblins;
            private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
            private _entry = [false, objNull, units _group, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 

            _did_spawn = true;
        };
    case "drone": {
            private _types = types_hash get "drone spooks";
            if ((! (isNil "_types")) && ((count _types) > 0)) then {
                private _type = selectRandom _types;
                ["   drone type <" + (str _type) + ">"] call pcb_fnc_debug;
                private _dpos = _player getPos [300 + (random 200), selectRandom [270, 315, 0, 45, 90]]; 
                private _stuff = [_dpos, 0, _type, east] call BIS_fnc_spawnVehicle;
                private _group = _stuff select 2;
                [_group] call pcb_fnc_log_group;

                private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
                private _entry = [false, objNull, _stuff select 1, false, objNull, objNull, _option];
                spawned_encounters set [_UID, _entry];
                private _mode = selectRandom ["SAD", "Patrol", "Patrol"];
                [_group, _player, _mode] call pcb_fnc_set_behaviour;

                _did_spawn = true;
            } else {
                _did_spawn = false;
            };
        };
    case "vehicle": {
            private _types = types_hash get "vehicle spooks";
            if ((! (isNil "_types")) && ((count _types) > 0)) then {
                private _type = selectRandom _types;
                ["   vehicle type <" + (str _type) + ">"] call pcb_fnc_debug;
                private _dpos = _player getPos [300 + (random 200), selectRandom [270, 315, 0, 45, 90]]; 
                private _stuff = [_dpos, 0, _type, east] call BIS_fnc_spawnVehicle;
                private _group = _stuff select 2;
                [_group] call pcb_fnc_log_group;

                private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
                private _entry = [false, objNull, _stuff select 1, false, objNull, objNull, _option];
                spawned_encounters set [_UID, _entry];

                private _mode = selectRandom ["SAD", "Patrol", "Patrol"];
                [_group, _player, _mode] call pcb_fnc_set_behaviour;

                _did_spawn = true;
            } else {
                _did_spawn = false;
            };
        };
    case "spooks": {
            private _types = types_hash get "spooks";
            private _type = [selectRandom _types];
            ["   spook type <" + (str _type) + ">"] call pcb_fnc_debug;
            _did_spawn = [_option, _player, _type, east, 2, 5, false] call pcb_fnc_enc_infantry;
        };
    case "demon": {
            private _types = types_hash get "demons";
            _did_spawn = [_option, _player, _types, east, 1, 2, false] call pcb_fnc_enc_infantry;
        };
    case "zombies": {
            private _types = types_hash get "zombies"; 
            _did_spawn = [_option, _player, _types, east, 2, 7, false] call pcb_fnc_enc_infantry;
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
            _did_spawn = [_option, _player, _types, east] call pcb_fnc_enc_infantry;
        };
    case "bandit_car": {
            private _type = selectRandom (types_hash get "civ vehicles");
            private _types = types_hash get "looters";
            _did_spawn = [_option, _player, _type, east, [_types, 2 + (ceil (random 3))]] call pcb_fnc_enc_vehicle_patrol;
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
[("Spawn success? " + (str _did_spawn))] call pcb_fnc_debug;

_did_spawn;
