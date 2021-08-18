/* *******************************************************************
                      mis_building_search

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

params ["_sobj", "_UID"];

private _ok = false;

private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

// -------------------------------------


// pick a random cool building
private _target = [epicenter, mission_radius, 5] call pcb_fnc_get_cool_building_location; 
// get a specific position in the building
private _pos = selectRandom (_target buildingPos -1);

// test if we have utterly failed ...
if ((! ([_pos] call pcb_fnc_is_valid_position)) or (isNull _target)) exitWith { [false, _state] };

_state set ["taskdesc", [
        "Search the target site for signs of occult activity",
        "Search site",
        "markername"]];
_state set ["taskpos", _pos];
_state set ["taskradius", 5];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "") ) then { 
    _taskpid = PARENT_TASK;
};
_state set ["taskpid", _taskpid];

_target setVariable ["_state", _state, true];  // gets overwritten in ll interact, but oh well

// put some loot boxes in the building
[_target] call pcb_fnc_add_loot_boxes_to_building;

// add some anomalies, decorate, add (possible) foes
[getPosATL _target, 1, 5] call (_sobj get "Add Anomalies");
[_pos] call (_sobj get "Decorate");
[getPosATL _target] call (_sobj get "Mission Encounter");

private _result = [_state] call pcb_fnc_mis_ll_goto;
_result
