/* *******************************************************************
                      mis_alien_spawner

This mission generates a "spawner" object that must be destroyed
   to complete the mission.  It spawns units (with a delay in 
   between) until there is a fixed number active, or is destroyed.

   It uses the "destroy" mission type.

Parameters:
   _UID (string) : the UID assigned by the mission generator

Returns:
   _result (array) : [ _ok, _state ]
           where:
              _ok (bool) : true if mission generated ok, false if
                   any errors or failures happened (and we should try again)
              _state (hashmap) : any state needed to cleanup after this mission
                 Keys:
                    "obj_list" (array) : list of "vehicles" to delete
                    "marker_list" (array) : list of "markers" to delete
                    ???

!!! Make this actually spawn stuff, and ideally "garrison" the
 location ...
******************************************************************* */
params ["_sobj", "_UID"];

private _ok = false;
private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];
private _result = [_ok, _state];


private _possible_objects = types_hash get "tech large items"; 

private _target = objNull;
private _object_type = selectRandom _possible_objects;
private _pos = [0,0,0];
private _tries = 100;
while {_tries > 0} do {
    _tries = _tries - 1;

    // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
    private _center = [epicenter, 500, mission_radius, 10, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;
    _pos = ((selectBestPlaces [_center, 500, "5*forest + trees + hills - meadow - 3*houses", 10, 1]) select 0) select 0;
    if ([_pos] call pcb_fnc_is_valid_position) then {
        _target = _object_type createVehicle [0,0,0]; 
        _target setPos _pos; 
        sleep 1;
        if ((! (isNull _target)) and (alive _target) and ([(getPosATL _target)] call pcb_fnc_is_valid_position)) then {
            _tries = -10;
        };
    };
}; 

// test if we have utterly failed ... 
if ((_tries > -10) or (isNull _target) or (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { _result };

private _desc = objNull;
_desc = [ "Locate and eliminate the source of incursions", "Eliminate source", ""];
_destroyable = false;
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state = createHashMapFromArray [
    ["target", _target],
    ["taskpos", _pos],
    ["taskdesc", _desc],
    ["taskpid", _taskpid],
    ["is_destroyable", _destroyable],
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

private _temp = [_state] call pcb_fnc_mis_ll_destroy;

// save our state in our target "for later"
_target setVariable ["_state", _state, true];

// -----------------------------------------
//   Spawn boss and defensive force
// -----------------------------------------
private _pos = [_pos select 0, _pos select 1];
private _boss = types_hash get "boss spook";
private _n_troops = selectRandom [3,3,3,4,5];
private _types = types_hash get "weaker spooks";
private _ctypes = [];
private _nt = 0;
for [{_nt = 0}, {_nt < _n_troops}, {_nt = _nt + 1}] do {
    _ctypes pushBack (selectRandom _types);
};
private _group = [_ctypes, _pos, east, false] call pcb_fnc_spawn_squad;

if ((isNil "_boss") || (_boss isEqualTo "")) then {
    ["No boss for this scenario"] call pcb_fnc_debug;
    private _bossgroup = [_ctypes, _pos, east, false] call pcb_fnc_spawn_squad;
} else {
    // spawn the boss 
    private _bossgroup = [[types_hash get "boss spook"], _pos, east, false] call pcb_fnc_spawn_squad;
    _bossgroup selectLeader ((units _bossgroup) select 0);
    
    (units _group) joinSilent _bossgroup;
    _group = _bossgroup; 
};

// spawn vehicles if they exist
_types = types_hash get "vehicle spooks";
if ((! (isNil "_types")) && ((count _types) > 0)) then {
    private _type = selectRandom _types;
    private _nv = 1;
    for [{_nv = selectRandom [3,2,2,2,1,1,1,1]}, {_nv > -1}, {_nv = _nv - 1}] do {
        private _vpos = [_pos, 20, 2000, false] call pcb_fnc_get_small_base_pos;
        private _stuff = [[_vpos select 0, _vpos select 1], 0, _type, _group] call BIS_fnc_spawnVehicle;
    };
};
// spawn drones if they exist
_types = types_hash get "drone spooks";
if ((! (isNil "_types")) && ((count _types) > 0)) then {
    private _type = selectRandom _types;
    for [{_nv = selectRandom [3,2,2,2,1]}, {_nv > -1}, {_nv = _nv - 1}] do {
        private _vpos = [_pos, 20, 2000, false] call pcb_fnc_get_small_base_pos;
        private _stuff = [[_vpos select 0, _vpos select 1], 0, _type, _group] call BIS_fnc_spawnVehicle;
    };
};

[_group, _pos] spawn {
    params ["_group", "_pos"];
    while {sleep 30; alive (leader _group)} do {
        if ((count waypoints _group) < 1) then {
            private _wp = _group addWaypoint [_pos, 100];
            _wp setWaypointType "GUARD";
            _wp setWaypointCombatMode "RED";
            _wp setWaypointBehaviour "COMBAT";
        }; 
    }; 
};

createGuardedPoint [east, _pos, -1, objNull];


// ------------------------------------------
//   Spawn spawner
// ------------------------------------------
private _types = types_hash get "weaker spooks";
[_target, _types, _pos, _UID] spawn {
    params ["_target", "_types", "_pos", "_UID"];

    sleep 10;
    private _n_spawn = selectRandom [10, 10, 11, 11, 12, 13, 15, 20];
    private _delay = 10;
    private _obj_list = [];
    private _group = createGroup east;
    _group enableDynamicSimulation true;
    _group deleteGroupWhenEmpty false;  // can go empty, but will respawn ...
    while { (alive _target) && (! isNull _target) } do {
        sleep (_delay + (random 40));

        private _keep_list = [];
        private _del_list = [];

        {
           if ((! isNull _x) && (alive _x)) then {
               _keep_list pushBackUnique _x;
           } else {
               _del_list pushBackUnique _x;
           };
        } forEach _obj_list;

        _obj_list = _keep_list;

        {
            deleteVehicle _x;
        } forEach _del_list;

        if ((count _obj_list) < _n_spawn) then {
            if (pcb_DEBUG) then {
                [(_UID + " spawner spawning <" + (str (count _obj_list)) + "> ...")] call pcb_fnc_debug;
            };
            // chance for vehicle or drone?
            if ((random 100) < 15) then {
                if ((random 100) < 35) then {
                    private _veh_types = types_hash get "vehicle spooks";
                    if ((! isNil "_veh_types") && ((count _veh_types) > 0)) then {
                        private _type = selectRandom _veh_types;
                        [( " vehicle <" + _type + "> ...")] call pcb_fnc_debug;
                        private _vpos = [_pos, 20, 2000, false] call pcb_fnc_get_small_base_pos;
                        private _foo = [
                            [_vpos select 0, _vpos select 1], random 360, _type, _group
                        ] call BIS_fnc_spawnVehicle;
                    };
                } else {
                    private _veh_types = types_hash get "drone spooks";
                    if ((! isNil "_veh_types") && ((count _veh_types) > 0)) then {
                        private _type = selectRandom _veh_types;
                        [( " drone <" + _type + "> ...")] call pcb_fnc_debug;
                        private _vpos = [_pos, 20, 2000, false] call pcb_fnc_get_small_base_pos;
                        private _foo = [
                            [_vpos select 0, _vpos select 1], random 360, _type, _group
                        ] call BIS_fnc_spawnVehicle;
                    };
                };
            } else {
                private _type = selectRandom _types;
                private _veh = _group createUnit [_type, [_pos select 0, _pos select 1], [], 5, 'NONE'];
                [_veh] joinSilent _group;
                _veh triggerDynamicSimulation false;
                _obj_list pushBack _veh;
            };
        };

        if ((count (waypoints _group)) < 1) then {
            private _wp = _group addWaypoint [_pos, 500];
            _wp setWaypointType "GUARD";
            _wp setCombatMode "RED";
            _wp setWaypointBehaviour "COMBAT";
        }; 
    };

    sleep 10;

    // target destroyed, so do cleanup
    {
        deleteVehicle _x;
    } forEach _obj_list;
};


// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
