/* ------------------------------------------------------------------
                            Mission: put item

Put item in container / get item to area.  Succeeds when item is in container / area.
    Fails if container destroyed ... 

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   _ok (boolean) : true if mission started correctly 
   _state (hash map) : any state we'll need for later (cleanup, etc)


State Object:
   "target"     (type string -- item or magazine!)  thing to put
   "in_area"    (boolean) - true if item must be in area, false if in container
   "container"  (obj)     container for placing thing (objNull if in_area true)
   "taskpos"    (position) location of container (and target)
   "taskradius" (number) radius of "acceptable area" if in_area is true 
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task (defaults to objNull for no parent)


Example:
    private _state = createHashMapFromArray [
        ["target", "FlashDrive"],
        ["in_area", false],
        ["container", _crate],
        ["taskpos", getPosATL _crate],
        ["taskradius", 5],
        ["taskdesc", [
            "Put the flash drive in the desk in the research lab",
            "Plant evidence",
            "markername"]],
        ["taskpid", objNull],
    ];
    _result = [_state] call pcb_fnc_mis_put_item;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

diag_log (str _state);
if (pcb_DEBUG) then {
    hint ("PUT ITEM " + (str (_state get "target")));
};


// ---------------
// set up our task
// ---------------
private _tid = "MIS_IPUT_" + (str ([] call pcb_fnc_get_next_UID));
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

    if (_state get "in_area") then {
        // is it in the area?
        private _center = _state get "taskpos";
        private _radius = _state get "taskradius";
        
        private _done = false;
        while { sleep 5; ! _done } do {
            // first, are there any players in the area?
            if ([[_center, _radius]] call pcb_fnc_players_in_area) then {
                // technically, if a player is in the area and another player has the
                // item but is *not* in the area, this will still fire.  *shrug*
                {
                    if (_thing in (itemsWithMagazines _x)) then {
                        // gotta be in one of these ...
                        _x removeItemFromBackpack _thing; 
                        _x removeItemFromVest _thing; 
                        _x removeItemFromUniform _thing; 

                        _state set ["failed", false];
                        [_state] call pcb_fnc_end_mission;
                        _done = true;
                    };
                } forEach playableUnits;
            };
        };
    } else {
        // is it in the container?
        private _container = _state get "container";

        private _done = false;
        while { sleep 5; ! _done } do {
            private _in_container = false;
 
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
                if (_in_container) then {
                    [_state] call pcb_fnc_end_mission;
                    _done = true;
                };
            };
        };
    };
};

// -------------------------------------------------------------
// if it isn't an area, handle container fall down go boom ...
// -------------------------------------------------------------
if (! (_state get "in_area")) then {
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
    private _container = _state get "container";
    if ((! isNil "_container") && (! isNull _container)) then {
        (_state get "container") setVariable ["_state", _state, true];
    };
};

// -----------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
