
// global variable init
pcb_spawned_stuff = [];
pcb_mission_complete = True; // don't start in the middle of a mission ...
// start our black list with the SGC (stay at least 2k away)
pcb_gate_blacklist = [ [getPosATL sgc_briefing, 2000] ];
pcb_task_count = 0;

// make our various globals public 
publicVariable "pcb_spawned_stuff";
publicVariable "pcb_mission_complete";
publicVariable "pcb_gate_blacklist";
publicVariable "pcb_task_count";

// set up our "briefing table" with commands etc
[] call pcb_fnc_create_briefing_table;
