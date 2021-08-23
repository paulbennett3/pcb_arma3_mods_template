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
params ["_sobj", "_action"];

_sobj set ["Name", "Aliens!"];

switch (_action) do {
    case "create": {
        ["create"] call (_sobj get "_log");

        if (! isNil "scenarioCreated") exitWith {};
        scenario_created = true;
        publicVariable "scenario_created";

        private _decorate = {
            params ["_pos", ["_building", objNull]];
        };
        _sobj set ["Decorate", _decorate];

        private _mission_enc = {
            params ["_pos", ["_chance", 50], ["_max_n", 20]];

            private _obj_list = [];
            private _type = objNull;
            private _n = 1 + (floor (random _max_n));
            private _did = false;
            private _group = grpNull;

            // chance of encounter
            if ((random 100) < _chance) then {
                _did = true;
                private _types = types_hash get "weaker spooks"; // these are minion types
                private _ctypes = [];
                private _i = 0;
                for [{}, {_i < _n}, {_i = _i + 1}] do {
                    _ctypes pushBack (selectRandom _types);
                };
                _group = [_ctypes, _pos, east, false] call pcb_fnc_spawn_squad;
                _obj_list = _obj_list + (units _group);
            };
            [_obj_list, _type, _n, _did]
        };
        _sobj set ["Mission Encounter", _mission_enc];

        // over-ride defaults in fn_types / types_hash
        types_hash set ["background_options_with_weights", types_hash get "aliens_options_with_weights"];

        // Pick our boss and minion types
        //   [boss type, [minion type(s)],[vehicle types], [drone types]]
        // no boss ("") = use lots of minions!
        private _boss_info = selectRandom [
            ["sga_prior1", ["sga_ori_soldier1"], [ "sga_needlethreader_normal" ], ["SG_gouald_drone"]],
            ["", ["WL_SG_Replicator"], [], ["SG_gouald_drone"]],
            ["sga_jaffa_leader", 
                [ "sga_jaffa_serpent_guard_open", "sga_jaffa_serpent_guard_closed", "sga_jaffa"],
                ["SG_DeathGlider_heli"],["SG_gouald_drone"]
            ],
            ["sga_jaffa_black_leader", 
                [ "sga_jaffa_black", "sga_jaffa_black_serpent_guard_open", "sga_jaffa_black_serpent_guard_closed"],
                ["SG_DeathGlider_heli"],["SG_gouald_drone"]
            ],
            ["sga_jaffa_gold_leader", 
                [ "sga_jaffa_gold", "sga_jaffa_gold_serpent_guard_closed", "sga_jaffa_gold_serpent_guard_open"],
                ["SG_DeathGlider_heli"],["SG_gouald_drone"]
            ],
            ["sga_jaffa_red_leader", 
                [ "sga_jaffa_red", "sga_jaffa_red_serpent_guard_closed", "sga_jaffa_red_serpent_guard_open"],
                ["SG_DeathGlider_heli"],["SG_gouald_drone"]
            ],
            [ "sga_bratac", [ "sga_lucian_carry", "sga_jaffa_free", "sga_lucian_carry" ],
                [ "sga_osiris_cruiser" ], ["SG_gouald_drone"]
            ],
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
        (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_wait_for_clustering.sqf";
        _sobj set ["Mission Select", "sequential"];

        // total missions to run
        _sobj set ["Total Missions", 1];

        ["initialization complete"] call (_sobj get "_log");
     };

    case "mission_completed": {
        ["Mission Complete"] call (_sobj get "_log");
        if (((_sobj get "Scenario State") == 1) && ((_sobj get "Total Missions") == 0)) then {
            _sobj set ["Scenario State", 2];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List",  []]; 
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_rescue_scp.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_interview.sqf";
            _sobj set ["Total Missions", selectRandom [1, 2]];
            _sobj set ["Mission Select", "random"];
        }; 
        if (((_sobj get "Scenario State") == 2) && ((_sobj get "Total Missions") == 0)) then {
            _sobj set ["Scenario State", 3];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List",  []]; 
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_alien_hunt.sqf";
            _sobj set ["Total Missions", 1];
            _sobj set ["Mission Select", "random"];
        }; 
        if (((_sobj get "Scenario State") == 3) && ((_sobj get "Total Missions") == 0)) then {
            _sobj set ["Scenario State", 4];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List",  []]; 
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_alien_spawner.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_exfil.sqf";
            _sobj set ["Total Missions", 2];
            _sobj set ["Mission Select", "sequential"];
        }; 
    };
};

