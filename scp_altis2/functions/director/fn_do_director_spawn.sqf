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
    "compound",
    "ambulance",
    "bandit_foot",
    "bandit_car",
    "bandit_car",
    "civ_foot",
    "civ_foot",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "civ_vehicle",
    "police_vehicle",
    "police_vehicle",
    "police_foot",
    "police_foot",
    "zombies",
    "spooks",
    "demon",
    "civ_air",
    "civ_air",
    "civ_air"
];

private _option = selectRandom _options;

diag_log ("Spawning " + (str _option));
hint ("Spawning " + (str _option));
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
            types_hash get "spooks",
            types_hash get "demons",
            types_hash get "looters",
            types_hash get "zombies"
        ];
        private _types1 = selectRandom _types_lists;
        private _types2 = selectRandom _types_lists;
        private _g1 = [ _types1, east, 5, 9];
        private _g2 = [ _types2, independent, 5, 9];

        _did_spawn = [_player, _g1, _g2] call pcb_fnc_enc_compound;
    };
    case "spooks": {
            private _types = types_hash get "spooks";
            private _type = [selectRandom _types];
            _did_spawn = [_player, _type, independent, 1, 3, false] call pcb_fnc_enc_infantry;
        };
    case "demon": {
            private _type = selectRandom (types_hash get "demons");
            _did_spawn = [_player, [_type], independent, 1, 3, false] call pcb_fnc_enc_infantry;
        };
    case "zombies": {
            private _types = types_hash get "zombies"; 
            _did_spawn = [_player, _types, independent, 3, 25, false] call pcb_fnc_enc_infantry;
        };
    case "ambulance": {
            _did_spawn = [_player, types_hash get "ambulance", civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_vehicle": {
            private _type = selectRandom (types_hash get "civ vehicles");

            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_foot": {
            private _types = types_hash get "civilians";
            _did_spawn = [_player, _types, civilian] call pcb_fnc_enc_infantry;
        };
    case "bandit_foot": {
            private _types = types_hash get "looters";
            _did_spawn = [_player, _types, independent] call pcb_fnc_enc_infantry;
        };
    case "bandit_car": {
            private _type = selectRandom (types_hash get "civ vehicles");
            _did_spawn = [_player, _type, independent] call pcb_fnc_enc_vehicle_patrol;
        };
    case "police_foot": {
            private _types = types_hash get "police"; 
            _did_spawn = [_player, _types, west] call pcb_fnc_enc_infantry;
        };
    case "police_vehicle": {
            private _type = selectRandom (types_hash get "police vehicles");
            _did_spawn = [_player, _type, west] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_air": {
            private _type = selectRandom (types_hash get "civ air"); 
            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
};
diag_log ("Spawn success? " + (str _did_spawn));
hint ("Spawn success? <" + (str _option) + "> " + (str _did_spawn));

_did_spawn;
