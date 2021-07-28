/* ------------------------------------------------------------------
                         mission: interact

Talk to, study, etc an object / person / etc. Perform some addActionHold
  type thing, but leave it otherwise undisturbed

    Study thing, interrogate individual, ...

Designed to be called to handle all aspect (create, update, delete) of the mission.
Pass in a string to the "_action" parameter to select which action to do.
The _state hashmap contains arguments for the phase, as well as outputs (object lists
for deletion, markers, etc).

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   updated version of hash map 

State Object:
   "target"     (object)  person / thing to inhume
                   Assumed to already exist and be positioned!!!
   "taskpos"   (position) : where the task takes place 
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task (defaults to objNull for no parent)
   "is_destroyable"  (bool)    if true, kill it. If false, use UAVs to allow it to be blown up
   "callback"  [has_callback, callback_func, callback_args] 
           where:
               has_callback (bool)  true if there is a callback function (to call on delete)
               callback_func (string)  the name of the function (with path!) to call
               callback_args (list of anything) the arguments to pass to the callback function


Example:
    private _state = createHashMapFromArray [
        ["target", _idol],
        ["taskdesc", [
            "Destroy the stone statue at the Old Mill in Derbyshire",
            "Destroy Idol",
            "markername"]],
        ["taskpos", getPosATL _idol],
        ["taskpid", objNull],
        ["action", "study"],
        ["code", { hint 'you should study more'; }],
        ["duration", 15]
    ];
    _state = [_state] call pcb_fnc_mis_destroy;

------------------------------------------------------------------ */

params ["_state"];
private _ok = false;

diag_log str [_state];
if (pcb_DEBUG) then {
    hint ("INTERACT " + (str (_state get "target")) + _action);
};

// ---------------
// set up our task
// ---------------
private _tid = "MIS_INTE_" + (str ([] call pcb_fnc_get_next_UID));
if (isNull (_state get "taskpid")) then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};

private _pos = (_state get "targetpos");

[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED", 2] call BIS_fnc_taskCreate;
 
private _code = {
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _state = _target getVariable "_state";
    _state set ["failed", false];
    [_state] call pcb_fnc_end_mission;
};
[_target, _state get "action", _state get "code", _state get "duration"] call pcb_fnc_add_interact_action_to_object;

// add our state variable to the target so we can grab it later
(_state get "target") setVariable ["_state", _state, true];


// --------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
