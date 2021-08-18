/* *******************************************************************
                      mis_interview

Interview survivors

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

// pick a building, spawn some civs, have them damaged, put them
//  in "defend"
// pick one to "interview"

// then find a random building, and positions within ...
private _building = [epicenter, mission_radius] call pcb_fnc_get_cool_building_location;
if ((isNil "_building") || (isNull _building)) exitWith { hint "failed to find building!"; [false, _state] };
private _pos = getPosATL _building;
if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { [false, _state] };

private _positions = _building buildingPos -1;
private _target = objNull;

// -----------------------------------------------------------------

private _obj_list = [];
private _n = 1 + (ceil (random 7));

if (true) then {
    private _civs = types_hash get "civilians";

    private _group = createGroup civilian;
    private _tries = 50;
    while {_tries > 0} do {
        _tries = _tries - 1;
        private _keep = [];
        for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
            _type = selectRandom _civs;
            private _ppos = selectRandom _positions;
            if (! ([_ppos] call pcb_fnc_is_valid_position)) then {
                _ppos = _pos;
            };
            private _veh = _group createUnit [_type, _ppos, [], 50, 'NONE'];
            _veh setPos _ppos;
            _veh triggerDynamicSimulation false; // won't wake up enemy units
            _keep pushBack _veh;
            sleep .1;
        };
        sleep 0.1;

        {
            if (alive _x) then {
                _tries = -10;
                _obj_list pushBack _x;
            } else {
                deleteVehicle _x;
            };
        } forEach _keep;
    };

    _obj_list joinSilent _group;

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;
    [_group, _pos] call BIS_fnc_taskDefend;
};

{
   _x setDamage [.8, true];
} forEach _obj_list;

private _code = {
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _state = _target getVariable "_state";
    _state set ["failed", false];
    [_state] call pcb_fnc_end_mission;
};

_target = selectRandom _obj_list;
_state set ["target", _target];
_state set ["taskdesc", [
        "Interview the leader of the survivors of a paranormal attack",
        "Interview survivor",
        "markername"]];
_state set ["taskpos", getPosATL _target];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];
_state set ["action", "interview"];
_state set ["code", _code];
_state set ["duration", 15];

_target setVariable ["_state", _state, true];  // gets overwritten in ll interact, but oh well
[_target, true] remoteExec ["forceWalk", 0, true];
[group _target, "BLUE"] remoteExec ["setCombatMode", 0, true];
[group _target, "CARELESS"] remoteExec ["setBehaviour", 0, true];
[group _target, "LIMITED"] remoteExec ["setSpeedMode", 0, true];
[_target, "MIDDLE"] remoteExec ["setUnitPos", 0, true];
[_target, "SitDown", _target] remoteExec ["action", 0, true];


// add some anomalies
[getPosATL _target, 1, 5] call pcb_fnc_add_anomalies;
//[getPosATL _target] call pcb_fnc_occult_decorate;
[getPosATL _target, 10] call pcb_fnc_mission_encounter;
[_building] call pcb_fnc_add_loot_boxes_to_building;

private _result = [_state] call pcb_fnc_mis_ll_interact;

if (_result select 0) then {
    _state = _result select 1;
    _tid = _state get "taskid";
    if (! (PARENT_TASK isEqualTo "")) then { _tid = _tid select 0; };

    // -------------------------------------
    //  In case the target is mobile,
    //   periodically re-update destination
    // -------------------------------------
    [_state get "target", _tid] spawn {
        params ["_target", "_tid"];
        while { sleep 5; ((alive _target) && (! (_tid call BIS_fnc_taskCompleted))) } do {
            [_tid, getPosATL _target] call BIS_fnc_taskSetDestination;
        };
    };
};


_result
