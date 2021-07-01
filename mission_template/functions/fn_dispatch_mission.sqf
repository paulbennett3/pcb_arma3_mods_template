//
//  called by "addAction" on sgc_briefing
// uses pcb_mission_complete flag
//
// To add a mission:
//    define it in missions/fn_<mission name>.sqf
//    add it as a class in Descriptions.ext as class <mission name>
//    add the string name to _mission_list in this file
//    add a case block for it in the switch in this file              
params ["_target", "_caller", "_actionId", "_arguments"];

// are we in the middle of a mission?
if (pcb_mission_complete) then {
    // clean up from previous mission (delete triggers and spawned stuff, except gate complexes)
   [] call pcb_fnc_delete_spawned_stuff;       

   // dispatch a mission from our list
   // !!! add these when you create them -- also add to Description.ext so they are compiled!!!
   //private _mission_list = [ "explore", "resupply" ];
   private _mission_list = [ "explore" ];

   private _mission = selectRandom _mission_list; 

   // note -- for "unique" missions, in the case statement remove the mission name from _mission_list!
   switch (_mission) do {
       case "explore": { [] call pcb_fnc_explore; };
       case "resupply": { [] call pcb_fnc_resupply; };
   };
};
