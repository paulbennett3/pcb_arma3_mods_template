/* ******************************************************************
                   fn_enc_bandits

Spawn some bandits
   patrol (can be anywhere)
   garrison (in building)
   ???
****************************************************************** */

params ["_player"];
private _did_spawn = false;

private _whitelist = [ [_player getRelPos [1000, 0], 250] ];
private _blacklist = [ "water" ];
private _pos = [_whitelist, _blacklist] call BIS_fnc_randomPos;

// did we get a valid position?
if (((_pos select 0) == 0) and ((_pos select 1) == 0)) exitWith { false };

// are there any players in the area?
if ([_pos, 500] call pcb_fnc_players_in_area) exitWith { false };

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

    // spawn some stuff
    private _types = [
        "I_L_Looter_Pistol_F",
        "I_L_Looter_Pistol_F",
        "I_L_Looter_Pistol_F",
        "I_L_Looter_Pistol_F",
        "I_L_Looter_SG_F",
        "I_L_Looter_SG_F",
        "I_L_Looter_SG_F",
        "I_L_Looter_SG_F",
        "I_L_Looter_Rifle_F"
    ];
     
    private _group_size = 1 + (ceil (random 5));

    // create a group
    private _group = createGroup east;
    for [{_i = 0 }, {_i < _group_size}, {_i = _i + 1}] do {
        private _type = selectRandom _types;
        private _veh = _group createUnit [_type, _pos, [], 5, 'NONE'];
        [_veh] joinSilent _group;
        _obj_list pushBack _veh;
        sleep .1;
    };

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;

    if (_action == "patrol") then {
        // create a patrol
        [_group, _pos, 1000] call BIS_fnc_taskPatrol; 
    
        // mark if it is a "static" (just a building, rock, ...) or not encounter
        //   if it is "static", we won't bother to delete it later
        _entry = [false, _pos, false, _obj_list, false, objNull, objNull];

    } else {
        // create a garrison waypoint

        [_group, getPosATL _building] call BIS_fnc_taskDefend;
        _trg = createTrigger ["EmptyDetector", _building, true];
        _obj_list pushBack _trg;
        _trg setTriggerArea [100, 100, 0, false]; 
        _trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
        private _activation = "private _v = spawned_encounters get '" + _UID + "'; _v set [2, true]; spawned_encounters set ['" + _UID + "', _v]; publicVariable 'spawned_encounters';"; 
        _trg setTriggerStatements ["this", _activation, ""];

        // mark if it is a "static" (just a building, rock, ...) or not encounter
        //   if it is "static", we won't bother to delete it later
        _entry = [false, getPosATL _building, false, _obj_list, false, objNull, objNull];
    };

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
