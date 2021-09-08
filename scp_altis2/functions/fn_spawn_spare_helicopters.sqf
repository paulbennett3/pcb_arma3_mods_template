/* ******************************************************************
                  spawn spare helicopters

Put helicopters on all the helipads on the map
****************************************************************** */
// only let this run once!!!!
if (! isNil "spare_heli_spawner") exitWith {};

spare_heli_spawner = true; publicVariable "spare_heli_spawner";

// make sure not to spawn alien aircraft ...
private _exclude = types_hash get "air exclude";
private _heli_civ = (types_hash get "heli civ") select { not (_x in _exclude) } ;
private _heli_mil = (types_hash get "heli mil") select { not (_x in _exclude) };
private _air_civ = (types_hash get "air civ") select { not (_x in _exclude) };
private _air_mil = (types_hash get "air mil") select { not (_x in _exclude) };


// find all the helipads
private _helipads = (world_center nearObjects ["HeliH", worldSize]);
["Found " + (str (count _helipads)) + " helipads"] call pcb_fnc_debug;
private _hdx = 0;
for [{_hdx = 0}, {_hdx < (count _helipads)}, {_hdx = _hdx + 1}] do {
    private _x = _helipads select _hdx;
    private _pos = getPosATL _x;
    private _near_military = [_pos] call pcb_fnc_near_military;

    _pos = [_pos select 0, _pos select 1];
    private _type = "";
    private _htries = 10;
    while { _htries > -1 } do {
        _htries = _htries - 1;
        if (not _near_military) then {
            _type = selectRandom _heli_civ;
        } else {
            _type = selectRandom _heli_mil;
        };
        private _tpos = _pos findEmptyPosition [0, 3, _type];
        if ((count _tpos) > 0) then {
            _htries = -10;
            _pos = _tpos;
        };
    };

    _veh = createVehicle [_type, _pos, [], 0, "NONE"];
    _veh setDir (getDir _x);

    // add a repair facility
    private _repair = [];
    if (_near_military) then {
        _repair = types_hash get "static repair mil";
    } else {
       _repair = types_hash get "static repair civ";
    };
    _type = selectRandom _repair;
    private _epos = (_x getRelPos [10, 90]) findEmptyPosition [0, 4, _type];
    if ((count _epos) > 0) then { 
        _veh = createVehicle [_type, _epos, [], 0, "NONE"];
    };

    // add a "cargo" pod
    private _cargo = [];
    if (_near_military) then {
        _cargo = types_hash get "static cargo mil";
    } else {
        _cargo = types_hash get "static cargo civ";
    };
    _type = selectRandom _cargo;
    _epos = (_x getRelPos [10, 180]) findEmptyPosition [0, 4, _type];
    if ((count _epos) > 0) then { 
        _veh = createVehicle [_type, _epos, [], 0, "NONE"];
    };


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
// Note that to avoid having to search again for all hangar buildings, we use the
//   list built by the map inspector / building density routine.  So we
//   need to wait until it is done ...
["Waiting on building density to complete with hangar_list"] call pcb_fnc_debug;
waitUntil { sleep 5; (! isNil "hangar_list_done") && { hangar_list_done } };

// Unfortunately, find_building_density uses "nearObjects", which won't find certain hangars.
//   So we use what it *did* find, plus _helipads and our airport list to use as "seeds" for
//   a more expensive search
// _helipads     --> list of objects
// ALL_airfields --> list of [position, direction, dir]
["Searching for harder to find hangars ..."] call pcb_fnc_debug;

private _seed_positions = (_helipads apply { getPosATL _x}) + 
                          (ALL_airfields apply { _x select 0 }) + 
                          (hangar_list apply { getPosATL _x}); 

// In most cases we will have multiple hangars / helipads near each other, or at the airport.
//  So we reduce the resolution of the position and cache them so we have fewer searches
private _round_pos = {
    params ["_val"];
    ((round (_val / 500)) * 500)
};
_seed_positions = _seed_positions apply { [[_x select 0] call _round_pos, 
                                           [_x select 1] call _round_pos] };

// remove duplicates
_seed_positions = _seed_positions arrayIntersect _seed_positions;

// Now that we have the seeds, do the expensive search with a shorter range
//   looping over each seed position and each type (doing an expensive search in each -- ouch!)
private _hangars = [];
private _types = types_hash get "hangars";
private _sdx = 0;
["   hangar search starting double loop on nearObjects ..."] call pcb_fnc_debug;
for [{}, {_sdx < (count _seed_positions)}, {_sdx = _sdx + 1}] do {
    private _spos = _seed_positions select _sdx;

    for [{_hdx = 0}, {_hdx < (count _types)}, {_hdx = _hdx + 1 }] do {
        private _type = _types select _hdx;
        _hangars = _hangars + (_spos nearObjects [_type, 1000]);
    };
};

// make sure we don't have duplicates!
_hangars = _hangars arrayIntersect _hangars;

["hangar_list done -- populating hangars ..."] call pcb_fnc_debug;
["Found " + (str (count _hangars)) + " hangars"] call pcb_fnc_debug;
for [{_hdx = 0}, {_hdx < (count _hangars)}, {_hdx = _hdx + 1}] do {
    private _x = _hangars select _hdx;
    private _pos = getPosATL _x;
    private _dir = (getDir _x) + 180;
    if (_dir > 360) then { _dir = _dir - 360; };
    private _near_military = [_pos] call pcb_fnc_near_military;

    _pos = [_pos select 0, _pos select 1, 0.1];
    private _type = "";
    private _htries = 10;
    while { _htries > -1 } do {
        _htries = _htries - 1;
        if ((random 100) < 50) then {
            _type = selectRandom _heli_mil;
            if (not _near_military) then {
                _type = selectRandom _heli_civ;
            };
        } else {
            _type = selectRandom _air_mil;
            if (not _near_military) then {
                _type = selectRandom _air_civ;
            };
        };

        _veh = _type createVehicle [0, 0, 0];
        if (([_x, _veh, _type] call pcb_fnc_will_fit_in_hangar)) then {
           _veh setDir _dir;
           _veh setVehiclePosition [_pos, [], 0, "NONE"];
           _htries = -10;

        } else {
            deleteVehicle _veh;
            sleep .1;
        };
    };

    sleep .1;

    if ((random 100) < 75) then {
        private _svpos = _pos getPos [15, 90];
        private _vtype = selectRandom [ 
            "C_Van_01_fuel_F",
            "C_Offroad_01_repair_F",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA",
            "CUP_B_TowingTractor_USA"
       ];
       private _vpos = _svpos findEmptyPosition [0, 5, _vtype];
       if ((count _vpos) > 0) then { 
           private _sveh = _vtype createVehicle _vpos;
           _sveh setDir _dir;
       };
    };
 
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



