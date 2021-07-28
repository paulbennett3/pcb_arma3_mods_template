/* ------------------------------------------------------------------
                         end mission

Code for ending a mission.  It lets the mission generator
know we are done (setting "mission_active" to false), and
adds a marker on the map where the mission was.  Also, tells
the mission generator if the mission was passed or failed.

Parameters:
   _state (hashmap) : 
       required keys:
            taskid (string) : id of task to update
            taskpos (position) : location where task took place
       optional keys:
            failed (boolean) : true if mission failed 
------------------------------------------------------------------ */

params ["_state"];

// check if this code has already been called ...
if ([_state get "taskid"] call BIS_fnc_taskCompleted) exitWith {};

private _failed = false;
private _state_failed = (_state get "failed");
if (! isNil "_state_failed") then {
    _failed = _state get "failed";
};

if (_failed) then {
    [_state get "taskid", "FAILED"] call BIS_fnc_taskSetState;
} else {
    [_state get "taskid", "SUCCEEDED"] call BIS_fnc_taskSetState;
};

// add a marker for reference
private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
private _m = createMarker [_mn, (_state get "taskpos")];
_m setMarkerType "hd_objective_noShadow";
diag_log "Mission called end code";

mission_active = false;
publicVariable "mission_active";
