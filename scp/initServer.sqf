/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */
pcb_DEBUG = true;
//pcb_DEBUG = false;
publicVariable "pcb_DEBUG";

[] call pcb_fnc_server_state_manager;
[] call pcb_fnc_advancedTowingInit;
[] call pcb_fnc_set_mission_environment;
[] call pcb_fnc_start_base_setup;
[] call pcb_fnc_director;
[] call pcb_fnc_background;
