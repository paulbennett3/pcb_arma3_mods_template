/* *******************************************************************
                      mis_investigate

Investigate an occult site

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

// -------------------------------------

if (pcb_DEBUG) then {
    hint "Investigate running";
};

private _possible_objects = types_hash get "occult large items";
private _target = objNull;
private _object_type = selectRandom _possible_objects;
private _pos = [0,0,0];
private _tries = 100;
while {_tries > 0} do {
    _tries = _tries - 1;

    // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
    private _center = [epicenter, 500, mission_radius, 5, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;
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
if ((_tries > -10) or (isNull _target)) exitWith { [false, _state] };

private _code = {
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _state = _target getVariable "_state";
    _state set ["failed", false];        
    [_state] call pcb_fnc_end_mission;
};

_state set ["target", _target];
_state set ["taskdesc", [
        "Investigate the site for signs of occult activity",
        "Investigate",
        "markername"]];
_state set ["taskpos", getPosATL _target];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];
_state set ["action", "study"];
_state set ["code", _code];
_state set ["duration", 15];

_target setVariable ["_state", _state, true];  // gets overwritten in ll interact, but oh well

// add some anomalies
[getPosATL _target, 1, 5] call pcb_fnc_add_anomalies;
[getPosATL _target] call pcb_fnc_occult_decorate;
[getPosATL _target] call pcb_fnc_mission_encounter;

private _result = [_state] call pcb_fnc_mis_ll_interact;
_result
