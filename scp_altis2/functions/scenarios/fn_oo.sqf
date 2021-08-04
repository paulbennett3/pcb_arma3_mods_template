/* ********************************************************
                   oo base


private _base = createHashMapFromArray [
    ["x", y]
];

message dispatch, inheritance

Want "base" scenario:
   
        // adjust start position if desired
        [] call pcb_fnc_random_start_pos;

        // start spawning spare vehicles etc
        [] call pcb_fnc_background;
 
        // manipulate the starting weather et al
        [] call pcb_fnc_set_mission_environment;

        // create the "base camp" + spawning point
        [] call pcb_fnc_start_base_setup;

        // not sure how to do this ...
        // set up "do_director_spawn" and
        //  populate cities (and bases),
        //  spare vehicles
        //  spare helis
        //  ...

Init
mission complete / generate next mission

functions:
   _result = [obj, msg, args] call pcb_fnc_oo  <- "send message to obj"
   _obj = [name, args, [parents]] call pcb_fnc_oo_new

Dispatch:
   Does _obj have "msg" in a field? call it, passing args
   If not, for each parent (last in array to first), check for
     msg -- call first one found and return
    ie, given parents of [p1, p2, p3], p3 is checked first, 
          then p2, then p1.
    If msg not found, return objNull
******************************************************** */

