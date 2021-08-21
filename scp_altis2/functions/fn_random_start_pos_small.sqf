/* --------------------------------------------------------------------------------------
                                random_start_pos
  Pick a semi-random starting position


Makes the following public variables:
    start_pos         position
    All_airfields     [ [[airfield 1 pos], [airfield 1 dir]],
                        [[airfield 2 pos], [airfield 2 dir]], ...
-------------------------------------------------------------------------------------- */

if (! isServer) exitWith {};
["Setting random start position"] call pcb_fnc_debug;

start_pos = [[worldSize / 2, worldSize / 2], 20, worldSize, true] call pcb_fnc_get_small_base_pos;
start_dir = random 360;

publicVariable "start_pos";
publicVariable "start_dir";

// add a marker for where the start is
private _marker = createMarker ["mstart_pos", start_pos];
_marker setMarkerType "mil_start";
_marker setMarkerText "Insertion Point";

sleep .1;
random_start_ready = true;
publicVariable "random_start_ready";

[] call pcb_fnc_mark_active_area;
