/* ---------------------------------------------------------------------
                     start base setup 2

--------------------------------------------------------------------- */

//["start base being made, please be patient ..." + (str (isServer))] call pcb_fnc_debug;
["start_pos <" + (str start_pos) + ">"] call pcb_fnc_debug;
if (! isServer) exitWith {};

player_group = group (playableUnits select 0);
publicVariable "player_group";

// ------------------------------------------------------------------
// move everybody to the start position
// ------------------------------------------------------------------
["teleporting to start base area  ..."] call pcb_fnc_debug;
private _id = 0;
private _unitslist = units player_group;
for [{_id = 0}, {_id < (count (_unitslist))}, {_id = _id + 1}] do {
    private _x = _unitslist select _id;
    _x setVehiclePosition [start_pos, [], 5, "NONE"];
    [_x, _id] call pcb_fnc_enable_ai_respawn;
    [_x] call pcb_fnc_set_scp_loadout;
    sleep .1;
}; // forEach units (group (playableUnits select 0));

["You should be there  ..."] call pcb_fnc_debug;

sleep .1;

// ------------------------------------------------------------------
// Spawn the support squad
// ------------------------------------------------------------------
[getPosATL (playableUnits select 0), player_group] call pcb_fnc_spawn_support_units;

// figure out position along the line of the runway
private _offset = 15; 
private _next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;

// ------------------------------------------------------------------
// Create a task for finding all the starting equipment
// ------------------------------------------------------------------
private _pid = "T" + str ([] call pcb_fnc_get_next_UID);
[
    true,
    _pid,
    [
        "Locate the equipment scattered during infiltration",
        "Locate Gear",
        "foo"
    ],
    start_pos,
    "ASSIGNED"
] call BIS_fnc_taskCreate;

// ------------------------------------------------------------------
// Spawn an equipment crate ("unpacked") with attached base,
//   then spawn a "packed" create, and connect them to make them
//   swappable
// ------------------------------------------------------------------
// select a position
private _crate_type = "B_Slingload_01_Cargo_F";
_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;
private _vpos = _next_pos;
["Putting crate at <" + (str _vpos) + ">"] call pcb_fnc_debug;

private _start_crate = _crate_type createVehicle _vpos;
_start_crate setDir start_dir;
_start_crate setPosASL getPosASL _start_crate;  // synch for MP
[_start_crate, "crate"] call pcb_fnc_crate_loadout;


// ------------------------------------------------------------------
// make a nice little base encampment relative to crate
// ------------------------------------------------------------------
private _attachIt = {
    params ["_target", "_type", "_pos", "_rot"];
    private _thing = _type createVehicle [0,0,0];
    _thing attachTo [_target, _pos]; _thing setDir _rot; _thing setPosASL getPosASL _thing;
    _thing
};

private _dir = (getDir _start_crate) - 90;
if (_dir < 0) then { _dir = _dir + 360; };
private _desk_pos = _start_crate getPos [5, _dir];

private _desk = "Land_PortableDesk_01_black_F" createVehicle _desk_pos;
[_desk, 1 + (ceil (random 5))] call pcb_fnc_loot_crate;
_desk setDir _dir;
_desk setPosASL getPosASL _desk;
[_desk, "Land_DeskChair_01_black_F", [.8,1,-.25], 15] call _attachIt;
[_desk, "Land_DeskChair_01_black_F", [-.5, .75, -.25], 15] call _attachIt;
private _cabinet = [_desk, "Land_PortableCabinet_01_bookcase_black_F", [1.5, 1, -.05], 110] call _attachIt;
[_cabinet, 1 + (ceil (random 5))] call pcb_fnc_loot_crate;
[_desk, "Land_PortableCabinet_01_lid_black_F", [2.2, 1.3, -.35], 72] call _attachIt;
[_desk, "Land_Laptop_device_F", [0, 0, .6], 25] call _attachIt;
[_desk, "Land_File1_F", [1.05, 0, .45], 165] call _attachIt;
[_desk, "Land_File2_F", [.95, .05, .45], 145] call _attachIt;
[_desk, "Land_Tablet_01_F", [.65, -.15, .45], 27] call _attachIt;
[_desk, "Land_PortableLight_double_F", [7, -.5, 0.6], 115] call _attachIt;
private _tent_type_rot = selectRandom (types_hash get "bases");
private _tent_type = _tent_type_rot select 0; private _tent_rot = _tent_type_rot select 1; _tent_offset_z = _tent_type_rot select 2;
[_desk, _tent_type, [2, 2, _tent_offset_z], _tent_rot] call _attachIt;
[_desk, "B_CargoNet_01_ammo_F", [5, 10, 0.4], 45 + (random 90)] call _attachIt;
[_desk, "B_CargoNet_01_ammo_F", [0, 10, 0.4], 45 + (random 90)] call _attachIt;
[_desk, "B_CargoNet_01_ammo_F", [-5, 10, 0.4], 45 + (random 90)] call _attachIt;
[_desk, "CUP_BOX_US_ARMY_WpsLaunch_F", [-8, 10, .7], 45 + (random 90)] call _attachIt;
[_desk, "Box_NATO_WpsLaunch_F", [-9, 10, 0.0], 45 + (random 90)] call _attachIt;
_cabinet = [_desk, "Land_PortableCabinet_01_medical_F", [3.5, 2.55, 0], 35] call _attachIt;
_cabinet addItemCargoGlobal ["FirstAidKit", 10]; _cabinet addItemCargoGlobal ["Medikit", 1];
private _stuff = [ "dmpAntibiotics", "dmpAntidote", "RyanZombiesAntiVirusCure_Item", "RyanZombiesAntiVirusTemporary_Item", "dmpBandage", "dmpHeatpack", "dmpPainkillers", "dmpStims"];
private _n_stuff = floor (random 5);
for [{_i = 0 }, {_i < _n_stuff}, {_i = _i + 1}] do { _cabinet addItemCargoGlobal [(selectRandom _stuff), floor (random 4)]; };
[_desk, "Land_Stretcher_01_sand_F", [2.5, 3.5, -.25], 90] call _attachIt;
[_desk, "Land_DeskChair_01_black_F", [2.75, 2.2, -.25], 35] call _attachIt;
[_desk, "Land_CampingTable_white_F",[-1.5, 3.5, 0], 0] call _attachIt;
[_desk, "Land_PlasticCase_01_small_black_F",[4, -5, -.25], 90] call _attachIt;
[_desk, "Land_PlasticCase_01_small_black_F",[3, -5, -.25], 95] call _attachIt;
[_desk, "Land_PlasticCase_01_small_black_F",[3, -4.5, -.25], 87] call _attachIt;
[_desk, "Land_PlasticCase_01_small_black_F",[4, -4.5, -.25], 85] call _attachIt;
[_desk, "Land_PlasticCase_01_large_black_F",[0, -5, -0.5], 0] call _attachIt;
[_desk, "Land_PlasticCase_01_medium_black_F",[-3, -5, -.2], 0] call _attachIt;
[_desk, "Land_PlasticCase_01_medium_black_F",[-3, -3.5, -.2], 0] call _attachIt;
//private _boat_box = [_desk, "Box_B_UAV_06_F",[-5, -3.5, -.2], 0] call _attachIt;
private _boat_box1 = [_desk, "Land_MetalCase_01_large_F",[-5, -3.0, -.2], 0] call _attachIt;
private _boat_box2 = [_desk, "Land_MetalCase_01_large_F",[-5, -4.5, -.2], 0] call _attachIt;
[_desk, "ACE_medicalSupplyCrate_advanced",[-5, -6, -.3], 0] call _attachIt;
[_desk, "ACE_Box_Misc",[-5, -6.75, -.2], 0] call _attachIt;
[_desk, "TargetP_Alien1_F",[-5, -20, 0.4], 270] call _attachIt;
[_desk, "TargetP_Zom_F",[-5, -25, 0.4], 270] call _attachIt;
[_desk, "TargetP_Inf9_F",[-5, -30, 0.4], 270] call _attachIt;
[_desk, "Zombie_PopUp_Moving_90deg_Acc1_F",[-5, -35, 0.4], 270] call _attachIt;
[_desk, "Land_Target_Dueling_01_F",[-5, -40, 0.4], 270] call _attachIt;
base_desk = _desk;
publicVariable "base_desk";

_start_crate setVariable ["type", _crate_type];
_start_crate setVariable ["base", _desk];
_start_crate setVariable ["packed", false];


// ------------------------------------------------------------------
// Add pack / unpack command
// ------------------------------------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    
    [["pck", _target]] call pcb_fnc_send_mail; 
};

[
    _start_crate,
    [
        "Pack/Unpack Base",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];  


[_desk] call pcb_fnc_add_base_actions;


// ------------------------------------------------------------------
//                     Boat Box
// ------------------------------------------------------------------
_boat_box1 setVariable ["packed", true];
_boat_box2 setVariable ["packed", true];

private _bcmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    
    [["pck_boat", _target]] call pcb_fnc_send_mail; 
};

[
    _boat_box1,
    [
        "Pack/Unpack Boat",
        _bcmd,
        [], 1.5, true, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];  
[
    _boat_box2,
    [
        "Pack/Unpack Boat",
        _bcmd,
        [], 1.5, true, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];  



// ------------------------------------------------------------------
// place initial spawn marker
// ------------------------------------------------------------------
_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;
private _marker_respawn = createMarker ["respawn_west", _next_pos]; 
_marker_respawn setMarkerType "respawn_inf";

_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;
private _marker_respawn_veh = createMarker ["respawn_vehicle_west", _next_pos]; 
_marker_respawn_veh setMarkerType "respawn_air";



// ------------------------------------------------------------------
// spawn vehicles
// ------------------------------------------------------------------
private _vehicle_list = [];

// Transport filter clauses (for use with config data and configClasses function)
private _is_military = " (getNumber (_x >> 'side') != 3) ";
private _transport4plus = " (getNumber (_x >> 'transportSoldier') >= 4) ";
private _transport8plus = " (getNumber (_x >> 'transportSoldier') >= 8) ";
private _ground_vehicle = " (getText (_x >> 'vehicleClass') in ['Armored','Car']) ";
private _airground_vehicle = " (getText (_x >> 'vehicleClass') in ['Air','Armored','Car']) ";

// At least one vehicle that can transport 8 (plus driver and "gunner", so usually 10+)
private _ground_transport8_f = [_is_military, _transport8plus, _ground_vehicle] joinString " && ";
private _gt_types = (_ground_transport8_f configClasses (configFile >> "CfgVehicles")) apply { configName _x };
private _gt = selectRandom _gt_types;
_vehicle_list pushBack ["Group Transport", _gt, 20];

private _ground_transport4_f = [_is_military, _transport4plus, _ground_vehicle] joinString " && ";
private _ft_types = (_ground_transport4_f configClasses (configFile >> "CfgVehicles")) apply { configName _x };
private _ft1 = selectRandom _ft_types;
_vehicle_list pushBack ["Transport", _ft1, 25];

private _airground_transport4_f = [_is_military, _transport4plus, _airground_vehicle] joinString " && ";
private _aft_types = (_airground_transport4_f configClasses (configFile >> "CfgVehicles")) apply { configName _x };
private _ft2 = selectRandom _aft_types;
_vehicle_list pushBack ["Transport", _ft2, 25];

// Large air transport
_vehicle_list pushBack ["Cargo Heli", "O_Heli_Transport_04_F", 20];
_vehicle_list pushBack ["SPACER", "SPACER", 30];

systemChat (str _vehicle_list);

private _vdx = 0;
for [{_vdx = 0}, {_vdx < (count _vehicle_list)}, { _vdx = _vdx + 1 }] do {
    private _x = _vehicle_list select _vdx;
    private _label = _x select 0;
    private _type = _x select 1;
    private _delta = _x select 2;
    _next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + _delta;
    if (! (_type isEqualTo "SPACER")) then {
        private _veh = _type createVehicle _next_pos;
        if ((unitIsUAV _veh) || (_label isEqualTo "SUPPORT")) then {
            createVehicleCrew _veh;

            if (_type isEqualTo "SUPPORT") then {
                [playableUnits select 0, _veh] call BIS_fnc_transportService;
            };
        } else {
            [_veh] call pcb_fnc_set_scp_vehicle_loadout;
            _veh addEventHandler ["Respawn", {
                params ["_unit", "_corpse"];
                [_unit] call pcb_fnc_set_scp_vehicle_loadout;
            }];
        };

        private _cid = "T" + str ([] call pcb_fnc_get_next_UID);
        [[_cid, _pid], _label, _vpos, 15] call pcb_fnc_objective_locate_object;
        _veh respawnVehicle [10, 3 + (ceil (random 3))];
        _veh setDir start_dir;

        // make the vehicle available for use by the players group
        (group (playableUnits select 0)) addVehicle _veh;

        sleep .1;
    };
}; // forEach _vehicle_list;

// ------------------------------------------------------------------
//    Spawn "support crates" relative to _start_crate
// ------------------------------------------------------------------
private _sc_dir = (getDir _start_crate) - 90;
if (_sc_dir < 0) then { _sc_dir = _sc_dir + 360; };
private _sc = "B_Slingload_01_Ammo_F" createVehicle (_start_crate getPos [20, _sc_dir]); _sc setDir start_dir;
_sc = "B_Slingload_01_Fuel_F" createVehicle (_start_crate getPos [25, _sc_dir]); _sc setDir start_dir;
_sc = "B_Slingload_01_Repair_F" createVehicle (_start_crate getPos [30, _sc_dir]); _sc setDir start_dir;

// create a portable base box
private _pbb_dir = (getDir _start_crate) + 90;
if (_pbb_dir >= 360) then { _pbb_dir = _sc_dir - 360; };
private _bbpos = _start_crate getPos [10, _pbb_dir];
[_bbpos, true] call pcb_fnc_portable_base_crate;


// ------------------------------------------------------------------
//    Base Guard Squad (not under player control) 
// ------------------------------------------------------------------
_offset = -20;
_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 20;

[_offset, _next_pos, start_pos] spawn {
    params ["_offset", "_next_pos", "_pos"];
    sleep (30 + random 30);

    private _guard_types_inf = [
        "B_Soldier_GL_F",
        "B_Soldier_F",
        "B_Soldier_F"
    ];

    private _i = 0;
    for [{}, {_i < 3}, {_i = _i + 1}] do {
        private _group = [_guard_types_inf, _next_pos, west, false] call pcb_fnc_spawn_squad;
        _next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 20;
        _group selectLeader ((units _group) select 0);
        private _wp = _group addWaypoint [_pos getPos [100 + random 50, start_dir], 20];
        _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "LIMITED";
        _wp = _group addWaypoint [_pos, 20];
        _wp setWaypointType "CYCLE";
        sleep (5 + random 2);
    };
};

[] call pcb_fnc_convenience;

