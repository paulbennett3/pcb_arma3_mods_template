/* *******************************************************************
                      mis_rescue_scp

Locate and rescue the SCP group

Parameters:
   _UID (string) : the UID assigned by the mission generator

Returns:
   _result (array) : [ _ok, _state ]
           where:
              _ok (bool) : true if mission generated ok, false if
                   any errors or failures happened (and we should try again)
              _state (hashmap) : any state needed to cleanup after this mission
                 Keys:
                    "obj_list" (array) : list of "vehicles" to delete
                    "marker_list" (array) : list of "markers" to delete
                    ???

******************************************************************* */

params ["_sobj", "_UID"];

private _ok = false;

private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

// -------------------------------------

if (pcb_DEBUG) then {
    ["Rescue SCP running"] call pcb_fnc_debug;
};

// pick a building, spawn some SCP, put then in building in "defend".
// Spawn foe, outside building, with search-and-destroy ... 

// then find a random building, and positions within ...
private _building = [epicenter, mission_radius] call pcb_fnc_get_cool_building_location;
if ((isNil "_building") || (isNull _building)) exitWith { hint "failed to find building!"; [false, _state] };
private _pos = getPosATL _building;
if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { [false, _state] };

private _positions = _building buildingPos -1;
private _target = objNull;

["Found building"] call pcb_fnc_debug;

// -----------------------------------------------------------------

private _n = 1 + (ceil (random 5));
private _group = grpNull;

if (true) then {
    private _types = [];
    for [{}, {_n > -1}, {_n = _n - 1}] do {
        _types pushBack "B_Soldier_F";
    };
    _group = [_types, _pos, west, true] call pcb_fnc_spawn_squad;
    _state set ["targetlist", units _group];
    _state set ["obj_list", units _group];
    _state set ["taskpos", _pos];
    _state set ["taskradius", 50];
    _state set ["taskdesc", [
                   "Link up with the trapped SCP team and assist",
                   "Assist SCP team",
                   "markername"]];
    private _base_loadout = scp_specialists get "base loadout";
    {
        [_x, _building, _base_loadout] spawn { 
            params ["_unit", "_building", "_base_loadout"];
            [_unit] call _base_loadout;    

            // player group in range?  Join it!
            while { sleep 5; alive _unit} do {
                {
                    if ((_unit distance _x) < 5) exitWith { 
                        [_unit] join player_group;
                        true;
                    };
                } forEach playableUnits;
                if ((group _unit) == player_group) exitWith {};
            }; 
        };
    } forEach (units _group);
    _group selectLeader (selectRandom (units _group));
};

["Spawned squad"] call pcb_fnc_debug;

private _taskpid = "";
if (! (PARENT_TASK isEqualTo "")) then { _taskpid = PARENT_TASK; };
_state set ["taskpid", _taskpid];

// add some anomalies
//[getPosATL _target, 1, 5] call (_sobj get "Add Anomalies");
[getPosATL _target] call (_sobj get "Decorate");
private _opos = _pos getPos [100 + random 50, random 360];
private _foo = [_opos, 101, 20] call (_sobj get "Mission Encounter");
private _ogroup = group ((_foo select 0) select 0); 

if (isNil "_group") then {
    ["RESCUE :: _group is nil"] call pcb_fnc_debug;
} else {
    private _units = units _group;
    if (isNil "_units") then {
        ["RESCUE :: _units is nil"] call pcb_fnc_debug;
    } else {
        if ((count _units) < 1) then {
            ["RESCUE :: count _units is < 1"] call pcb_fnc_debug;
        } else {
            [_ogroup, _units] spawn {
                params ["_ogroup", "_units"];
                private _done = false;
                while { sleep 10; ! _done } do {
                    private _ounits = (units _ogroup) select { alive _x };
                    private _aunits = _units select { alive _x };
                    if ((isNil "_ounits") || { (count _ounits) < 1 } ) then { _done = true; };
                    if ((isNil "_aunits") || { (count _aunits) < 1 } ) then { _done = true; };
                    if (! _done) then {
["RESCUE loop " + (str (count _ounits)) + " enemy, " + (str (count _aunits)) + " allies"] call pcb_fnc_debug;
                        if ((count (waypoints _ogroup)) < 1) then {
                            private _t = selectRandom _aunits;
["Setting <" + (str _t) + "> as target for DESTROY waypoint"] call pcb_fnc_debug;
                            private _wp = _ogroup addWaypoint [_t, -1];
//                            _wp waypointAttachVehicle _t;
                            _wp setWaypointType "DESTROY";
                            _wp setWaypointCombatMode "RED";
                            _wp setWaypointBehaviour "COMBAT";
                        };
                    };
                };
["RESCUE Destroy loop exiting"] call pcb_fnc_debug;
            };
        };
    };
};

[_building] call pcb_fnc_add_loot_boxes_to_building;

private _result = [_state] call pcb_fnc_mis_ll_rescue;

_result
