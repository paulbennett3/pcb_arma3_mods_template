// Given a location, set a trigger to cause the
//  troops to teleport there
// Returns the newly created trigger
params ["_obj"];

// set trigger to summon squad
private _trg = createTrigger ["EmptyDetector", getPosATL _obj];
_trg setTriggerArea [10, 10, 0, false, 5];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trg setTriggerStatements ["this", 
                           "[getPosATL thisTrigger] call compile preprocessFile 'scripts\pcb_summon_squad.sqf';",
                           ""];

// remember to delete this trigger when done with it
pcb_spawned_stuff append [_trg];

// broadcast our updated variables 
publicVariable "pcb_spawned_stuff";

_trg;
