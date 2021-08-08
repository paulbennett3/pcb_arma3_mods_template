/* *****************************************************************************
                                 log group

Used to grack group creation, since we are limited to 288 groups total!

Params
   _group (obj) : newly created group

Returns
    Nothing
***************************************************************************** */
params ["_group"];

group_stack pushBackUnique _group; 

// some mitigation efforts
_group deleteGroupWhenEmpty true;

// toggle dynamic simulation on -- shouldn't really matter since we delete when far
// away, but there is a chance to have lots of units ...
_group enableDynamicSimulation true;

/* doesn't work -- groups aren't objects ...
_group addEventHandler ["Deleted", {
    params ["_entity"];
    ["GROUP DELETE <" + (str _entity) + ">"] call pcb_fnc_debug;
}];
*/
