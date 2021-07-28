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
_desk addItemCargo ["FlashDisk", 1];

_desk setPos (selectRandom _positions);
_desk setDir 180; _desk setPosASL getPosASL _desk;

_desk addEventHandler ["ContainerClosed", {
    params ["_container", "_unit"];
    hint ("closed! <" + (str (getItemCargo _container)) + "><" + (str (getWeaponCargo _container)) + "><" + (str (getMagazineCargo _container)) + "><" + (str (magazineCargo _container)) + ">"); 
}];

["FlashDisk"] spawn {
    params ["_thing"];

    private _done = false;
    while { sleep 7; ! _done } do {
        {
            if (_thing in (itemsWithMagazines _x)) then {
                hint ((str _x) + " has the thing <" + _thing + ">");
            };
        } forEach playableUnits;
    };
};

["desk", "desk", getPosATL _desk, 1] call pcb_fnc_objective_locate_object;
