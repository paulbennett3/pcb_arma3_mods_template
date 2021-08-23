/* *******************************************************************
                           scn_occult

Scenario -- occult

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
    "DSA_Hatman",

Vampire
    Abomination
    Rake
    "DSA_Shadowman",

Cultist / "Demon Lord"
    Demon
    "DSA_411",
    "DSA_Snatcher",

Always Around
    Active Idol / ActiveIdol2
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
params ["_sobj", "_action"];

_sobj set ["Name", "Occult"];

switch (_action) do {
    case "create": {
        ["create"] call (_sobj get "_log");

        if (! isNil "scenarioCreated") exitWith {};
        scenario_created = true;
        publicVariable "scenario_created";

        // Pick our boss and minion types
        private _boss_info = selectRandom [
            ['DSA_Mindflayer', ['DSA_Crazy', 'DSA_Hatman']],
            ['DSA_Vampire', ['DSA_Abomination', 'DSA_Rake', 'DSA_Shadowman']],
            ['RyanZombieboss28', ['DSA_Snatcher', 'DSA_411']]
        ];
        private _ambient = [
            'DSA_Crazy', 
            'DSA_Crazy', 
            'DSA_Wendigo', 
            'DSA_Wendigo', 
            'DSA_Wendigo', 
            'DSA_Wendigo', 
            'DSA_ActiveIdol', 
            'DSA_ActiveIdol2'
        ];

        private _spook_boss = _boss_info select 0;
        private _spook_minions = _boss_info select 1;
        ["------------------------------------"] call pcb_fnc_debug;
        ["Boss <" + (str _spook_boss) + ">  Minions <" + (str _spook_minions) + ">"] call pcb_fnc_debug;
        ["------------------------------------"] call pcb_fnc_debug;
        types_hash set ["weaker spooks", _spook_minions];
        types_hash set ["boss spook", _spook_boss];
        types_hash set ["spooks", _ambient];
          
        // Do we want a parent task (ie, missions as sub-tasks)?
        PARENT_TASK = "";  // set to objNull if we don't
        publicVariable "PARENT_TASK";

        // this is the array of possible missions to choose from.  Might be modified as things progress
        (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_wait_for_clustering.sqf";
        _sobj set ["Mission Select", "sequential"];

        // total missions to run
        _sobj set ["Total Missions", 1];

        // remember our state
        ["initialization complete"] call (_sobj get "_log");
     };

    case "mission_completed": {
        ["Mission complete"] call (_sobj get "_log");
        if (((_sobj get "Scenario State") == 1) && ((_sobj get "Total Missions") == 0)) then {
            _sobj set ["Scenario State", 2];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List", []];
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_desk_evidence.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_investigate.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_building_search.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_interview.sqf";

            _sobj set ["Total Missions", selectRandom [2, 3]];
            _sobj set ["Mission Select", "random"];
        }; 
        if (((_sobj get "Scenario State") == 2) && ((_sobj get "Total Missions") == 0)) then {
            _sobj set ["Scenario State", 3];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List", []];
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_monster_hunt.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_rescue_scp.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_spawner.sqf";

            _sobj set ["Total Missions", 1];
            _sobj set ["Mission Select", "random"];
        }; 
        if (((_sobj get "Scenario State") == 3) && ((_sobj get "Total Missions") == 0)) then {
            _sobj set ["Scenario State", 4];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List", []];
//            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_get_laptop_from_base.sqf";
//            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_deliver_evidence.sqf";
//            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_spawner.sqf";
//            if (worldName isEqualTo "Cam_Lao_Nam") then {
//                (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_tunnels.sqf";
//            } else {
                (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_boss.sqf";
//            };
           
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_exfil.sqf";

            _sobj set ["Total Missions", count (_sobj get "Mission List")];

            _sobj set ["Mission Select", "sequential"];
        }; 

    };
};

