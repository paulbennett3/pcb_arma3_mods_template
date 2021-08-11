/* ******************************************************************
                  spawn spare helicopters

Put helicopters on all the helipads on the map
****************************************************************** */
// only let this run once!!!!
if (! isNil "spare_heli_spawner") exitWith {};

spare_heli_spawner = true; publicVariable "spare_heli_spawner";

private _helipads = (world_center nearObjects ["HeliH", worldSize]);
private _hdx = 0;
for [{_hdx = 0}, {_hdx < (count _helipads)}, {_hdx = _hdx + 1}] do {
    if ((_hdx % 100) < 1) then { sleep .1; };

    private _x = _helipads select _hdx;
    private _pos = getPosATL _x;
    private _near_military = [_pos] call pcb_fnc_near_military;

    private _type = selectRandom (types_hash get "heli mil");
    if (not _near_military) then {
        _type = selectRandom (types_hash get "heli civ");
    };

    _veh = createVehicle [_type, _pos, [], 0, "NONE"];
//    _veh setVariable ["BIS_enableRandomization", false];
    _veh setDir (random 360);
    sleep .1;

    // add a repair facility
    private _repair = types_hash get "static repair civ";
    if ([_pos] call pcb_fnc_near_military) then {
        _repair = types_hash get "static repair mil";
    };
    _type = selectRandom _repair;
    _veh = createVehicle [_type, _x getRelPos [7, 90], [], 0, "NONE"];

    // add a "cargo" pod
    private _cargo = types_hash get "static cargo civ";
    if ([_pos] call pcb_fnc_near_military) then {
        _cargo = types_hash get "static cargo mil";
    };
    _type = selectRandom _cargo;
    _veh = createVehicle [_type, _x getRelPos [7, 180], [], 0, "NONE"];



    if (pcb_DEBUG) then {
        private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
        private _m = createMarker [_mn, _pos];
        _mn setMarkerShapeLocal "ELLIPSE";
        _mn setMarkerColorLocal "ColorBLUE";
        _mn setMarkerSizeLocal [150, 150];
        _mn setMarkerAlpha 0.9;
    };

    sleep .1;
}; // forEach (world_center nearObjects ["HeliH", worldSize]);
