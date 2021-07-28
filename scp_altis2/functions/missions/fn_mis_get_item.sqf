/* ------------------------------------------------------------------
                            Mission: get item

Retreive / take item.  Succeeds when item is in a playableUnit's inventory.

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   _ok (boolean) : true if mission started correctly 
   _state (hash map) : any state we'll need for later (cleanup, etc)


State Object:
   "target"     (type string -- item or magazine!)  thing to get
   "container"  (obj)     container holding thing
   "taskpos"    (position) location of container (and target)
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task (defaults to objNull for no parent)


Example:
    private _state = createHashMapFromArray [
        ["target", "FlashDrive"],
        ["container", _crate],
        ["taskpos", getPosATL _crate],
        ["taskdesc", [
            "Get the flash driver from the desk in the research lab",
            "Retreive evidence",
            "markername"]],
        ["taskpid", objNull],
    ];
    _result = [_state] call pcb_fnc_mis_get_item;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

diag_log (str _state);
if (pcb_DEBUG) then {
    hint ("GET ITEM " + (str (_state get "target")));
};


// ---------------
// set up our task
// ---------------
private _tid = "MIS_IGET_" + (str ([] call pcb_fnc_get_next_UID));
if (isNull (_state get "taskpid")) then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};
private _pos = (_state get "taskpos");
[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED", 2] call BIS_fnc_taskCreate;

// -------------------------------------
// Set up a way to tell task is complete
// -------------------------------------
[_state] spawn {
    params ["_state"];
    private _thing = _state get "target";
    private _container = _state get "container";

    private _done = false;
    while { sleep 5; ! _done } do {
        private _in_container = true;
 
        // did the container get blown up?
        if (_state get "failed") then {
            _done = true;
        };
        if ((isNull _container) || (! alive _container)) then {
            _state set ["failed", true];
            [_state] call pcb_fnc_end_mission;
            _done = true; 
        } else {
            _in_container = (_thing in (getItemCargo _container)) || 
                            (_thing in (getWeaponCargo _container)) || 
                            (_thing in (magazineCargo _container)); 
        };

        private _in_inventory = false;
        { 
            if (_thing in (itemsWithMagazines _x)) then {
                _in_inventory = true;
            };
        } forEach playableUnits;

        if ((! _in_container) && _in_inventory) then {
            [_state] call pcb_fnc_end_mission;
            _done = true;
        };
    };
};

// handle container getting destroyed
[
    (_state get "container"),
    [
        "Deleted",
        {
            params ["_entity"];
            private _state = _entity getVariable "_state";

            _state set ["failed", true];
            [_state] call pcb_fnc_end_mission;
        }
    ]
] remoteExec ["addEventHandler", 0, true];
[
    (_state get "container"),
    [
        "MPKilled",
        {
            params ["_unit", "_killer", "_instigator", "_useEffect"];
            private _state = _unit getVariable "_state";
            _state set ["failed", true];
            [_state] call pcb_fnc_end_mission;
        }
    ]
] remoteExec ["addMPEventHandler", 0, true];
[
    (_state get "container"),
    [
        "Explosion",
        {
            params ["_vehicle", "_damage"];
            private _state = _vehicle getVariable "_state";

            _state set ["failed", true];
            [_state] call pcb_fnc_end_mission;
        }
    ]
] remoteExec ["addEventHandler", 0, true];


// -------------------------------------------------------------------
// stick our state in the container so we can get it from event handlers
// -------------------------------------------------------------------
(_state get "container") setVariable ["_state", _state];

// -----------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
