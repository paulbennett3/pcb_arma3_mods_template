/* --------------------------------------------------------------------
                       objective locate object

Given a title, position and a radius from that position:
   1) create a task to find the object, with objective marker
   2) set a trigger to resolve the task
   3) delete the task on finding

This is a utility function, mainly for "go find the thing" that isn't
really a mission objective (ie, the start crate, vehicles, base, ...)

_taskID (string or array) : task id for BIS_fnc_taskCreate
_title (string) : thing to find (used as task name and description)
_pos (position) : where the thing is
_radius (number) : how big to make the trigger (circular) for discovery
-------------------------------------------------------------------- */

params ["_taskID", "_title", "_pos", "_radius"];

if (! isServer) exitWith {};

// create task
private _description = [
    "Locate " + _title,
    _title,
    ""  
];
[true, _taskID, _description, _pos, "ASSIGNED"] call BIS_fnc_taskCreate;

// create trigger to resolve task
private _trg = objNull;
if (_radius == 0) then {
    // don't make a trigger with radius 0 -- use completion of child tasks instead
} else {
    _trg = createTrigger ["EmptyDetector", _pos];
    _trg setTriggerArea [_radius, _radius, 0, false];
    _trg setVariable ["payload", ['simple_task', _taskID, 'DONE', _trg]];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    _trg setTriggerStatements [
        "this",
        "private _msg = thisTrigger getVariable 'payload'; [_msg] call pcb_fnc_send_mail;",
        ""
    ]; 
};

// tell the server state manager to handle this
private _msg = ["simple_task", _taskID, "ASSIGNED", _trg];
[_msg] call pcb_fnc_send_mail;

