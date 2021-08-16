/* *******************************************************************
                           scn_aliens

Scenario -- Aliens!  Uses the Stargate mod foes (Goa'uld, Ori, Wraith).  Based on Demons scenario.

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
        types_hash set ["background_options_with_weights", types_hash get "aliens_options_with_weights"];

        // Pick our boss and minion types
        //   [boss type, [minion type(s)],[vehicle types], [drone types]]
        // no boss ("") = use lots of minions!
        private _boss_info = selectRandom [
            ["sga_prior1", ["sga_ori_soldier1"], [ "sga_needlethreader_normal" ], ["SG_gouald_drone"]],
            ["", ["WL_SG_Replicator"], [], ["SG_gouald_drone"]],
            ["sga_jaffa_black_leader", ["sga_jaffa_serpent_guard_closed"], ["SG_DeathGlider_heli"], ["SG_gouald_drone"]],
            ["Wraith_Leader", ["Wraith_Drone"], ["sg_wraith_dart_normal"], ["SG_gouald_drone"]]
        ];
        private _ambient = [
            'DSA_Wendigo', 
            'DSA_ActiveIdol', 
            'DSA_ActiveIdol2'
        ];


        private _spook_boss = _boss_info select 0;
        private _spook_minions = _boss_info select 1;
        private _spook_vehicles = _boss_info select 2;
        private _spook_drones = _boss_info select 3;

        ["------------------------------------"] call pcb_fnc_debug;
        ["Boss <" + (str _spook_boss) + ">  Minions <" + (str _spook_minions) + ">"] call pcb_fnc_debug;
        ["------------------------------------"] call pcb_fnc_debug;
        types_hash set ["weaker spooks", _spook_minions];
        types_hash set ["boss spook", _spook_boss];
        types_hash set ["drone spooks", _spook_drones];
        types_hash set ["vehicle spooks", _spook_vehicles];

        _ambient = _ambient + _spook_minions;
        types_hash set ["spooks", _ambient];
          
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

            total_missions = selectRandom [2, 2];
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
            mission_list pushBackUnique "functions\missions\fn_mis_monster_hunt.sqf";
            mission_list pushBackUnique "functions\missions\fn_mis_monster_hunt.sqf";
            publicVariable "mission_list"; 

            total_missions = 1;
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
            mission_list pushBackUnique "functions\missions\fn_mis_alien_spawner.sqf";
            mission_list pushBackUnique "functions\missions\fn_mis_exfil.sqf";
            publicVariable "mission_list"; 

            total_missions = count mission_list;
            publicVariable "total_missions";

            mission_select = "sequential";
            publicVariable "mission_select"; 
        }; 
    };
};

