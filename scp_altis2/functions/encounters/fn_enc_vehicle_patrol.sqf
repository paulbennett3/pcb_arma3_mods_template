/* ******************************************************************
                   fn_enc_vehicle_patrol

Spawn a single vehicle (with crew) to patrol
   patrol (can be anywhere on road)
****************************************************************** */
params ["_label", "_player", "_type", "_side", ["_types_n", []]];
private _did_spawn = false;

private _dir = [_player] call pcb_fnc_get_player_direction;
private _whitelist = [ [_player getPos [ENC_DIST, _dir], ENC_RADIUS] ];
private _blacklist = [ "water" ];
private _code = { ((count (_this nearRoads 5)) > 0) };
private _pos = [0, 0];

// did we get a valid position?
private _tries = 50;
while { _tries > 0 } do {
    _pos = [_whitelist, _blacklist, _code] call BIS_fnc_randomPos;
    if (!([_pos] call pcb_fnc_is_valid_position)) then {
        _tries = _tries - 1;
    } else {
        _tries = 0;
    };
};

if (!([_pos] call pcb_fnc_is_valid_position)) exitWith { 
    ["fn_enc_vehicle_patrol - invalid position"] call pcb_fnc_debug; 
    false 
};

// are there any players in the area?
if ([ [_pos, ENC_MIN_PLAYER_DIST_CREATE] ] call pcb_fnc_players_in_area) exitWith { 
    ["fn_enc_vehicle_patrol - players to close"] call pcb_fnc_debug; 
    false 
};

private _entry = objNull;

if (true) then {
    // get a UID to identify the encounter
    private _UID = "SA" + str ([] call pcb_fnc_get_next_UID);

    // make a list of all the stuff we spawn
    private _obj_list = [];
    private _group = objNull;
    private _veh = objNull;

    // did the player provide a list of types to spawn?
    if ((count _types_n) < 1) then {
        // create a group
        _group = createGroup _side;
        private _res = [
            _pos,
            random 360,
            _type,  
            _group 
        ] call BIS_fnc_spawnVehicle;
        // Note of result -> _res = [created vehicle, [crew]], group]
        _veh = _res select 0;
        _obj_list pushBack _veh;
        [_res select 0, ceil (random 10)] call pcb_fnc_loot_crate;
        [_res select 0] joinSilent _group;
        {
            _obj_list pushBack _x;
            _x triggerDynamicSimulation false;
        } forEach (_res select 1);
        [(_res select 1)] joinSilent _group;
        [_group] call pcb_fnc_log_group;
    } else {
        private _types = _types_n select 0;
        private _n = _types_n select 1;
        _group = [_types, _n, _pos, _side, false] call pcb_fnc_spawn_squad;
        _group selectLeader ((units _group) select 0);
        _obj_list = _obj_list + (units _group);
        _veh = createVehicle [_type, _pos, [], 5, "NONE"];
        _obj_list pushBackUnique _veh;
        [_veh, ceil (random 10)] call pcb_fnc_loot_crate;
        _group addVehicle _veh;
    };

    private _behaviour = "Patrol";
    if ((_side == east) || (_side == independent)) then {
        _behaviour = "DRIVE_AND_DESTROY";
    };
    [_group, _pos, _behaviour, _veh, _player] call pcb_fnc_set_behaviour;

    sleep .1;

    _entry = [false, objNull, _obj_list, false, objNull, objNull, _label];

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
