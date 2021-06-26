pcb_mission_state = 1;
pcb_loadout = compile preprocessFile "scripts\pcb_loadout.sqf";

[] spawn {
    sleep 5;
    [  true, 
       "T001", 
       [  "Go to dialing computer", 
          "Go to stargate dialing computer in the control room", 
          "Computer"], 
      [sgc_computer, true], 
      "ASSIGNED"] call BIS_fnc_taskCreate;
};
