/* *******************************************************************
                      mis_monster_hunt

Spawn a handful of monsters (spooks) for the players to hunt.

Uses the "clear" mission type.

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

// We'll put it in either a city or forest
private _pos = [0, 0, 0];
private _loc_type = objNull;
if ((random 100) < 65) then {
    // city
    _pos = selectRandom ([epicenter, mission_radius] call pcb_fnc_get_city_positions);
    _loc_type = "city";
    // then find a random building, and positions within ...
    private _building = selectRandom (nearestObjects [_pos, ["House", "Building"], 100]);
    if (! isNil "_building") then {
        _pos = getPosATL _building;
    };
    [_building] call pcb_fnc_add_loot_boxes_to_building;
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

// generate our monsters
// [_obj_list, _type, _n, _did]
private _enc_info = [_pos, 101] call pcb_fnc_mission_encounter;
private _obj_list = _enc_info select 0;
private _type = _enc_info select 1;
private _n = _enc_info select 2;
private _did = _enc_info select 3;

_state set ["targetlist", _obj_list];
_state set ["targettype", _type];

[("<" + (str (_state get "targettype")) + "><" + (str _n) + "><" + (str _did) + "><" + (str _pos) + "> " + _loc_type)] call pcb_fnc_debug; 

_state set ["taskdesc", [
    "Purge the area of paranormal entities",
    "Purge area",
    "markername"
]];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];
_state set ["taskpos", _pos];
_state set ["taskradius", 1500];
sleep 1;
_result = [_state] call pcb_fnc_mis_ll_clear;


/* ----------------------------------------------------------------
                 Configure and Place Anomalies 
---------------------------------------------------------------- */
[_pos, 3, 7] call pcb_fnc_add_anomalies;

// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
