/* *******************************************************************
                      mis_tunnels

!!! only works on Cam Lao Nam map !!!!


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

******************************************************************* */
params ["_UID"];

private _ok = false;
private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];
private _result = [_ok, _state];

private _types = types_hash get "looters";

// We'll put it in either a city or forest
private _pos = [0, 0, 0];
private _loc_type = "";
private _building = objNull;

if (true) then {
    _loc_type = "forest";
    // forest
    private _tries = 100;
    while {_tries > 0} do {
        _tries = _tries - 1;

        // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
        private _center = [epicenter, 500, mission_radius, 5, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;
        _pos = ((selectBestPlaces [_center, 500, "5*forest + trees + hills - 5*meadow - 3*houses", 10, 1]) select 0) select 0;
        if ([_pos] call pcb_fnc_is_valid_position) then {
            _tries = -10;
        };
    };
    if ((_tries > -10) or (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { [false, _state] };
};

// test if we have utterly failed ... 
if (! ([_pos] call pcb_fnc_is_valid_position)) exitWith { [false, _state] };

//private _n_garrison = 5 + (ceil (random 25));
_types = [_types select 0, _types select 1];
private _n_garrison = 5;
private _tunnel_stuff = [_pos, _types, _n_garrison] call pcb_fnc_sog_tunnels;
private _grp = _tunnel_stuff select 0;
private _tpos = _tunnel_stuff select 1;
[_grp, true] call pcb_fnc_spawn_cultists;

["Asked for " + (str _n_garrison) + " got " + (str (count (units _grp)))] call pcb_fnc_debug;

_state set ["obj_list", units _grp];

_state set ["targetlist", units _grp];
_state set ["targettype", str _types];
_state set ["threshold", ceil ((count (units _grp)) / 2)];

_state set ["taskdesc", [
    "Hunt down and thin out the fanatical Cult of the Wendigo",
    "Thin out Wendigo Cult fanatics",
    "markername"
]];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];
_state set ["taskpos", _pos];  // note that the task is the position of the tunnel complex, not the entrance!
_state set ["taskradius", 1500];
sleep 1;
_result = [_state] call pcb_fnc_mis_ll_clear;


// add a guard near the entrance
private _ctypes = [ "O_Soldier_SL_F", "O_soldier_M_F", "O_Sharpshooter_F", "O_medic_F" ];
private _n = selectRandom [3,4,4,4,6];
private _group = [_ctypes, _n, _pos, east, false] call pcb_fnc_spawn_squad;
[_group] call pcb_fnc_spawn_cultists;
private _wpg = _group addWaypoint [_pos, 10];
_wpg setWaypointType "GUARD";
_wpg setWaypointCombatMode "RED";
_wpg setWaypointBehaviour "AWARE";
createGuardedPoint [east, _pos, -1, objNull];

/* ----------------------------------------------------------------
                 Configure and Place Anomalies 
---------------------------------------------------------------- */
[_pos, 7, 10] call pcb_fnc_add_anomalies;
["World Name <" + worldName + ">"] call pcb_fnc_debug;
// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
