/* --------------------------------------------------------------------
                            Director

Monitors the scenario and updates as needed


We track our spawned encounters in the HashMap "spawned_encounters"
Structur is:
    Key (string) : UID ("S" + number)
    Value (list): [static, position, player_was_near, obj_list, delete_func]
          static (boolean) : true - static object, don't delete.  false -- kill at will
          position (position) : where the spawn was done at - might not be anything
              on that exact position, though
          player_was_near (boolean) : flag for if player was close enough we shouldn't
              delete (ie, we placed a site, don't want it gone if they come back).  Set
              value with a trigger!
          obj_list (array of objects) : list of all objects (which can be removed with
               deleteVehicle!)
          has_delete_func (boolean) : true -- next element the delete func - false, its objNull
          delete_func (code or objNull) : function to delete anything else (waypoints, markers, ...)
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

_marker = createMarker ["mEPI", epicenter];
"mEPI" setMarkerSize [5000, 5000];

if (pcb_DEBUG) then {
    "mEPI" setMarkerShapeLocal "ELLIPSE";
    "mEPI" setMarkerColorLocal "ColorRED";
    "mEPI" setMarkerBrushLocal "BORDER";
    "mEPI" setMarkerAlpha 0.9;
};

[] spawn {
    private _count = 0;
    private _sleep_time = 10;

    spawned_encounters = createHashMap;

    private _last_encounter_tick = 1;
   
    while {true} do {
        sleep _sleep_time;
        _count = _count + 1;
        
        if (pcb_DEBUG) then {
            hint ("director tick " + (str _count) + " " + (str (count spawned_encounters)));
        };

        // should we spawn an encounter?
        if ((_count - _last_encounter_tick) > 6) then {
            if ((random 1) < 0.5) then {
                private _did_spawn = [] call pcb_fnc_do_director_spawn;    
                if (_did_spawn) then {
                    _last_encounter_tick = _count;
                };
            };
        };

        // keep a list of hashmap UIDs to delete when done iterating
        private _delete_keys = [];

        // should we despawn any encounters?
        {
            // _x is the key, _y is the value

            // don't delete "static" entries
            if (! (_y select 0)) then {
                // if a player was ever "close", don't delete -- flag set by trigger
                if (! (_y select 2)) then {
                    // Last check (most expensive) --
                    // are there any players within range?
                    if (! ([_y select 1] call pcb_fnc_players_in_area)) then {
                        // delete the hashmap entry!
                        if (pcb_DEBUG) then {
                            hint ("Deleting encounter " + (str _y));
                        };
                        // so not static, not visited, and no players within 2k -- delete!
                        //  Note!  can't use nested forEach!!!
                        private _objs = _y select 3;
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
                        if (_y select 4) then {
                            private _delete_code = _y select 5;
                            [_y select 6] call _delete_code;
                        };

                        _delete_keys pushBack _x;
                    };
                }; 
            };
        } forEach spawned_encounters;
       
        // delete any hashmap entries we marked
        {
            spawned_encounters deleteAt _x;
        } forEach _delete_keys;
        publicVariable "spawned_encounters";
    };
};

