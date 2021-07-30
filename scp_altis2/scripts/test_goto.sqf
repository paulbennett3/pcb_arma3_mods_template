hint "test goto script running";

/*
private _pos = (playableUnits select 0) getRelPos [12, 90];

private _taskpid = "";
if (! isNil "PARENT_TASK") then {
    _taskpid = PARENT_TASK;
     [("PTID = <" + (str _taskpid) + ">")] remoteExec ["systemChat", 0, true];
};
private _state = createHashMapFromArray [
    ["taskpos", _pos],
    ["taskradius", 3],
    ["taskdesc", [
        "Goto place",
        "Vamanos!",
        "markername"]],
    ["taskpid", _taskpid]
];
private _result = [_state] call pcb_fnc_mis_ll_goto;
*/
["TESTUID"] call pcb_fnc_mis_building_search;
