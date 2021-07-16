/* ******************************************************************
                   fn_enc_civ

Spawn some civilians
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

if ((random 1) > 0.35) then {
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
        "vn_c_men_01", "vn_c_men_02", "vn_c_men_05", "vn_c_men_06",
        "vn_c_men_09", "vn_c_men_10", "vn_c_men_13", "vn_c_men_14",
        "vn_c_men_17", "vn_c_men_18", "vn_c_men_21", "vn_c_men_22",
        "vn_c_men_25", "vn_c_men_26", "vn_c_men_29", "vn_c_men_30",
        "vn_c_men_24", "vn_c_men_03", "vn_c_men_04", "C_IDAP_Man_AidWorker_01_F",
        "C_IDAP_Man_AidWorker_08_F", "C_IDAP_Man_AidWorker_05_F", "C_IDAP_Man_AidWorker_04_F",
        "C_IDAP_Man_AidWorker_03_F", "C_man_p_beggar_F_afro", "C_Man_casual_2_F_afro",
        "C_man_polo_1_F_afro", "C_man_shorts_2_F_afro", "C_Man_casual_8_F_asia",
        "C_man_polo_4_F_asia"
    ];
     
    private _group_size = 0 + (ceil (random 6));

    // create a group
    private _group = createGroup civilian;
    for [{_i = 0 }, {_i < _group_size}, {_i = _i + 1}] do {
        private _veh = _group createUnit [selectRandom _types, _pos, [], 5, 'NONE'];
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
        [_group, _pos, 200] call BIS_fnc_taskPatrol; 
    
        // mark if it is a "static" (just a building, rock, ...) or not encounter
        //   if it is "static", we won't bother to delete it later
        _entry = [false, _pos, false, _obj_list, false, objNull, objNull];
    } else {
        // create a garrison task
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
        //["find_garrison", "civ garrison", getPosATL _building, 10] call pcb_fnc_objective_locate_object;
    };

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
