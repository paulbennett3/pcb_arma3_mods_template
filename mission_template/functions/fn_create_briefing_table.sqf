// Using the object named "sgc_briefing", add commands for getting missions, 
//   changing loadout
//   Also add chat command handlers

// possibly check if sgc_briefing exists, and it if doesn't,
//  use that as hint to create SGC at a suitable location

// set initial mission
[] spawn {
    sleep 5;
    [  true, 
       "T001", 
          ["Go to briefing room on floor above stargate level", 
           "Go to briefing room", 
           "Briefing"], 
      [sgc_briefing, true], 
      "ASSIGNED"] call BIS_fnc_taskCreate;
};

// add trigger for the mission -- 4m radius circle does it
private _trg = createTrigger ["EmptyDetector", getPosATL sgc_briefing];
_trg setTriggerArea [4, 4, 0, false, 2];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trg setTriggerStatements ["this", 
                           "['T001', 'SUCCEEDED', true] call BIS_fnc_taskSetState;",
                           ""];


// set up the "briefing" table for missions, loadouts, ..
[] spawn { 
    sgc_briefing addAction ["Get Mission", "[] call pcb_fnc_dispatch_mission", [], 1.5, true, true, "", "true", 5];
    [sgc_briefing] call pcb_fnc_add_loadout_actions_to_object;
};
