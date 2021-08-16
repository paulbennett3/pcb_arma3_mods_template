/* *******************************************************************
                      mis_exfil

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
// Choose either airfield or helipad 
// -------------------
private _pos = [0,0,0];
if ((random 100) < 40) then {
    private _airfield = selectRandom All_airfields;
    _pos = _airfield select 0;
} else {
    private _helipad = selectRandom ((playableUnits select 0) nearObjects ["HeliH", worldSize]);
    if (! isNil "_helipad") then {
        _pos = getPosATL _helipad;
    } else {
        ["No helipads on this map?!? Using airport for Exfil"] call pcb_fnc_debug;
        private _airfield = selectRandom All_airfields;
        _pos = _airfield select 0;
    };
};

if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { [false, _state] };

_state set ["taskpos", _pos];
_state set ["taskradius", 50];
_state set ["taskdesc", [
    "Exfiltrate the island and report to headquarters unit",
    "Exfil",
    "markername"]];
_state set ["taskpid", ""];
_state set ["callback", [false, objNull, objNull]];
private _result = [_state] call pcb_fnc_mis_ll_goto;


_result
