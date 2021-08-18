/* ******************************************************************
                  spawn spare helicopters

Put helicopters on all the helipads on the map
****************************************************************** */
// only let this run once!!!!
if (! isNil "spare_heli_spawner") exitWith {};

spare_heli_spawner = true; publicVariable "spare_heli_spawner";

private _helipads = (world_center nearObjects ["HeliH", worldSize]);
["Found " + (str (count _helipads)) + " helipads"] call pcb_fnc_debug;
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
    _pos = [_pos select 0, _pos select 1];

    _veh = createVehicle [_type, _pos, [], 2, "NONE"];
    _veh setDir (random 360);
    sleep .1;

    // add a repair facility
    private _repair = types_hash get "static repair civ";
    if ([_pos] call pcb_fnc_near_military) then {
        _repair = types_hash get "static repair mil";
    };
    _type = selectRandom _repair;
    _veh = createVehicle [_type, _x getRelPos [7, 90], [], 2, "NONE"];

    // add a "cargo" pod
    private _cargo = types_hash get "static cargo civ";
    if ([_pos] call pcb_fnc_near_military) then {
        _cargo = types_hash get "static cargo mil";
    };
    _type = selectRandom _cargo;
    _veh = createVehicle [_type, _x getRelPos [7, 180], [], 2, "NONE"];



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

// Do something similar for all hangars
private _hangars = [];
private _types = types_hash get "hangars";
for [{_hdx = 0}, {_hdx < (count _types)}, {_hdx = _hdx + 1 }] do {
    private _type = _types select _hdx;
    _hangars = _hangars + (world_center nearObjects [_type, worldSize]);
};
["Found " + (str (count _hangars)) + " hangars"] call pcb_fnc_debug;
for [{_hdx = 0}, {_hdx < (count _hangars)}, {_hdx = _hdx + 1}] do {
    if ((_hdx % 100) < 1) then { sleep .1; };

    private _x = _hangars select _hdx;
    private _pos = getPosATL _x;
    private _near_military = [_pos] call pcb_fnc_near_military;

    _pos = [_pos select 0, _pos select 1];
    private _type = "";
    if ((random 100) < 75) then {
        _type = selectRandom (types_hash get "heli mil");
        if (not _near_military) then {
            _type = selectRandom (types_hash get "heli civ");
        };
    } else {
        _type = selectRandom (types_hash get "plane mil");
        if (not _near_military) then {
            _type = selectRandom (types_hash get "plane civ");
        };
    };

    _veh = createVehicle [_type, _pos, [], 1, "NONE"];
    _veh setDir (random 360);
    sleep .1;

    if (pcb_DEBUG) then {
        private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
        private _m = createMarker [_mn, _pos];
        _mn setMarkerShapeLocal "ELLIPSE";
        _mn setMarkerColorLocal "ColorORANGE";
        _mn setMarkerSizeLocal [150, 150];
        _mn setMarkerAlpha 0.9;
    };

    sleep .1;
};



