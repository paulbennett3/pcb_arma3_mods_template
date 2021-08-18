/* ------------------------------------------------------------
               server state handler

Used for handling messages from remote users (players) for
things like packing/unpacking bases etc
------------------------------------------------------------ */

if (! isServer) exitWith {};

// for UIDs 
next_UID = 0;
publicVariable "next_UID";

// for tracking various states
state_tracker = createHashMap;
state_tracker set ["simple_tasks", createHashMap];
publicVariable "state_tracker";

// for messages from clients
message_box = [];
publicVariable "message_box";

// set up a task to monitor remote activity
[] spawn {
   if (! isServer) exitWith {};

   while { true } do {
       sleep 1;
       // if ((count message_box) > 0) then {
       waitUntil { sleep 1; (count message_box) > 0};  // suspends script until condition true
       if (true) then {
           private _msg = message_box deleteAt 0;
           publicVariable "message_box";
["Server State Manager processing <" + (str _msg) + ">"] call pcb_fnc_debug;

           private _msg_type = _msg select 0;

           switch (_msg_type) do {
               case "pck": {
                   private _target = _msg select 1;
                   [_target] call pcb_fnc_packable_base;
               };
               case "pck_boat": {
                   private _target = _msg select 1;
                   [_target] call pcb_fnc_packable_boat;
               };
               case "respawn_ai": {
                   private _id = _msg select 1;
                   private _unit = scp_support_unit_tracker get _id;

                   if ((! isNull _unit) && { alive _unit }) exitWith {}; 
                   if ((! isNull _unit) && { _unit in playableUnits}) exitWith {};
                   
                   [_id, _unit] spawn {
                       params ["_id", "_unit"];
                       sleep 30;
                       if (! (isNull _unit)) then { deleteVehicle _unit; };
                       sleep 30; 
                       ["respawn ai called for unit <" + (str _id) + ">"] call pcb_fnc_debug;
                       [_id] remoteExec ["pcb_fnc_scp_new_unit", groupOwner player_group];
                   };
               };

               case "simple_task": {
                   private _taskID = _msg select 1;
                   private _state = _msg select 2;

                   if (_state isEqualTo "ASSIGNED") then {
                       private _temp = state_tracker get "simple_tasks";
                       private _trg = _msg select 3;
                       _temp set [_taskID, ["ASSIGNED", _trg]];
                       if ((typeName _taskID) isEqualTo "ARRAY") then {
                           private _pid = _taskID select 1; // parent ID
                           private _count = _temp getOrDefault [_pid, 0];
                           _temp set [_pid, _count + 1];
                       };
                   } else {
                       private _temp = state_tracker get "simple_tasks";

                       // child tasks will be an array [childID, parentID]
                       if ((typeName _taskID) isEqualTo "ARRAY") then {
                           private _tid = _taskID select 0; // child ID
                           private _info = _temp get _taskID;
                           private _trg = _info select 1;

                           // delete trigger
                           deleteVehicle _trg; 

                           // delete the task
                           [_tid, true] call BIS_fnc_deleteTask;
 
                           // clear the entry
                           _temp deleteAt _taskID;

                           // update parent
                           private _pid = _taskID select 1; // child ID
                           private _count = _temp getOrDefault [_pid, 0];
                           _count = _count - 1;
                           if (_count <= 0) then {
                               [_pid, true] call BIS_fnc_deleteTask;
                               _temp deleteAt _pid;
                           } else {
                               _temp set [_pid, _count];
                           }; 
                       } else {
                           // just a task with no subtasks
                           [_taskID, true] call BIS_fnc_deleteTask;
                           _temp deleteAt _taskID;
                       };
                   };
               };

               case "mission_callback": {
                   // used by missions to ensure callback is called by server
                   private _callback_name = _msg select 1;
                   private _callback_args = _msg select 2;
                   _callback_args call compile preprocessFile _callback_name;
               };

           };
       };
   };
};
