/* --------------------------------------------------------------------
                            Director

Monitors the scenario and updates as needed


We track our spawned encounters in the HashMap "spawned_encounters"
Structure is:
    Key (string) : UID ("S" + number)
    Value (list): [static, trigger, obj_list, has_delete_func, delete_func, delete_func_args]
          static (boolean) : true - static object, don't delete.  false -- kill at will
          trigger : either at the spawn point (static) or on an object (patrol, for example) -- used
             to test if any players are in range 
          obj_list (array of objects) : list of all objects (which can be removed with
               deleteVehicle!)
          has_delete_func (boolean) : true -- next element the delete func - false, its objNull
          delete_func (code or objNull) : function to delete anything else (waypoints, markers, ...)
          delete_func_args : argument(s) to pass to delete func
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

// *****************************************************
// set some global variables regarding encounter create
// *****************************************************
TICKS_BETWEEN_ENCOUNTERS = 6;
P_ENCOUNTER = 0.5;
ENC_DIST = 750;  // distance from player to set center of search
ENC_RADIUS = 250;
ENC_MIN_PLAYER_DIST_CREATE = 500;
ENC_MIN_PLAYER_DIST_DELETE = 1500;
ENC_MAX_ACTIVE_ENC = 20;

// *****************************************************

// for tracking groups for deletion as we get full
group_stack = [];
publicVariable "group_stack";

[] spawn {
    private _count = 0;
    private _sleep_time = 10;
    private _trigger_group_gc = 200; // max groups is ~288
    sleep _sleep_time;

    spawned_encounters = createHashMap;

    private _last_encounter_tick = 1;

    private _trg = createTrigger ["EmptyDetector", playableUnits select 0, true];
    _trg setTriggerArea [ENC_MIN_PLAYER_DIST_DELETE, ENC_MIN_PLAYER_DIST_DELETE, 0, false];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["this", "", ""];

    // don't start the director loop until clustering is done
    ["Director waiting for clustering to complete"] call pcb_fnc_debug;
    waitUntil { sleep 30; (! isNil "background_clustering_done") && { background_clustering_done == true } };
    ["Director starting"] call pcb_fnc_debug;
   
    while {true} do {
        sleep _sleep_time;
        _count = _count + 1;
        
        private _n_active_enc = count spawned_encounters;
        [
            "director tick " + 
            (str _count) + " " + 
            (str _n_active_enc) + " <" + 
            (str (count group_stack)) + ">"
        ] call pcb_fnc_debug;

        if ((count group_stack) > _trigger_group_gc) then {
            [] spawn {
                ["Starting group garbage collection"] call pcb_fnc_debug;
                [_trigger_group_gc] call pcb_fnc_group_garbage_collect;
                ["Done with group garbage collection"] call pcb_fnc_debug;
            };
        };

        // keep a list of hashmap UIDs to delete when done iterating
        private _delete_keys = [];

        // should we despawn any encounters?
        {
            // _x is the key, _y is the value

            // don't delete "static" entries
            if (! (_y select 0)) then {
                // are there any players within range?
                private _area = [getPosATL ((_y select 2) select 0)] + (triggerArea _trg);
                if (! ([_area] call pcb_fnc_players_in_area)) then {
                    // delete the hashmap entry!
                    ["Deleting encounter - no players in area " + (str _y) + 
                     " <" + (str _area) + ">" + 
                     (str (getPosATL ((_y select 2) select 0)))] call pcb_fnc_debug;

                    // so not static and no players within 2k -- delete!
                    //  Note!  can't use nested forEach!!!
                    private _objs = _y select 2;
                    for [{_i = 0 }, {_i < (count _objs)}, {_i = _i + 1}] do {
                        private _veh = _objs select _i;

                        // delete any crew first! 
                        for [{_ii = 0 }, {_ii < (count (crew _veh))}, {_ii = _ii + 1}] do {
                            private _crew = (crew _veh) select _ii; 
                            _veh deleteVehicleCrew _crew;
                        };
                        
                        deleteVehicle _veh;  // should check if it is a vehicle first, delete crew ...
                    }; 
                    // if there is a "delete" bloc of code, call it
                    if (_y select 3) then {
                        private _delete_code = _y select 4;
                        [_y select 5] call _delete_code;
                    };

                    _delete_keys pushBack _x;
                };
            };
        } forEach spawned_encounters;
       
        // delete any hashmap entries we marked
        {
            spawned_encounters deleteAt _x;
        } forEach _delete_keys;
        publicVariable "spawned_encounters";

        // should we spawn an encounter?
        if ((_count - _last_encounter_tick) > TICKS_BETWEEN_ENCOUNTERS) then {
            if ((random 1) < P_ENCOUNTER) then {
                if (_n_active_enc < ENC_MAX_ACTIVE_ENC) then {
["Director attempting spawn <" + (str _last_encounter_tick) + ">"] call pcb_fnc_debug;
                    private _did_spawn = [] call pcb_fnc_do_director_spawn;    
                    if ((! isNil "_did_spawn") && { _did_spawn }) then {
                        _last_encounter_tick = _count;
                    };
                };
            };
        };
    };
};

