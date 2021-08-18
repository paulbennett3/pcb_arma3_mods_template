/* *******************************************************************
                      mis_get_laptop_from_base_

3) create "get evidence" quest to get stuff from base

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

if (pcb_DEBUG) then {
    hint "Get Laptop running";
};

private _cargo = "Laptop_Closed";
base_desk addItemCargoGlobal [_cargo, 1];

_state set ["target", _cargo];
_state set ["container", base_desk];
_state set ["taskpos", getPosATL base_desk];
_state set ["taskdesc", [
        "Retrieve the laptop with collated evidence and reports from desk at infil base",
        "Retrieve laptop",
        "markername"]];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];

private _result = [_state] call pcb_fnc_mis_ll_get_item;
_result
