
// Set if this is an SCP or Stargate mod
pcb_mod_name = "stargate";
//pcb_mod_name = "scp";

pcb_gate_blacklist = [];
publicVariable "pcb_gate_blacklist";
if (pcb_mod_name isEqualTo "scp") then {
    [] call pcb_fnc_spawn_scp_base;
};

// global variable init
pcb_spawned_stuff = [];
pcb_mission_complete = True; // don't start in the middle of a mission ...
// start our black list with the SGC (stay at least 2k away)
pcb_gate_blacklist = [ [getPosATL sgc_briefing, 2000] ];
pcb_task_count = 0;

// make our various globals public 
publicVariable "pcb_mod_name";
publicVariable "pcb_spawned_stuff";
publicVariable "pcb_mission_complete";
publicVariable "pcb_task_count";


// if there isn't a marker named "respawn_west", create it at the location of the table
if (! ("respawn_west" in allMapMarkers)) then {
    private _respawn = createMarker ["respawn_west", getPosATL sgc_briefing];
};

// set up our "briefing table" with commands etc
remoteExec ["pcb_fnc_create_briefing_table", 0];
