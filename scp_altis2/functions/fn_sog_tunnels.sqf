/* ********************************************************************
                      sog tunnels

Use the tunnel complexes already built in to the Cam Lao Nam map,
along with the init and spawn functions from S.O.G Prairie Fire

Parameters:
    _pos (position) : where to place the tunnel entrance
    _types (list of strings) : types to select from when building garrison
    _n (number) : (optional) number of units in garrison

Returns:
    _group (group object) : the group for the spawned garrison
    _tpos (position) : the location on the map where the tunnel complex is (as opposed to the entrance!)
******************************************************************** */
// from:
// https://community.sogpf.com/threads/255-Scripting-Tunnel-System

params ["_pos", "_types", ["_n", 20]];

["Building a tunnel complex ..."] call pcb_fnc_debug;

// The tunnel you would like to have
private _tunnelNo = selectRandom [0, 1, 2, 3, 4, 5]; // from 0 to 5 !!!

// These are the tunnel positions on the map -- ONLY FOR Cam Lao Nam -- they are pre-placed!
private _tpos = [
    [393.346,16979.3,0],
    [253.172,18696.2,0],
    [540.936,20206.0,0],
    [2730.52,20066.4,0],
    [4252.47,20084.8,0],
    [5769.42,20088.9,0]
] select _tunnelNo;

// Find the tunnel objects for your location
private _tunnels = nearestObjects [_tpos,["Land_vn_tunnel_01_building_01_01","Land_vn_tunnel _01_building_04_01","Land_vn_tunnel_01_building_03 _01","Land_vn_tunnel_01_building_02_01"],worldSize];

// Create the logic and store logic object into global variable
private _grp = createGroup sideLogic;
"vn_module_tunnel_init" createUnit [
    _pos,
    _grp,
    "this setVariable ['BIS_fnc_initModules_disableAutoActivation',true,true];myTunnel = this; publicVariable 'myTunnel';"
];
waitUntil { sleep 1; ! isNil "myTunnel" };
// Now set the wanted tunnel
myTunnel setvariable ["tunnel_position",_tunnelNo];

// Call the init module function
["",[myTunnel,true]] call vn_fnc_module_tunnel_init;

// And finally spawn the units in your tunnel segments
private _group = [_tunnels,east,_n,_types] call vn_fnc_tunnel_spawn_units;


/*
btw, these variables can be set which are the ones from the module (copy from init function of module):
private _position = (_logic getVariable ["tunnel_position", 0]);
private _garrison_size = (_logic getVariable ["garrison_size", 0]);
private _garrison_side = (_logic getVariable ["garrison_side", 1]);
private _garrison_classnames_preselection = (_logic getVariable ["garrison_classnames_preselection", "[]"]);
private _garrison_classnames_custom = (_logic getVariable ["garrison_classnames_custom", "[]"]);
private _actionincode_action = _logic getVariable ["actionincode_action","true"];
private _actionsearchcode_action = _logic getVariable ["actionsearchcode_action","true"];
private _actionoutcode_action = _logic getVariable ["actionoutcode_action","true"];
private _actionincode = _logic getVariable ["actionincode","true"];
private _actionoutcode = _logic getVariable ["actionoutcode","true"]; 
*/

private _result = [_group, _tpos];
_result
