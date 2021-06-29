// Given a position and direction (rotation), generate
//  a stargate and place, returning the gate created
params ["_loc", "_dir"];

// create steps
private _steps = "sga_steps_a" createVehicle _loc; 
_steps setDir _dir; 
private _steps_loc = getPosATL _steps;

// create gate
private _gate = "sga_gate_orbital" createVehicle _steps_loc; 
_gate setDir _dir;
_steps attachTo [_gate, [0, 0, -0.75]];

// grab a gate name from our unused list
//private _name = selectRandom pcb_stargate_gate_names_unused;
// generate a random "stargate name"
private _name = call compile preprocessFile "scripts\pcb_random_stargate_name.sqf";

_gate setVariable ["customname", _name, true]; 

// create DHD
private _dhd_loc = _steps getRelPos [8, 135]; 
private _dhd = "sga_dhd_simple" createVehicle _dhd_loc; 

// create gate settings module
//private _gate_settings = "sga_gate_settings_module" createVehicle _loc; 

// synch gate and DHD
_gate synchronizeObjectsAdd [_dhd];

// set trigger to summon squad
private _trg = createTrigger ["EmptyDetector", _steps_loc];
_trg setTriggerArea [10, 10, 0, false, 5];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trg setTriggerStatements ["this", 
                           "[getPosATL thisTrigger] call compile preprocessFile 'scripts\pcb_summon_squad.sqf';",
                           ""];

// remember to delete this trigger when done with it
pcb_spawned_stuff append [_trg];

// broadcast our updated variables 
publicVariable "pcb_stargate_markers_used";
publicVariable "pcb_stargate_markers_unused";
publicVariable "pcb_spawned_stuff";

_gate;
