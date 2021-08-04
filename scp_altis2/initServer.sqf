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

pcb_DEBUG = true;
//pcb_DEBUG = false;
publicVariable "pcb_DEBUG";

[] call pcb_fnc_types; // initialize our type lists

[] call pcb_fnc_server_state_manager;
[] call pcb_fnc_advancedTowingInit;
[] call pcb_fnc_monitor_ratings;
[] call pcb_fnc_mission_generator;

diag_log "initServer done and ready to kill Wendigos!";
