/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */

"Group" setDynamicSimulationDistance 500;
"EmptyVehicle" setDynamicSimulationDistance 250;

// --------------------------------------
// make a reference position and object
// --------------------------------------
world_center = [worldSize / 2, worldSize / 2];
publicVariable "world_center";
mworld_center = createMarker ["MWORLD_CENTER", world_center];
"MWORLD_CENTER" setMarkerType "Empty";
publicVariable "mworld_center";

//pcb_DEBUG = true;
pcb_DEBUG = false;
publicVariable "pcb_DEBUG";

[] call pcb_fnc_types; // initialize our type lists

[] call pcb_fnc_advancedTowingInit;
[] call pcb_fnc_server_state_manager;
[] call pcb_fnc_mission_generator;
[] call pcb_fnc_monitor_ratings;

// ------------------------------------------
// epicenter is set in fn_preinit_setup.sqf
// ------------------------------------------
_marker = createMarker ["mEPI", epicenter];
"mEPI" setMarkerSize [mission_radius, mission_radius];

if (pcb_DEBUG) then {
    "mEPI" setMarkerShapeLocal "ELLIPSE";
    "mEPI" setMarkerColorLocal "ColorRED";
    "mEPI" setMarkerBrushLocal "BORDER";
    "mEPI" setMarkerAlpha 0.9;
};
// ------------------------------------------

["initServer done and ready to kill Wendigos!"] call pcb_fnc_debug;
