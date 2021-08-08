/* ------------------------------------------------------------------
                         mission: delay

Kill time!  Used mainly for waiting for other parts of the scenario to be ready ...


Arguments:
   _state (hashmap) : see below for definition

Returns:
   _started_ok (boolean) : true if the mission was initialized and started correctly, false else
   _state (hash map) : any information needed to clean up from the mission (object lists etc)


State Object:
   "delay code" (code) : code that takes _state as parameter, and returns when delay is complete
                            This code will be spawned here, and mission ends when code returns
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task ("" for no parent)
   "taskpos"    (position) where to mark the task at


Example:
    private _code = {
        params ["_state"];
            sleep 30;
        };
    };
    private _state = createHashMapFromArray [
        ["taskpos", start_pos],
        ["delay code", _code],
        ["taskdesc", [
            "Kill time. If you can.",
            "Wait awhile. Sit and listen",
            "markername"]],
        ["taskpid", ""],
    ];
    _result = [ "create", _state] call pcb_fnc_mis_clear;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

[str [_state]] call pcb_fnc_debug;


// ---------------
// set up our task
// ---------------
private _tid = "MIS_WAIT_" + (str ([] call pcb_fnc_get_next_UID));
if ((_state get "taskpid") isEqualTo "") then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};

[true, (_state get "taskid"), (_state get "taskdesc"), start_pos, "ASSIGNED"] call BIS_fnc_taskCreate;


// -----------------------------------------
// spawn a piece of code to monitor our area
// -----------------------------------------
[_state] spawn {
    params ["_state"];
    [_state] call (_state get "delay code");
    _state set ["failed", false];
    [_state] call pcb_fnc_end_mission;
};


// Return our success at start and state info to the mission generator 
_ok = true;
private _result = [_ok, _state];
_result
