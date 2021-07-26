/* ------------------------------------------------------------------
                        Mission: Transport

Transport object / person from point A to point B

   Rescue, cargo haul, kidnapping

Designed to be called to handle all aspect (create, update, delete) of the mission.
Pass in a string to the "_action" parameter to select which action to do.
The _state hashmap contains arguments for the phase, as well as outputs (object lists
for deletion, markers, etc).

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   updated version of hash map 

State Object:
   "target"     (object)  person / thing to transport
                   Assumed to already exist and be positioned!!!
   "destination" (position) place target needs to end up at
   "taskdesc_pickup"   [(string),(string),(string)]  task description, task name, task marker
   "taskdesc_delivery"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task (defaults to objNull for no parent)

Example:
    private _state = createHashMapFromArray [
        ["target", _chemlight],
        ["destination", _building buildingPos 0],
        ["taskdesc_pickup", [
            "Acquire chemlight for delivery to destination",
            "Acquire chemlight",
            "markername"]],
        ["taskdesc_delivery", [
            "Deliver chemlight to factory so they can see what they are doing",
            "Deliver chemlight",
            "markername"]],
        ["taskpid", objNull]
    ];
    _state = [ "create", _state] call pcb_fnc_mis_transport;

------------------------------------------------------------------ */

params ["_state"];
private _ok = false;

diag_log str [_action, _state];
if (pcb_DEBUG) then {
    hint ("Transport " + (str (_state get "target")) + _action);
};


// ---------------
// set up our pickup task
// ---------------
private _tid = "MIS_TRAN_" + (str ([] call pcb_fnc_get_next_UID));
if (isNull (_state get "taskpid")) then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};
_state set ["taskstate", "ASSIGNED"];

private _pos = (_state get "target");

[true, (_state get "taskid"), (_state get "taskdesc_pickup"), _pos, (_state get "taskstate"), 2] call BIS_fnc_taskCreate;

// add our state variable to the target so we can grab it later
(_state get "target") setVariable ["_state", _state, true];



// [_state get "taskid", "SUCEEDED"] call BIS_fnc_taskSetState;

// ----------------------
_ok = true;
private _result = [_ok, _state];
_result

