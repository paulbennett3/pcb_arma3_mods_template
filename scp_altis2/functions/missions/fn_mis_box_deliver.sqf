/* *******************************************************************
                      mis_box_deliver

Create a box (player transportable, but doesn't fit in inventory).
Fill with:
   Aliens -- staff weapons, artefacts, ...
   Zombies -- speciments, notes, vials, ...
   Occult -- laptops, notes, ...

Player must get box to a designated location

Places to spawn box:
   Big building in a cluster (prefereably MIL or CIV, since many of the big IND are open space)
      Ideally in a *big* cluster

Places to take:
   Research lab, base, ...

Obstacles:
  Guard:
    n squads (say 3 or 4 units each) surrounding the spawn point.  Waypoint to guard? SAD?
  Waylay:
    k squads given SAD.  Spawn near destination, put target on box?  Make sure not dynamic!!!! 

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
    hint "Box Deliver running";
};

private _boxes = [
    "CBRNContainer_01_closed_yellow_F",
    "Land_PlasticCase_01_large_CBRN_F",
    "CBRNContainer_01_closed_olive_F",
    "Land_MetalCase_01_medium_F",
    "Land_WoodenCrate_01_F"
];

// -------------------
// find 2 buildings -- source and destination
private _buildings = [];
private _tries = 50;
private _min_dist = mission_radius;

while { sleep 0.1; (((count _buildings) < 2) && { _tries > -1}) } do {
    private _building = [epicenter, worldSize] call pcb_fnc_get_cool_building_location;
    if ((isNil "_building") || { isNull _building }) then {
    } else {
        private _pos = getPosATL _building;
        if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) then {
        } else {
            if ((count _buildings) == 0) then {
                // only force the source building (first one) to be in the active area
                if (_building inArea active_area) then {
                    _buildings pushBackUnique _building;
                };
            } else {
                if ((count _buildings) == 1) then {
                    if (((_buildings select 0) distance2D _building) > _min_dist) then {
                        _buildings pushBackUnique _building;
                    };
                } else {
                    _buildings pushBackUnique _building;
                };
            };
        };
    };
};

// did we end up with our two buildings?
if ((count _buildings) < 2) exitWith { ["Failed to find 2 buildings!!!"] call pcb_fnc_debug; [false, _state] };

private _source = _buildings select 0;
private _dest = _buildings select 1;

// pick a location in the source building and create our box
private _locations = _source buildingPos -1;
private _maxz = selectMax (_locations apply { _x select 2 });
private _source_pos = selectRandom (_locations select { (_x select 2) >= _maxz } );
if ((!([_source_pos] call pcb_fnc_is_valid_position)) || {(_source_pos select 2) < 0} ) then {
    hint "SOURCE_POS invalid or below ground";
    _source_pos = _source; // use the building itself as the position
};
private _box = (selectRandom _boxes) createVehicle [0, 0, 0];
_box setVehiclePosition [_source_pos, [], 0, "NONE"];

// pick a location in the destination building
_locations = _dest buildingPos -1;
private _dest_pos = selectRandom _locations;
private _dest_building_pos = getPosATL _dest;
_dest_building_pos = [_dest_building_pos select 0, _dest_building_pos select 1];

private _long_goal = "Retrieve box of stuff and transport to destination";
private _goal = "Transport box";

// --------------------------------------------------
// add some hostiles to ambush
// --------------------------------------------------
private _trg = createTrigger ["EmptyDetector", _source_pos, true];
private _code = "[thisTrigger getVariable '_pos', thisTrigger getVariable '_target'] call pcb_fnc_spawn_insurgent_squad;";
_trg setTriggerArea [ 5, 5, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trg setTriggerStatements ["this", _code, ""];
_trg setVariable ["_pos", _dest_building_pos];
_trg setVariable ["_target", _box];
// --------------------------------------------------

_state set ["target", _box];
_state set ["is_obj", true];
_state set ["in_area", true];
_state set ["container", objNull];
_state set ["taskpos", _dest_pos];
_state set ["taskradius", 5];
_state set ["taskdesc", [ _long_goal, _goal, "markername"]];
_state set ["taskpid", ""];
_state set ["callback", [false, objNull, objNull]];
private _result = [_state] call pcb_fnc_mis_ll_put_item;

// add some anomalies, decorate, add (possible) foes
[getPosATL _source, 1, 5] call (_sobj get "Add Anomalies");
[getPosATL _source] call (_sobj get "Decorate");
[getPosATL _source, 50] call (_sobj get "Mission Encounter");

// make an objective marker for the pickup -- do it here so it takes precedence over the drop off task
private _cid = "T" + str ([] call pcb_fnc_get_next_UID);
[_cid, "Cargo Pickup", getPosATL _box, 2] call pcb_fnc_objective_locate_object;

_result
