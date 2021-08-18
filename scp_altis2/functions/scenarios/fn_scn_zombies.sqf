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
    _obj (hashMap) : reference to our scenario object global
    _action (string) : which state we are in when called
          States are:
              "create" : initialize mission_list, total_missions, start_pos,
                         setup base camp etc
              "mission_completed" : called after a mission is completed, but
                         before the next mission.  Use this to reset the
                         mission_list if appropriate


******************************************************************* */
params ["_sobj", "_action"];

_sobj set ["Name", "Zombies!"];

switch (_action) do {
    case "create": {
        ["create"] call (_sobj get "_log");

        // test and set flag so only one scenario can be run
        if (! isNil "scenarioCreated") exitWith {};
        scenario_created = true;
        publicVariable "scenario_created";

        // over-ride defaults in fn_types / types_hash
        types_hash set ["zombies", types_hash get "zombies_ryan"];
        types_hash set ["weaker spooks", types_hash get "zombies_ryan"];
        types_hash set ["spooks", types_hash get "zombies_ryan"];
        types_hash set ["background_options_with_weights", types_hash get "zombies_options_with_weights"];

        private _decorate = {
            params ["_pos", ["_building", objNull]];
            private _pos2d = [_pos select 0, _pos select 1];
            private _blood = (types_hash get "blood");
            private _n = 5 + (ceil (random 10));
            private _io = 0;
            for [{_io = 0 }, {_io < _n}, {_io = _io + 1}] do {
                private _type = selectRandom _blood;
                private _veh = createVehicle [_type, _pos2d, [], 5, 'CAN_COLLIDE'];
                _veh setDir (random 360);
                _veh setPos getPos _veh;
            };
        };
        _sobj set ["Decorate", _decorate];

        private _mission_enc = {
            params ["_pos", ["_chance", 50], ["_max_n", 20]];

            private _obj_list = [];
            private _type = objNull;
            private _n = 1 + (floor (random _max_n));
            private _did = false;

            // chance of encounter
            if ((random 100) < _chance) then {
                _did = true;
                private _types = types_hash get "zombies";
                private _ctypes = [];
                private _i = 0;
                for [{}, {_i < _n}, {_i = _i + 1}] do {
                    _ctypes pushBack (selectRandom _types);
                };
                [_ctypes, _pos, east, false] call pcb_fnc_spawn_squad;
            };

            [_obj_list, _type, _n, _did]
        };
        _sobj set ["Mission Encounter", _mission_enc];

        // subset civilians
        private _civ_temp = (types_hash get "civilians") select { (random 100) < 10 };
        _civ_temp = _civ_temp + (types_hash get "civ infected");
        types_hash set ["civilians", _civ_temp];
 
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
            _sobj set ["Mission List", []]; 
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_interview.sqf";
            _sobj set ["Total Missions", selectRandom [1, 2]];
            _sobj set ["Mission Select", "random"];
        }; 
        if (((_sobj get "Scenario State") == 2) && ((_sobj get "Total Missions") == 0)) then {

            _sobj set ["Scenario State", 3];

            // update our mission list (what we can choose from)
            _sobj set ["Mission List", []]; 
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_zombie_hunt.sqf";

            _sobj set ["Total Missions", 2];
            _sobj set ["Mission Select", "random"];
        }; 
        if (((_sobj get "Scenario State") == 3) && ((_sobj get "Total Missions") == 0)) then {

            _sobj set ["Scenario State", 4];

            // update our mission list (what we can choose from)
            // remember to do these in reverse order!!! 
            _sobj set ["Mission List", []]; 
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_spawner.sqf";
            (_sobj get "Mission List") pushBackUnique "functions\missions\fn_mis_exfil.sqf";
            _sobj set ["Total Missions", count (scenario_object get "Mission List")];
            _sobj set ["Mission Select", "sequential"];
        }; 
    };
};

