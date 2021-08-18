/* *******************************************************************
                           scn_zombies

Scenario -- Zombies!  Uses Ryan's Zombies and Demons. Based on Demons scenario.

A scenario is a linked set of missions for the players to complete.
It sets the tone, start point, missions, etc.  It is called from
initServer to initialize and set the "insertion point" and start base,
then by the mission generator to update the mission list (before and
between each mission).

It manipulates the following public variables:
    start_pos    Where the players start, base camp is, and initial
                  respawn point
    mission_list  The list of missions to choose from.  This is an
                 array of one or more path strings to randomly select from 
                eg ["functions\missions\fn_mis_XXX.sqf"]
    total_missions The number of missions to complete.  The mission generator
                will decrement these on each completed mission, and will
                end when it is below 1.  So for an "early exit", you can
                set this to 0 ...

Parameters:
    _action (string) : which state we are in when called
          States are:
              "create" : initialize mission_list, total_missions, start_pos,
                         setup base camp etc
              "mission_completed" : called after a mission is completed, but
                         before the next mission.  Use this to reset the
                         mission_list if appropriate


******************************************************************* */
params ["_action"];

private _scn_name = "Aliens";
[("Scenario " + _scn_name + " <" + (str _action) + ">")] call pcb_fnc_debug;


switch (_action) do {
    case "create": {
        if (! isNil "scenarioCreated") exitWith {};
        scenario_created = true;
        publicVariable "scenario_created";

        // adjust start position if desired
        [] call pcb_fnc_random_start_pos;
        waitUntil { ! isNil "random_start_ready" };

        // create the "base camp" + spawning point
        //[] call pcb_fnc_start_base_setup;
        [] call pcb_fnc_start_base_setup2;

        // manipulate the starting weather et al
        [] call pcb_fnc_set_mission_environment;

        // over-ride defaults in fn_types / types_hash
        types_hash set ["zombies", types_hash get "zombies_ryan"];
        types_hash set ["weaker spooks", types_hash get "zombies_ryan"];
        types_hash set ["spooks", types_hash get "zombies_ryan"];
        types_hash set ["background_options_with_weights", types_hash get "zombies_options_with_weights"];
        // subset civilians
        private _civ_temp = (types_hash get "civilians") select { (random 100) < 10 };
        _civ_temp = _civ_temp + (types_hash get "civ infected");
        types_hash set ["civilians", _civ_temp];
 
        // Do we want a parent task (ie, missions as sub-tasks)?
        PARENT_TASK = "";  // set to objNull if we don't
        publicVariable "PARENT_TASK";

        // this is the array of possible missions to choose from.  Might be modified as things progress
        mission_list = []; // we "register" missions here, last one first, 
        mission_list pushBackUnique "functions\missions\fn_mis_wait_for_clustering.sqf";
        publicVariable "mission_list"; 
        mission_select = "sequential";
        publicVariable "mission_select"; 

        // total missions to run
        total_missions = 1;
        publicVariable "total_missions";

        // fire off the director for tracking background stuff
        [] call pcb_fnc_director;

        // start spawning spare vehicles etc
        sleep 1;
        [] call pcb_fnc_background;
 
        // remember our state
        scenario_state = 1;
        publicVariable "scenario_state";
        [("Scenario " + _scn_name + " completed <" + (str _action) + ">")] call pcb_fnc_debug;
     };

    case "mission_completed": {
        [("Scenario " + _scn_name + " <" + (str _action) + ">")] call pcb_fnc_debug;
        if ((scenario_state == 1) && (total_missions == 0)) then {
            scenario_state = 2;
            publicVariable "scenario_state";

            // update our mission list (what we can choose from)
            mission_list = []; 
            mission_list pushBackUnique "functions\missions\fn_mis_interview.sqf";
            publicVariable "mission_list"; 

            total_missions = selectRandom [1, 2];
            publicVariable "total_missions";

            mission_select = "random";
            publicVariable "mission_select"; 
        }; 
        if ((scenario_state == 2) && (total_missions == 0)) then {
            scenario_state = 3;
            publicVariable "scenario_state";

            // update our mission list (what we can choose from)
            // remember to do these in reverse order!!! 
            mission_list = []; 
            mission_list pushBackUnique "functions\missions\fn_mis_zombie_hunt.sqf";
            publicVariable "mission_list"; 

            total_missions = 2; 
            publicVariable "total_missions";

            mission_select = "random";
            publicVariable "mission_select"; 
        }; 
        if ((scenario_state == 3) && (total_missions == 0)) then {
            scenario_state = 4;
            publicVariable "scenario_state";

            // update our mission list (what we can choose from)
            // remember to do these in reverse order!!! 
            mission_list = []; 
            mission_list pushBackUnique "functions\missions\fn_mis_spawner.sqf";
            mission_list pushBackUnique "functions\missions\fn_mis_exfil.sqf";
            publicVariable "mission_list"; 

            total_missions = count mission_list;
            publicVariable "total_missions";

            mission_select = "sequential";
            publicVariable "mission_select"; 
        }; 
    };
};

