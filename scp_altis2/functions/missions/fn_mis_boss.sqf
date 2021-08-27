/* *******************************************************************
                      mis_boss

Spawn a boss monster spook, possibly with minions

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
params ["_sobj", "_UID"];

private _ok = false;
private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];
private _result = [_ok, _state];

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

// generate our minion monsters
// [_obj_list, _type, _n, _did]
//private _enc_info = [_pos, 101] call pcb_fnc_mission_encounter;
private _enc_info = [_pos, 101] call (_sobj get "Mission Encounter");
private _obj_list = _enc_info select 0;
private _type = _enc_info select 1;
private _n = _enc_info select 2;
private _did = _enc_info select 3;

// generate boss
private _group = group (_obj_list select 0);
private _type = types_hash get "boss spook";
private _veh = _group createUnit [_type, [_pos select 0, _pos select 1], [], 30, 'NONE'];
private _tries = 50;
while { (_tries > 0) && (! alive _veh) } do {
    _tries = _tries - 1;
    _veh = _group createUnit [_type, [_pos select 0, _pos select 1], [], 30, 'NONE'];
};
["Spawned boss " + (str _type) + " with " + (str _tries) + " left"] call pcb_fnc_debug;
_veh triggerDynamicSimulation false;
_obj_list pushBack _veh;

{
    [_x] spawn {
        params ["_unit"];
        private _marker = createMarker ["ME" + (str _unit), getPosATL _unit];
        _marker setMarkerShapeLocal "ELLIPSE";
        _marker setMarkerSizeLocal [100, 100];
        _marker setMarkerAlphaLocal 0.5;
        _marker setMarkerColor "ColorRED";
        while { sleep 30; alive _unit } do {
            private _mpos = (getPosATL _unit) getPos [random 50, random 360];
            _marker setMarkerPos _mpos;
            ["Monster <" + (str _unit) + "> alive"] call pcb_fnc_debug;
        };
        ["Monster <" + (str _unit) + "> died"] call pcb_fnc_debug;
        deleteMarker _marker;
    };
} forEach _obj_list;


_state set ["targetlist", _obj_list];
_state set ["targettype", _type];

[_loc_type] call pcb_fnc_debug; 
[str _obj_list] call pcb_fnc_debug;

_state set ["taskdesc", [
    "Eliminate the occult leader and its minions",
    "Eliminate leader and minions",
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
//[_pos, 7, 10] call pcb_fnc_add_anomalies;
[_pos, 7, 10] call (_sobj get "Add Anomalies");
[_pos] call (_sobj get "Decorate");

// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
