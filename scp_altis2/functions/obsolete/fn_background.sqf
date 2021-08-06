/* --------------------------------------------------------------------
                          background

Setup (and spawn if needed) the "background" -- what is going on
besides / in addition to the mission(s)


!!! Uses start_pos, "mACTIVE"
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

waitUntil { ! isNil "random_start_ready" };
waitUntil { ! isNil "start_pos" };
waitUntil { ! isNil "start_dir" };
waitUntil { ! isNil "active_area" };


/* ########################################################
                    Background 

######################################################## */
[active_area] spawn {
    params ["_active_area"];

    sleep 10;

    // -----------------------------------------------
    // generate a random number of "spare" vehicles 
    // -----------------------------------------------
    [_active_area, _buildings] spawn {
        params ["_active_area", "_buildings"];
        [_active_area, _buildings] call pcb_fnc_spawn_spare_vehicles;
    };

    // -----------------------------------------------
    // generate "spare" helicopters
    // -----------------------------------------------
    [] spawn {
        [] call pcb_fnc_spawn_spare_helicopters;
    };

    // -----------------------------------------------
    // "populate" cities
    // -----------------------------------------------
/*
    [_active_area] spawn {
        params ["_active_area"];
        [_active_area] call pcb_fnc_populate_cities;
    };
*/

};

