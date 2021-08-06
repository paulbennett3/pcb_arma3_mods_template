/* *******************************************************************
                      mis_

1) spawn "evidence" in desk at main base
2) find a transmitter, or else spawn a research base on a hilltop (or both?) 
3) create "get evidence" quest to get stuff from base
4) create "deliver evidence" quest to research facility

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
    hint "Desk Evidence running";
};

// -------------------
// find building
// -------------------
private _transmitters = nearestTerrainObjects [start_pos, ["Transmitter"], worldSize, false];
private _building = selectRandom _transmitters;
 
if ((isNil "_building") || (isNull _building)) exitWith { hint "failed to find building!"; [false, _state] };

private _pos = getPosATL _building;
if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { [false, _state] };

private _cargo = "Laptop_Closed";

_state set ["target", _cargo];
_state set ["is_obj", false];
_state set ["in_area", true];
_state set ["container", objNull];
_state set ["taskpos", getPosATL _building];
_state set ["taskradius", 50];
_state set ["taskdesc", [
    "Take the collated evidence and reports to the designated transmitter",
    "Go to transmitter",
    "markername"]];
_state set ["taskpid", ""];
_state set ["callback", [false, objNull, objNull]];
private _result = [_state] call pcb_fnc_mis_ll_put_item;

// add some anomalies
[getPosATL _building, 1, 5] call pcb_fnc_add_anomalies;
//[getPosATL _target] call pcb_fnc_occult_decorate;
[getPosATL _building, 30] call pcb_fnc_mission_encounter;


_result
