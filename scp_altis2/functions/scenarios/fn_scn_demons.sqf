/* *******************************************************************
                           scn_demons

Scenario -- Demons!

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

if (pcb_DEBUG) then {
    diag_log ("Scenario Demons <" + (str _action) + ">");
    hint ("Scenario Demons <" + (str _action) + ">");
};

switch (_action) do {
    case "create": {
        if (! isNil "scenarioCreated") exitWith {};
        scenario_created = true;
        publicVariable "scenario_created";

        // adjust start position if desired
        [] call pcb_fnc_random_start_pos;

        // start spawning spare vehicles etc
        [] call pcb_fnc_background;
 
        // manipulate the starting weather et al
        [] call pcb_fnc_set_mission_environment;

        // create the "base camp" + spawning point
        [] call pcb_fnc_start_base_setup;

        // Do we want a parent task (ie, missions as sub-tasks)?
        PARENT_TASK = "TGATHER";  // set to objNull if we don't
        publicVariable "PARENT_TASK";
        [true, PARENT_TASK, [
            "Gather evidence and information about occult activity near the Epicenter",
            "Collect evidence",
            "markerpos"
        ], objNull, 'ASSIGNED'] call BIS_fnc_taskCreate;

        // this is the array of possible missions to choose from.  Might be modified as things progress
//        mission_list pushBackUnique "functions\missions\fn_mis_spawner.sqf";
//        mission_list pushBackUnique "functions\missions\fn_mis_monster_hunt.sqf";
        mission_list = []; // we "register" missions here, last one first, 
        mission_list pushBackUnique "functions\missions\fn_mis_desk_evidence.sqf";
        mission_list pushBackUnique "functions\missions\fn_mis_investigate.sqf";
        mission_list pushBackUnique "functions\missions\fn_mis_building_search.sqf";
        publicVariable "mission_list"; 

        // total missions to run
        total_missions = 1 + (ceil (random 3));
        publicVariable "total_missions";

        // remember our state
        scenario_state = 1;
        publicVariable "scenario_state";
     };

    case "mission_completed": {
        if (scenario_state == 1) then {
            if (total_missions < 1) then {
                scenario_state = 2;
                publicVariable "scenario_state";
                total_missions = 2;
                publicVariable "total_missions";

                // update our mission list (what we can choose from)
                mission_list = []; // we "register" missions here, last one first, 
                mission_list pushBackUnique "functions\missions\fn_mis_spawner.sqf";
                mission_list pushBackUnique "functions\missions\fn_mis_monster_hunt.sqf";
                publicVariable "mission_list"; 

                // should check for at least one success ...
                private _ptask_state = "FAILED";
                {
                    if ((_x call BIS_fnc_taskState) isEqualTo "SUCCEEDED") then { _ptask_state = "SUCCEEDED"; };
                } forEach ([PARENT_TASK] call BIS_fnc_taskChildren);
     
                [PARENT_TASK, _ptask_state, true] call BIS_fnc_taskSetState; 

                PARENT_TASK = "TDESTROY";  // set to objNull if we don't
                publicVariable "PARENT_TASK";
                [true, PARENT_TASK, [
                    "Hunt down and eliminate paranormal entities",
                    "Eliminate paranormal entities",
                    "markerpos"
                ], objNull, 'ASSIGNED'] call BIS_fnc_taskCreate;
            };
        } else {
            if (total_missions < 1) then {
                // should check for at least one success ...
                private _ptask_state = "FAILED";
                {
                    if ((_x call BIS_fnc_taskState) isEqualTo "SUCCEEDED") then { _ptask_state = "SUCCEEDED"; };
                } forEach ([PARENT_TASK] call BIS_fnc_taskChildren);
     
                [PARENT_TASK, _ptask_state, true] call BIS_fnc_taskSetState; 
            };
        }; 
    };
};

