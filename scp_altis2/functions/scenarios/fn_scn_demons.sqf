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



Mindflayer
    Thralls
         DSA_Thrall module (no parameters) -- synch ai to this
    Crazy

Vampire
    Abomination
    Rake

Cultist / "Demon Lord"
    Demon
    "DSA_411",
    Active Idol / ActiveIdol2

??
    "DSA_Hatman",
    "DSA_Shadowman",
    "DSA_Snatcher",

Always Around
    Wendigo

-----------
SPOOK INFO
Wendigo: This creature resembles a humanoid deer. It is fast and tough. When close to an enemy, it will attack by leaping at them.
Shadowman: These beings are completely black. They can teleport and attack with psychic blasts.
Hatman: A shadowman with a hat.
Vampires: Fast and tough, they leap into and out of combat. Can attack with melee and leaps.
Mindflayer: Slow but deadly psychic creatures. Their powers allow them to attack from a distance. Then can mind-control targets and turn them into thralls.
411: Near-invisible ambush predator. Turn your back on it when close and it can pounce and kill in a single hit. Your best defence is your eyes.
Rake: These creatures are completely white. They move hunched over and attack with melee.
Abomination: Shrouded in a cloud of black, these creatures launch powerful stab attacks from long range.
Snatcher: These semi-visible creatures can change their texture to match their environment. They can teleport their target hundreds of meters away to isolate them.
Crazy: A basic zombie type creature
Cursed Idol: An active version of the Cursed Idol object. They require heavy weapons to kill and perform powerful melee attacks.


ANOMALIES
These are static points of danger with aural or visual cues. There update period and range of effect can be set in the Core module.

Launchpad:	Throws victim a random distance.
Leech:		Drains stamina, may also knock victim down and drain health.
Trapdoor:	Teleports victim up to 1000m away.
Zapper:		Calls down lightning on the victim.


******************************************************************* */
params ["_action"];

[("Scenario Demons <" + (str _action) + ">")] call pcb_fnc_debug;

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

        // start spawning spare vehicles etc
        [] call pcb_fnc_background;
 
        // manipulate the starting weather et al
        [] call pcb_fnc_set_mission_environment;


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

        // remember our state
        scenario_state = 1;
        publicVariable "scenario_state";
        [("Scenario Demons completed <" + (str _action) + ">")] call pcb_fnc_debug;
     };

    case "mission_completed": {
        [("Scenario Demons <" + (str _action) + ">")] call pcb_fnc_debug;
        if ((scenario_state == 1) && (total_missions == 0)) then {
            scenario_state = 2;
            publicVariable "scenario_state";

            // update our mission list (what we can choose from)
            mission_list = []; 
            mission_list pushBackUnique "functions\missions\fn_mis_monster_hunt.sqf";
//            mission_list pushBackUnique "functions\missions\fn_mis_desk_evidence.sqf";
//            mission_list pushBackUnique "functions\missions\fn_mis_investigate.sqf";
//            mission_list pushBackUnique "functions\missions\fn_mis_building_search.sqf";
//            mission_list pushBackUnique "functions\missions\fn_mis_interview.sqf";
            publicVariable "mission_list"; 

            total_missions = 3;
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
            mission_list pushBackUnique "functions\missions\fn_mis_get_laptop_from_base.sqf";
            mission_list pushBackUnique "functions\missions\fn_mis_deliver_evidence.sqf";
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

