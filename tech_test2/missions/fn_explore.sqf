private _return = "Exploring";  // should always have a return value ...

// #################################################
// pick an area to put our stargate in
// should be well away from SGC and other stargates ...
private _gate_loc_dir = [] call pcb_fnc_random_stargate_position;

private _loc = _gate_loc_dir select 0;
private _dir = _gate_loc_dir select 1;

private _gate = [_loc, _dir] call pcb_fnc_place_stargate;
gate_name = _gate getVariable "customname";

// #################################################


/* ----------------------------------------------------------------
                       Mission Tasking
---------------------------------------------------------------- */
task_name = "T0" + str pcb_task_count;
pcb_task_count = pcb_task_count + 1;
publicVariable "pcb_task_count";
gate = _gate;

[] spawn {
    [  true,
       task_name,
       [
           ("Explore " + gate_name) + " and find THING",
           "Explore " + gate_name,
           ""
       ],
       objNull,
       "ASSIGNED",
       -1,
       true
    ] call BIS_fnc_taskCreate;
};


/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                         Mission Environment
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
/* set these using trigger on gate side?
skipTime (random 12);  // ie, skip time a random number of hours between 0 and 12
transitionTimeSeconds setFog [fogValue 0 to 1, fogDecay -1 to 1, fogBase -5k to 5k];
transitionTimeSeconds setRain rainNumber 0 to 1;
trainsitionTimeSeconds setOvercast overcastValue 0 to 1;
!!! only one weather change at a time can be active -- so spawn sleep to next one?

set marker to find?
*/
//private _activation = "skipTime random 12; 0 setRain 1.0;";
private _activation = "hint 'wub';";

// set trigger for mission stuff once through gate 
private _trg = createTrigger ["EmptyDetector", _loc];
_trg setTriggerArea [10, 10, 0, false, 5];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trg setTriggerStatements [
                              "this",
                              _activation,
                              ""
                          ];

// remember to delete this trigger when done with it
pcb_spawned_stuff append [_trg];

// broadcast our updated variables
publicVariable "pcb_spawned_stuff";

_return
