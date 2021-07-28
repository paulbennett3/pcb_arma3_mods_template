/* *******************************************************************
                      mis_template

Template for "top level" missions (ie, ones that call the utility
missions like "destroy", "clear" et al by customizing).

NOTE: The "lower level" missions will set the public variable
   "mission_active" to false on completion.  If you don't use one of
    those, you need to do it to end the mission.

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

// do stuff here ...
// when done, 
// [_state] call pcb_fnc_end_mission;

// -------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
