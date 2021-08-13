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

if ((random 100) < 75) then {
    private _loc_type = "building";
    private _tries = 50;
    while { _tries > 0 } do {
        _tries = _tries - 1;
        _building = [epicenter, mission_radius] call pcb_fnc_get_cool_building_location;
        if (! isNil "_building") then {
            _pos = getPosATL _building;
            if (! isNil "_pos") then { 
                [_building] call pcb_fnc_add_loot_boxes_to_building;
                _tries = -10;
            };
        };
    };
} else {
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

private _tunnel_stuff = [_pos, _types, 5 + (ceil (random 5))] call pcb_fnc_sog_tunnels;
private _grp = _tunnel_stuff select 0;
private _tpos = _tunnel_stuff select 1;
[_grp] call pcb_fnc_spawn_cultists;

_state set ["obj_list", units _grp];

_state set ["targetlist", (_state get "obj_list")];
_state set ["targettype", str _types];

_state set ["taskdesc", [
    "Hunt down and thin out the Cult of the Wendigo",
    "Eliminate cult",
    "markername"
]];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];
_state set ["taskpos", _pos];  // note that the task is the position of the tunnel complex, not the entrance!
_state set ["taskradius", 1500];
sleep 1;
_result = [_state] call pcb_fnc_mis_ll_clear;


/* ----------------------------------------------------------------
                 Configure and Place Anomalies 
---------------------------------------------------------------- */
[_pos, 7, 10] call pcb_fnc_add_anomalies;
["World Name <" + worldName + ">"] call pcb_fnc_debug;
// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
