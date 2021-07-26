/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */
//pcb_DEBUG = true;
pcb_DEBUG = false;
publicVariable "pcb_DEBUG";

[] call pcb_fnc_server_state_manager;
[] call pcb_fnc_advancedTowingInit;
[] call pcb_fnc_monitor_ratings;
[] call pcb_fnc_mission_generator;

//[] call pcb_fnc_director;
//[] call pcb_fnc_background;
//[] call pcb_fnc_set_mission_environment;
//[] call pcb_fnc_start_base_setup;

"Group" setDynamicSimulationDistance 500;
"EmptyVehicle" setDynamicSimulationDistance 250;
diag_log "initServer done and ready to kill Wendigos!";
