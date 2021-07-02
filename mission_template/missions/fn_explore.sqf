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
// used for tracking the number of items studied 
pcb_explored_count = 0;
publicVariable "pcb_explored_count";

task_name = "T0" + str pcb_task_count;
pcb_task_count = pcb_task_count + 1;
publicVariable "pcb_task_count";
gate = _gate;

private _thing_list = [
    ["Atlantis_pillars", "the Alien Pillar"],
    ["Land_Grave_obelisk_F", "the Obelisk"],
    ["Land_Maroula_F", "the Statue"],
    ["Land_PalmTotem_01_F", "the Totem"],
    ["Land_PalmTotem_02_F", "the Totem"],
    ["WL_EYE_TRANSPORTER", "the Alien Pillar"],
    ["WL_Quantum_Mirror_bush", "the Stone Mirror"],
    ["DSA_Idol", "the Statue"],
    ["DSA_Idol2", "the Statue"],
    ["sga_stones", "the stone ring"],
    ["SGA_BW_Pillar_StoneGreyDark", "the Pillar"]
];

private _thing = selectRandom _thing_list;
thing_name = _thing select 1;
private _obj_str = _thing select 0;
thing_loc = [_loc, 100, 500, 10, 0, 0.1, 0] call BIS_fnc_findSafePos;
_obj = createVehicle [_obj_str, thing_loc, [], 0, "NONE"];
[
  _obj, 
  "study", 
  { pcb_explored_count = pcb_explored_count + 1; publicVariable 'pcb_explored_count';},
  30
] call pcb_fnc_add_interact_action_to_object;

[] spawn {
    [  true,
       task_name,
       [
           (("Explore " + gate_name) + " and find ") + thing_name,
           "Explore " + gate_name,
           ""
       ],
       objNull,
       "ASSIGNED",
       -1,
       true
    ] call BIS_fnc_taskCreate;
};

// set trigger for ending mission
private _end_activation = "pcb_mission_complete = true; publicVariable 'pcb_mission_complete'; ";
_end_activation = _end_activation + "[] spawn {[task_name, 'SUCCEEDED'] call BIS_fnc_taskSetState;};";

private _trg_e = createTrigger ["EmptyDetector", _loc];
_trg_e setTriggerArea [5, 5, 0, false, 5];
_trg_e setTriggerActivation ["NONE", "", false];
_trg_e setTriggerStatements [
                              "pcb_explored_count > 0",
                              _end_activation,
                              ""
                            ];


// add some randomness for our objective marker
private _thing_loc_area = [thing_loc, 50] call BIS_fnc_getArea;
thing_loc =  [ [_thing_loc_area], []] call BIS_fnc_randomPos;


/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                         Mission Environment
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
private _activation = "[] spawn { [task_name, thing_loc] call BIS_fnc_taskSetDestination; }; ";

// change the environment slightly ...
//private _env = selectRandom ["time", "fog", "rain", "overcast", "none"];
private _env = selectRandom ["time", "fog", "rain"];
switch (_env) do {
    case "time": { _activation = _activation + "skipTime (random 24); "; };
    case "fog": { _activation = _activation + "0 setFog [random 1, 0, 500]; "; };
    case "rain": { _activation = _activation + "0 setRain 1; "; };
    case "overcast": { _activation = _activation + "0 setOvercast 1; "; };
    case "none": { };
};


// set trigger for setting up mission stuff once through gate 
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

pcb_mission_complete = false;

// broadcast our updated variables
publicVariable "pcb_spawned_stuff";
publicVariable "pcb_mission_complete";

_return
