/* *******************************************************************
                      mis_generator

Top level -- used to generate the sequence of missions and chain them
together.
******************************************************************* */
if (! isServer) exitWith {};

[] spawn {
    diag_log "Mission Generator spawned";
    hint "Mission Generator started (spawned)";

    // start our mission counter and mission array
    mission_active = false; // set to true when mission created.  Mission sets it to false when completed.
    publicVariable "mission_active";

    active_mission_info = createHashMap;  // index with "mission ID" -- for state needed for cleanup, or complex missions

    // fire off the director for tracking background stuff
    [] call pcb_fnc_director;

    // call our scenario to populate mission_list, total_missions, generate start base, etc
    private _scenarios = [];
    _scenarios pushBackUnique "functions\scenarios\fn_scn_zombies.sqf";
    //_scenarios pushBackUnique "functions\scenarios\fn_scn_drongo.sqf";

    private _scenario = compile preprocessFileLineNumbers (selectRandom _scenarios);

    ["create"] call _scenario; 
    waitUntil { sleep 1; !isNil "total_missions" };        

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
            ["mission_completed"] call _scenario; 
        } else {
            _first_mission = false;
        };

        // do we have any missions left to run?
        if (total_missions > 0) then {
            total_missions = total_missions - 1;
            publicVariable "total_missions";
            
            // select one from our list
            private _mission = selectRandom mission_list;
            
            // make an ID for it
            private _UID = "MID" + (str ([] call pcb_fnc_get_next_UID));
            
            // execute the mission, and store any state for "later"
            private _result = [_UID] call compile preprocessFileLineNumbers _mission;
            private _started_ok = _result select 0;
            private _state = _result select 1;
            active_mission_info set [_UID, _state];

            if (! _started_ok) then {
                // d'oh! Something went wrong, bump up the number so we try again ...
                total_missions = total_missions + 1;
                publicVariable "total_missions";
            } else {
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
