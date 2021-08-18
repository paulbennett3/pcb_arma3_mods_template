/* *******************************************************************
                      mis_wait_for_clustering

Wait awhile. Sit and listen.

Kill time for a litte bit.
Uses the "delay" mission type.

Parameters:
   _UID (string) : the UID assigned by the mission generator

Returns:
   _result (array) : [ _ok, _state ]
           where:
              _ok (bool) : true if mission generated ok, false if
                   any errors or failures happened (and we should try again)
              _state (hashmap) : any state needed to cleanup after this mission
                 Keys:
                    "obj_list" (array) : list of "vehicles" to delete
                    "marker_list" (array) : list of "markers" to delete
                    ???

******************************************************************* */
params ["_sobj", "_UID"];

private _ok = false;
private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

private _code = {
    params ["_state"];
["Delay Task Starting"] call pcb_fnc_debug;
    sleep 30;
    waitUntil { sleep 30; (! isNil "background_clustering_done") && { background_clustering_done == true } };
["Delay Task Done!"] call pcb_fnc_debug;
};
_state set ["delay code", _code];
_state set ["taskpos", start_pos];
_state set ["taskdesc", [
    "HQ gathering intel on military complexes and urban areas.  Try some target practice, make notes on your loadout etc.  Kill Time -- if you can! (mission will complete when processing ready)",
    "Kill: Time",
    "markername"
]];
private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];
sleep 1;
_result = [_state] call pcb_fnc_mis_ll_delay;

// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
