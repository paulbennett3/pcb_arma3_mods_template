//
//  called by "addAction" on sgc_briefing
// uses pcb_mission_complete flag, pcb_mission_list
params ["_target", "_caller", "_actionId", "_arguments"];

hint "dispatch mission";

// are we in the middle of a mission?
if (pcb_mission_complete) then {
    // clean up from previous mission (delete triggers and spawned stuff, except gate complexes)
   [] call compile preprocessFile "scripts\pcb_delete_spawned_stuff.sqf";       

   // dispatch a mission from our list
   private _mission = selectRandom pcb_mission_list; 
   private _mission_name = _mission select 0;
   private _mission_repeatable = _mission select 1;
   if (not _mission_repeatable) then {
       pcb_mission_list deleteAt (pcb_mission_list find _mission);
       publicVariable "pcb_mission_list";
   };

   _mission_name = ("mission_scripts\" + _mission_name) + ".sqf";
   [] call compile preprocessFile _mission_name;
};
