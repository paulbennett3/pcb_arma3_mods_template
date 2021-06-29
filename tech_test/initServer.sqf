// precompile common scripts
pcb_loadout = compile preprocessFile "scripts\pcb_loadout.sqf";
pcb_place_stargate = compile preprocessFile "scripts\pcb_place_stargate.sqf";

pcb_spawned_stuff = [];
pcb_mission_complete = True; // don't start in the middle of a mission ...
pcb_mission_list = [["explore", true], 
                    ["resupply_ship", false]];

// used for tracking loadout once set
pcb_player_loadout = createHashMap;


// make our various globals public 
publicVariable "pcb_loadout";
publicVariable "pcb_place_stargate";
publicVariable "pcb_spawned_stuff";
publicVariable "pcb_mission_complete";
publicVariable "pcb_mission_list";
publicVariable "pcb_player_loadout";

// set initial mission
[] spawn {
    sleep 5;
    [  true, 
       "T001", 
       [  "Gather in briefing room", 
          "Go to briefing room on floor above stargate level", 
          "Briefing"], 
      [sgc_briefing, true], 
      "ASSIGNED"] call BIS_fnc_taskCreate;
};

// add handling for special chat commands
[] call compile preprocessFile "scripts\pcb_chat_commands.sqf";

// set up the "briefing" table for missions, loadouts, ..
sgc_briefing addAction ["Get Mission", "scripts\pcb_dispatch_mission.sqf", [], 1.5];
[sgc_briefing] call compile preprocessFile "scripts\pcb_add_loadout_actions_to_object.sqf";
