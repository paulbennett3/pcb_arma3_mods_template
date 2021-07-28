/* *******************************************************************
                           scn_drongo

******************************************************************* */
params ["_action"];

hint ("Scenario Drongo <" + (str _action) + ">");

switch (_action) do {
    case "create": {
        // adjust start position if desired
        [] call pcb_fnc_random_start_pos;

        // start spawning spare vehicles etc
        [] call pcb_fnc_background;
 
        // manipulate the starting weather et al
        [] call pcb_fnc_set_mission_environment;

        // create the "base camp" + spawning point
        [] call pcb_fnc_start_base_setup;

        // this is the array of possible missions to choose from.  Might be modified as things progress
        mission_list = []; // we "register" missions here, last one first, 
        mission_list pushBackUnique "functions\missions\fn_mis_ll_nop.sqf";
        publicVariable "mission_list"; 

        // total missions to run
        total_missions = 1;
        publicVariable "total_missions";

        // set up Drongo's mission generator
        private _moduleGroup = createGroup sideLogic;

        diag_log "Placing DSA MissionGenerator";

        _cmd = "DSA_MissionGenerator = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_MissionGenerator setVariable ['DSA_RadiusAO', 5000, true]; DSA_MissionGenerator setVariable ['DSA_RadiusMission', 5000, true]; DSA_MissionGenerator setVariable ['DSA_MissionTypes', '''Kill'',''Purge'',''Destroy'',''Recover'',''Investigate'',''InvestigateBuilding'',''Rescue''', true]; DSA_MissionGenerator setVariable ['DSA_MissionCount', '3,7' , true]; DSA_MissionGenerator setVariable ['DSA_ChainMissions', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_RequireExfil', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_KillAllSpooks', 'FALSE', true]; DSA_MissionGenerator setVariable ['DSA_MissionScatter', 20, true]; DSA_MissionGenerator setVariable ['DSA_TaskNotification', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_UseMarkers', 'FALSE', true]; DSA_MissionGenerator setVariable ['DSA_EndAllDown', 'FALSE', true]; DSA_MissionGenerator setVariable ['DSA_EndOnComplete', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_MissionSpookTypes', '''Wendigo'',''Vampire'',''411'',''Shadowman'',''Hatman'',''Rake'',''Mindflayer'',''Abomination'',''Snatcher''', true]; DSA_MissionGenerator setVariable ['DSA_UseDMP', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_SoundWin', '', true]; DSA_MissionGenerator setVariable ['DSA_SoundLose', '', true];";

        "DSA_MissionGenerator" createUnit [
      	    epicenter,
    	    _moduleGroup,
  	    _cmd
        ];

     };

    case "mission_completed": {
    };
};






