// deletes any spawned stuff after a mission
// uses the public variable array pcb_spawned_stuff

{
    deleteVehicle _x;
} forEach pcb_spawned_stuff;

pcb_spawned_stuff = [];

// broadcast we did garbage collection ...
publicVariable "pcb_spawned_stuff";
