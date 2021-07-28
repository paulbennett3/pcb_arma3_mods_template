/* *******************************************************************
                      mis_spawner

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
params ["_UID"];

private _ok = false;
private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];
private _result = [_ok, _state];


private _possible_objects = types_hash get "occult large items"; 

private _target = objNull;
private _object_type = selectRandom _possible_objects;
private _pos = [0,0,0];
private _tries = 100;
while {_tries > 0} do {
    _tries = _tries - 1;

    // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
    private _center = [epicenter, 500, 5000, 10, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;
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
if ((_tries > -10) or (isNull _target)) exitWith { _result };

private _desc = objNull;
_desc = [ "Destroy the cursed source causing the dead to rise.", "Destroy source", ""];
_destroyable = false;
_state = createHashMapFromArray [
    ["target", _target],
    ["taskpos", _pos],
    ["taskdesc", _desc],
    ["taskpid", objNull],
    ["is_destroyable", _destroyable],
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

private _temp = [_state] call pcb_fnc_mis_ll_destroy;

// add some "environment"
private _crows = [_pos, 50, ceil (random 20) ] remoteExec ["BIS_fnc_crows", 0];
//private _flies = [_pos, 0.1, 5] remoteExec ["BIS_fnc_flies", 0];

// save our state in our target "for later"
_target setVariable ["_state", _state, true];

// ------------------------------------------
//   Spawn spawner
// ------------------------------------------
private _types = types_hash get "zombies";
[_target, _types, _pos, _UID] spawn {
    params ["_target", "_types", "_pos", "_UID"];

    sleep 10;
    private _n_spawn = 5 + (ceil (random 10));
    private _delay = 30;
    private _obj_list = [];
    private _group = createGroup east;
    _group enableDynamicSimulation true;
    _group deleteGroupWhenEmpty false;  // can go empty, but will respawn ...
    while { (alive _target) && (! isNull _target) } do {
        sleep _delay;

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
                hint (_UID + " spawner spawning <" + (str (count _obj_list)) + "> ...");
            };
            private _type = selectRandom _types;
            private _veh = _group createUnit [_type, [_pos select 0, _pos select 1], [], 30, 'NONE'];
            [_veh] joinSilent _group;
            _veh triggerDynamicSimulation false;
            _obj_list pushBack _veh;
            [_group, _pos] call BIS_fnc_taskDefend;
        };
    };

    sleep 10;

    // target destroyed, so do cleanup
    {
        deleteVehicle _x;
    } forEach _obj_list;
};

/* ----------------------------------------------------------------
                 Configure and Place Anomalies 
---------------------------------------------------------------- */
[_pos, 3, 7] call pcb_fnc_add_anomalies;

// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
