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
    private _vtemp = [_player] call pcb_fnc_player_in_vehicle;
    if (_vtemp select 0) then { _vobj = (_vtemp select 1) select 0; };
    private _whitelist = [ [_vobj getRelPos [ENC_DIST, 0], ENC_RADIUS] ];
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

    if (! ([_pos] call pcb_fnc_is_valid_position)) exitWith { diag_log "fn_enc_infantry - not valid position"; false };

    // are there any players in the area?
    if ([ [_pos, ENC_MIN_PLAYER_DIST_CREATE] ] call pcb_fnc_players_in_area) exitWith { diag_log "fn_enc_infantry - players in range"; false };
};
//hint ("Spawning " + _label + " at " + (str _pos) + ">");

private _action = objNull;
private _entry = objNull;
private _building = objNull;

if ((random 1) > 0.15) then {
    _action = "patrol";
} else {
    _action = "garrison";
    // use the previously found _pos to find the nearest building
    _building = nearestBuilding _pos;

    _pos = getPosATL _building;
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

    // create a group
    private _group = createGroup _side;
    for [{_i = 0 }, {_i < _group_size}, {_i = _i + 1}] do {
        private _type = objNull;
        if (_exact) then {
            _type = _types select _i;
        } else {
            _type = selectRandom _types;
        };
        private _veh = _group createUnit [_type, _pos, [], 5, 'NONE'];
        [_veh] joinSilent _group;
        _veh triggerDynamicSimulation false; // won't wake up enemy units
        _obj_list pushBack _veh;
        sleep .1;
    };

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;

    // create a trigger on the first object in the list (so it will track patrols, for example)
    // we use it to detect if there are players "near"
    _trg = createTrigger ["EmptyDetector", _obj_list select 0, true];
    _trg setTriggerArea [ENC_MIN_PLAYER_DIST_DELETE, ENC_MIN_PLAYER_DIST_DELETE, 0, false]; 
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["this", "", ""];
    _obj_list pushBack _trg;

    if (pcb_DEBUG) then {
        private _m = createMarker [_UID, _obj_list select 0];
        _m setMarkerShapeLocal "ELLIPSE";
        _m setMarkerColorLocal "ColorRED";
        _m setMarkerSizeLocal [50, 50];
        _m setMarkerAlpha 0.9;
    };

    if (_action == "patrol") then {
        // create a patrol
        private _waypoint_sep = 100 + (ceil (random 1000));
        [_group, _pos, _waypoint_sep] call BIS_fnc_taskPatrol; 
    } else {
        // create a garrison waypoint
        [_group, getPosATL _building] call BIS_fnc_taskDefend;
    };

    _entry = [false, _trg, _obj_list, false, objNull, objNull, _label];

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
