/* ********************************************
                 spawn_packable_base

Create an (un)packable base / repair depot / etc

_pos -- where to put it (ATL)
_dir -- orientation of new object
_type string -- which type of item packing/unpacking
_packed bool -  true = spawn packed, else spawn unpacked


Example:
  ["base", getPosATL player, getDir player, true] call pcb_fnc_spawn_packable_base;

trigger
["base", getPosWorld spawn_target, getDir spawn_target, true] call pcb_fnc_spawn_packable_base;

init of object
[this, ["B_Slingload_01_Repair_F", "Land_RepairDepot_01_green_F", 0], "Unpack"] call pcb_fnc_addAction_packable;
******************************************** */
params ["_type", "_pos", "_dir", "_packed"];

// only run on server!
if (! isServer) exitWith {};

// [packed_type, unpacked_type, rotation needed], ...
//    ["Land_Cargo20_military_green_F",  "Land_Cargo_House_V1_F"],
private _types = [
    // 0  Medium Cargo Container, Cargo "House"
    ["B_Slingload_01_Ammo_F",  "Land_Cargo_House_V1_F", 90],       // base
    // 1  repair "box", repair depot
    ["B_Slingload_01_Repair_F", "Land_RepairDepot_01_green_F", 0]  // repair
];

private _packed_unpacked_rot = objNull;
private _act = objNull;
private _spawn_type = objNull;

switch (_type) do
{
    case "base": {
            _packed_unpacked_rot = _types select 0;
        };
    case "repair": {
            _packed_unpacked_rot = _types select 1;
        };
};

_spawn_type = _packed_unpacked_rot select 0;
_act = "Unpack";

// create our object
private _obj = createVehicle [_spawn_type, [0,0,0], [], 0, "NONE"];
[_obj, _pos] call pcb_fnc_setPosAGLS;
_obj setDir _dir;

[_obj] spawn {
   params ["_obj"];
   sleep 5;
   _obj setDamage 0;
};

// add an action to our new object to pack/unpack
[_obj, _packed_unpacked_rot, _act] call pcb_fnc_addAction_packable;
