/* *****************************************************************************
                                 log group

Used to grack group creation, since we are limited to 288 groups total!

Params
   _group (obj) : newly created group

Returns
    Nothing
***************************************************************************** */
params ["_group"];

// ----------------------------------
// mutex stuff
// ----------------------------------
private _my_mutex_id = "log_group_id";

if (isNil "group_mutex") then {
    group_mutex = ["create", _my_mutex_id] call pcb_fnc_mutex;
    publicVariable "group_mutex";
};
waitUntil { ! isNil "group_mutex"; };

// now take the mutex -- will pend until taken
["get", _my_mutex_id, group_mutex] call pcb_fnc_mutex;
// ----------------------------------
// ----------------------------------




group_stack pushBackUnique [_group, serverTime]; 

// some mitigation efforts
_group deleteGroupWhenEmpty true;

// toggle dynamic simulation on -- shouldn't really matter since we delete when far
// away, but there is a chance to have lots of units ...
_group enableDynamicSimulation true;




// ------------------------
// release our mutex
// ------------------------
["release", _my_mutex_id, group_mutex] call pcb_fnc_mutex;

