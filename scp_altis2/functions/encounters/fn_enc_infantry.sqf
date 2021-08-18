/* ******************************************************************
                   fn_enc_infantry

Spawn some infantry
   patrol (can be anywhere)
   garrison (in building)
   ???
****************************************************************** */

params ["_label", "_player", "_types", "_side", ["_min_n", 1], ["_max_n", 6], ["_exact", false], ["_pos", [0,0]]];
private _did_spawn = false;

private _vobj = _player;

// did our caller not specify a position? If they didn't, pick one
if (! ([_pos] call pcb_fnc_is_valid_position)) then {
    private _dir = [_player] call pcb_fnc_get_player_direction;
    private _whitelist = [ [_player getPos [ENC_DIST, _dir], ENC_RADIUS] ];
    private _blacklist = [ "water" ];
    _pos = [0, 0];
    private _tries = 10;

    // did we get a valid position?
    while { _tries > 0 } do {
        _pos = [_whitelist, _blacklist] call BIS_fnc_randomPos;
        if (! ([_pos] call pcb_fnc_is_valid_position)) then {
            _tries = _tries - 1;
        } else {
            _tries = 0;
        };
    };

    if (! ([_pos] call pcb_fnc_is_valid_position)) exitWith { 
        ["fn_enc_infantry - not valid position"] call pcb_fnc_debug; 
        false 
    };

    // are there any players in the area?
    if ([ [_pos, ENC_MIN_PLAYER_DIST_CREATE] ] call pcb_fnc_players_in_area) exitWith { 
        ["fn_enc_infantry - players in range"] call pcb_fnc_debug; 
        false 
    };
};

private _action = objNull;
private _entry = objNull;
private _building = objNull;

if ((random 1) > 0.15) then {
    _action = "patrol";
} else {
    _action = "defend";
};


if (true) then {
    // get a UID to identify the encounter
    private _UID = "S" + str ([] call pcb_fnc_get_next_UID);

    // make a list of all the stuff we spawn
    private _obj_list = [];

    private _group_size = objNull;
    if (_exact) then { 
        _group_size = count _types; 
    } else {
        _group_size = _min_n + (ceil (random (_max_n - _min_n)));
    };

    private _ctypes = [];
    for [{}, {_group_size > -1}, {_group_size = _group_size - 1}] do {
        _ctypes pushBack (selectRandom _types);
    };
    // create a group
    private _group = [_ctypes, _pos, _side, false] call pcb_fnc_spawn_squad;
    [_group, _pos, _action] call pcb_fnc_set_behaviour;

    _entry = [false, objNull, _obj_list, false, objNull, objNull, _label];

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
