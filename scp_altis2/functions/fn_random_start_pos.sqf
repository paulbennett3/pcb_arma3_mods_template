/* --------------------------------------------------------------------------------------
                                random_start_pos
  Pick a semi-random starting position

Will start at either an Airfield or along the coastline

Makes the following public variables:
    start_pos         position
    All_airfields     [ [[airfield 1 pos], [airfield 1 dir]],
                        [[airfield 2 pos], [airfield 2 dir]], ...
-------------------------------------------------------------------------------------- */

if (! isServer) exitWith {};
diag_log "Setting random start position";

// Get location of all Airports, primary and secondary
[] call pcb_fnc_parse_airports;

start_pos = [0, 0, 0];
start_dir = 0;
private _start_type = "Airfield";

// pick an airfield to start at
start_airfield = selectRandom All_airfields;
start_pos = start_airfield select 0;
start_dir = start_airfield select 2;

sleep .1;

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
