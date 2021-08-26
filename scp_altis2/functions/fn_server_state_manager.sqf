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

    private _my_mutex_id = "server_state_manager";
    if (isNil "server_mail_mutex") then {
        server_mail_mutex = ["create", _my_mutex_id] call pcb_fnc_mutex;
        publicVariable "server_mail_mutex";
    };
    waitUntil { ! isNil "server_mail_mutex"; };

   while { sleep 0.1; true } do {
       waitUntil { sleep 0.1; (count message_box) > 0};  // suspends script until condition true
       ["get", _my_mutex_id, server_mail_mutex] call pcb_fnc_mutex;
       private _msg = message_box deleteAt 0;
       publicVariable "message_box";
       ["release", _my_mutex_id, server_mail_mutex] call pcb_fnc_mutex;
["Server State processing " + (str _msg)] call pcb_fnc_debug;
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

       }; // switch
   }; // while
}; // spawn

// Set up a handler for chat messages (resupply et al)
addMissionEventHandler ["HandleChatMessage", {
    params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", 
            "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType"];
    // format "resupply XXX at YYY"
    ///   where XXX is in ["medical", "ammo", "support"]
    ///         YYY is grid reference
    ///    example:
    //      resupply ammo at 120101

    private _mode = "";
    private _temp = toLowerANSI _text;
    if ("resupply ammo" in _temp) then { _mode = "ammo"; };
    if ("resupply support" in _temp) then { _mode = "support"; };
    if ("resupply medical" in _temp) then { _mode = "medical"; };
    
    if (! (_mode isEqualTo "")) then {
        private _fields = _temp splitString " ";
        private _grid = _fields select 3;
        // returns [[x, y], [width, height]]
        private _pos_gsize = _grid call BIS_fnc_gridToPos;  
        private _pos = _pos_gsize select 0;
        private _gsize = _pos_gsize select 1;

        // if there isn't smoke, we use the center of the grid as a target, and large dispersion
        private _pos = [(_pos select 0) + ((_gsize select 0)/2), 
                        (_pos select 1) + ((_gsize select 1)/2)]; 
        // figure out who is calling for it, and what their position is
        private _units = playableUnits select { ((owner _x) == _owner) && { isPlayer _x} };
        if ((count _units) == 1) then {
            private _unit = _units select 0;
            private _pos = getPosATL _unit;
            private _delay = selectRandom [30, 60, 60, 60, 90]; 
            private _str = "Roger that, " + _name + ", sending " + _mode + " to " + 
                           _grid + ", pop smoke in " + (str _delay) + " seconds";
            [_str] remoteExec ["systemChat", 0];
            _delay = _delay + 10;

            private _crate = objNull;
            switch (_mode) do {
                case "ammo": { 
                    _crate = "B_supplyCrate_F" createVehicle [0, 0, 0];
                };
                case "medical": { 
                    _crate = "ACE_medicalSupplyCrate_advanced" createVehicle [0, 0, 0];
                };
                case "support": { 
                    _crate = "ACE_Box_Misc" createVehicle [0, 0, 0];
                };
            };

            private _dispersion = 300;
            [_unit, _pos, _crate, _dispersion, _name, _mode, _delay] spawn {
                params ["_unit", "_pos", "_crate", "_dispersion", "_name", "_mode", "_delay"];
                sleep _delay;
                // is there smoke in the grid reference?
                private _objects = (_pos nearObjects 300) select { "smoke" in (toLowerANSI (typeOf _x)) };
                if ((! (isNil "_objects")) && ((count _objects > 0))) then {
                    [_name + " pilot sees your smoke and " + _mode + " inbound on target"] remoteExec ["systemChat", 0];
                    _pos = getPosATL (_objects select 0);
                    _dispersion = 5 + (random 10);
                } else {
                    [_name + " pilot reports no smoke seen, but " + _mode + " dropping"] remoteExec ["systemChat", 0];
                };

                [_unit, _pos, _crate, _dispersion] call pcb_fnc_paradrop_stuff;       
            };
        };
    };
}];
