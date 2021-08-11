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
private _options_with_weights = [
    ["animal_follower", 1],
    ["police_foot", 2],
    ["police_vehicle", 2],
    ["bandit_foot", 2],
    ["bandit_car", 3],
    ["spooks", 3],
    ["civ_air", 1],
    ["civ_vehicle", 10],
    ["civ_foot", 10]
];

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
            _entry = [false, objNull, _obj_list, false, objNull, objNull, _option];
            spawned_encounters set [_UID, _entry];
            publicVariable "spawned_encounters"; 
        };
    };
    case "spooks": {
            private _types = types_hash get "spooks";
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
[("Spawn success? " + (str _did_spawn))] call pcb_fnc_debug;

_did_spawn;
