/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */

if (! isServer) exitWith {};

group_list = [];

[] spawn {
   private _code = {
       private _group = createGroup west;
       group_list pushBackUnique _group;
       private _pos = getPosATL (playableUnits select 0);
       private _veh1 = _group createUnit ["B_Soldier_A_F", _pos, [], 5, "NONE"];
       private _veh2 = _group createUnit ["B_Soldier_A_F", _pos, [], 5, "NONE"];
       private _veh3 = _group createUnit ["B_Soldier_A_F", _pos, [], 5, "NONE"];
   };

   ["Spawning groups"] remoteExec ["systemChat", 0];
   [] call _code;
   [] call _code;
   [] call _code;
   sleep 10;
   ["before " + (str group_list)] remoteExec ["systemChat", 0];
   group_list = [group_list, 5000] call compile preprocessFileLineNumbers "fn_group_garbage_collect.sqf";
   ["after " + (str group_list)] remoteExec ["systemChat", 0];
   (units (group_list select 1)) apply { deleteVehicle _x };
   sleep 10;
   group_list = [group_list, 5000] call compile preprocessFileLineNumbers "fn_group_garbage_collect.sqf";
   ["after after" + (str group_list)] remoteExec ["systemChat", 0];
   sleep 10;
   group_list = [group_list, 0] call compile preprocessFileLineNumbers "fn_group_garbage_collect.sqf";
   ["after after 2" + (str group_list)] remoteExec ["systemChat", 0];
   ["<" + (units objNull) + ">"] remoteExec ["systemChat", 0];
};
