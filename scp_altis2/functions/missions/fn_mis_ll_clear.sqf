/* ------------------------------------------------------------------
                         mission: clear

Remove all of a thing / item / group from an area 
    Purge, transport, destroy, ... but a group!

Designed to be called to handle all aspect (create, update, delete) of the mission.
Pass in a string to the "_action" parameter to select which action to do.
The _state hashmap contains arguments for the phase, as well as outputs (object lists
for deletion, markers, etc).

Arguments:
   _state (hashmap) : see below for definition

Returns:
   _started_ok (boolean) : true if the mission was initialized and started correctly, false else
   _state (hash map) : any information needed to clean up from the mission (object lists etc)


State Object:
   "targetlist"   (list of objects)  person / thing to inhume
                   Assumed to already exist and be positioned!!!
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task ("" for no parent)
   "taskpos"  (position)  location
   "taskradius" (number) distance from pos that targets must stay within 


Example:
    private _state = createHashMapFromArray [
        ["targetlist", [_wendigo1, _wendigo2]], // list of objects
        ["taskdesc", [
            "Kill the wendigos. If you can.",
            "Kill wendigos",
            "markername"]],
        ["taskpid", ""],
        ["taskpos", _pos],
        ["taskradius", 1000]
    ];
    _result = [ "create", _state] call pcb_fnc_mis_clear;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

diag_log str [_state];
if (pcb_DEBUG) then {
    hint ("CLEAR " + (str (_state get "targetlist")));
};


// create a trigger to monitor the area (and for us to stick our
// variable info in
private _trg = createTrigger ["EmptyDetector", _state get "taskpos", true];
_trg setTriggerArea  [
    _state get "taskradius", 
    _state get "taskradius",
    0, false, -1 
];       
_trg setTriggerType "NONE";
_state set ["trigger", _trg];

_state set ["obj_list", [_trg]];
_trg setVariable ["_state", _state, true];


// ---------------
// set up our task
// ---------------
private _tid = "MIS_CLEA_" + (str ([] call pcb_fnc_get_next_UID));
if ((_state get "taskpid") isEqualTo "") then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};

private _pos = (_state get "taskpos");

if (pcb_DEBUG) then {
    hint ("creating task with " + (str (_state get "taskdesc")) + " at " + (str _pos));
};
[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED", 2] call BIS_fnc_taskCreate;


// -----------------------------------------
// spawn a piece of code to monitor our area
// -----------------------------------------
[_state] spawn {
    params ["_state"];
    private _done = false;
    while {sleep 1; ! _done} do {
        // check if any of our targets are in the area
        private _objs = (_state get "targetlist") inAreaArray (_state get "trigger");
        if ((count _objs) < 1) then {
            _done = true;
            _state set ["failed", true];
            {
                if (! (alive _x)) then {  
                    _state set ["failed", false];
                };
            } forEach (_state get "targetlist");
            [_state] call pcb_fnc_end_mission;
        };
    };
};


// Return our success at start and state info to the mission generator 
_ok = true;
private _result = [_ok, _state];
_result
