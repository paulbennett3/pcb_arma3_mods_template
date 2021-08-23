/* *******************************************************************
                      mis_generator

Top level -- used to generate the sequence of missions and chain them
together.
******************************************************************* */
if (! isServer) exitWith {};

[] spawn {
    sleep .1;

    ["Mission Generator spawned"] call pcb_fnc_debug;

    // start our mission counter and mission array
    mission_success = true; // assume true, set to false if failed ...
    publicVariable "mission_success";
    mission_active = false; // set to true when mission created.  Mission sets it to false when completed.
    publicVariable "mission_active";

    // ------------------------------------------------------
    // wait for types_hash to be parsed and loaded
    // ------------------------------------------------------
    waitUntil { sleep 1; ! isNil "types_hash_loaded" };
    waitUntil { sleep 1; types_hash_loaded };

    // --------------------------------------------------------
    // use the default scenario to initialize our methods etc
    // --------------------------------------------------------
    private _defaults = compile preprocessFileLineNumbers "functions\scenarios\fn_scn_defaults.sqf";
    private _sobj = [] call _defaults;

     // Make a list of possible scenarios to run
    _sobj set ["Scenarios", []];
    (_sobj get "Scenarios") pushBackUnique "functions\scenarios\fn_scn_zombies.sqf";
    (_sobj get "Scenarios") pushBackUnique "functions\scenarios\fn_scn_occult.sqf";
    (_sobj get "Scenarios") pushBackUnique "functions\scenarios\fn_scn_aliens.sqf";

    // pick a scenario to run at random from our list, and compile it
    _sobj set ["Scenario Name", selectRandom (_sobj get "Scenarios")];
    _sobj set ["Scenario", compile preprocessFileLineNumbers (_sobj get "Scenario Name")];

    // Let the scenario do its stuff to prepare (override methods and types_hash stuff)
    [_sobj, "create"] call (_sobj get "Scenario");

    // do the actual initialization method calls
    [_sobj] call (_sobj get "_init");

    // start our mission loop
    private _missions_done = false;
    private _first_mission = true;
    while { sleep 1; !isNil "_missions_done" && {! _missions_done } } do {
        waitUntil { sleep 1; !isNil "mission_active" && { ! mission_active } };        

        // we should do any cleanup using the state returned from mission start
        //    and stored by mission ID in active_mission_info hash ....
        if (! _first_mission) then {
            // Since some missions mess up the rating (possibly not the players fault!),
            //   we reset their ratings here
            {
                [2000, _x] call pcb_fnc_set_rating;    
            } forEach playableUnits;
   
            // need a way to do mission cleanup -- there is "obj_list" et al
            // in the state, and we have state stored keyed under UID in active_misson_info,
            //  but we haven't tied *which* mission ended to UID ... so we don't
            //  know which state to clean up ...

            // call our scenario to allow it to manipulate total_missions, mission_list
            [_sobj, "mission_completed"] call (_sobj get "Scenario"); 
        };

        // do we have any missions left to run?
        if ((_sobj get "Total Missions") > 0) then {
            _sobj set ["Total Missions", (_sobj get "Total Missions") - 1];
            
            // select one from our list
            private _mission = "";
            if ((_sobj get "Mission Select") isEqualTo "random") then {
                _mission = selectRandom (_sobj get "Mission List");
            } else {
                _mission = (_sobj get "Mission List") deleteAt 0;
            };
            
            // make an ID for it
            private _UID = "MID" + (str ([] call pcb_fnc_get_next_UID));
            
            // execute the mission, and store any state for "later"
            ["Executing mission <" + (str _mission) + ">"] call pcb_fnc_debug;
            private _result = [_sobj, _UID] call compile preprocessFileLineNumbers _mission;
            private _started_ok = _result select 0;
            private _state = _result select 1;

            if (! _started_ok) then {
                // d'oh! Something went wrong, bump up the number so we try again ...
["Oops -- mission creation failed"] call pcb_fnc_debug;
                _sobj set ["Total Missions", (_sobj get "Total Missions") + 1];
            } else {
               _first_mission = false;
               mission_active = true;
               publicVariable "mission_active";
            };
        } else {
            // done!
            _missions_done = true;
            "EveryoneWON" call BIS_fnc_endMissionServer;
        };
    };
};
