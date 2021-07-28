hint "test mission running";

private _pos = (playableUnits select 0) getRelPos [12, 90];

private _building = "Land_Medevac_house_V1_F" createVehicle [0,0,0];
_building setPos _pos;

private _positions = [_building] call BIS_fnc_buildingPositions;

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
_desk addItemCargo [_cargo, 1];

_desk setPos (selectRandom _positions);
_desk setDir 180; _desk setPosASL getPosASL _desk;

private _state = createHashMapFromArray [
    ["target", _cargo],
    ["container", _desk],
    ["taskpos", getPosATL _desk],
    ["taskdesc", [
        "Retrieve the flash drive with evidence of occult research from the desk in the lab module",
        "Get evidence",
        "markername"]],
    ["taskpid", objNull]
];
private _result = [_state] call pcb_fnc_mis_get_item;

private _vpos1 = (playableUnits select 0) getRelPos [30, 180];
private _truck = "vn_c_bicycle_01" createVehicle _vpos1;
private _vpos = (playableUnits select 0) getRelPos [100, 180];
private _state2 = createHashMapFromArray [
    ["target", _truck],
    ["in_area", true],
    ["is_obj", true],
    ["container", objNull],
    ["taskpos", _vpos],
    ["taskradius", 5],
    ["taskdesc", [
        "Bring the truck",
        "Bring evidence",
        "markername"]],
    ["taskpid", objNull]
];
private _result = [_state2] call pcb_fnc_mis_put_item;


