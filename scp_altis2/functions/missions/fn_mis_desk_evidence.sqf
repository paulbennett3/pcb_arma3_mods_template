/* *******************************************************************
                      mis_desk_evidence

Spawn a desk with a flash drive in a building. 

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

params ["_UID"];

private _ok = false;

private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

// -------------------------------------

if (pcb_DEBUG) then {
    hint "Desk Evidence running";
};

// -------------------
// find building
// -------------------
private _building = [epicenter, 5000] call pcb_fnc_get_cool_building_location;
if (isNull _building) exitWith { hint "failed to find building!"; [false, _state] };
private _positions = [_building] call BIS_fnc_buildingPositions;

// -------------------
// create and decorate the desk
// -------------------
private _attachIt = {
    params ["_target", "_type", "_pos", "_rot"];
    private _thing = _type createVehicle [0,0,0];
    _thing attachTo [_target, _pos]; _thing setDir _rot; _thing setPosASL getPosASL _thing;
    _thing
};
private _desk = "OfficeTable_01_old_F" createVehicle [0,0,0];
[_desk, "Land_FilePhotos_F", [-.25, 0, .425], 25] call _attachIt;
[_desk, "Land_FlowerPot_01_F", [.6, 0.15, .525], 165] call _attachIt;
[_desk, "Land_Notepad_F", [.45, -.05, .425], 292] call _attachIt;

private _cargo = "FlashDisk";
_desk addItemCargoGlobal [_cargo, 1];

_desk setPos (selectRandom _positions);
_desk setDir 180; _desk setPosASL getPosASL _desk;

_state set ["target", _cargo];
_state set ["container", _desk];
_state set ["taskpos", getPosATL _desk];
_state set ["taskdesc", [
        "Retrieve the flash drive with evidence of occult research",
        "Get evidence",
        "markername"]];
_state set ["taskpid", objNull];

// add some anomalies
[getPosATL _desk, 1, 5] call pcb_fnc_add_anomalies;

private _result = [_state] call pcb_fnc_mis_ll_get_item;
_result
