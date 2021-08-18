/* ********************************************************
                     spawn inhabitants

Given a "cluster" of buildings, spawn appropriate inhabitants

_buildings (list of building objects)
_label (string)   either "mil" or "civ"
_cluster (hashmap) cluster info blob
******************************************************** */
params ["_building", "_label", "_cluster"];

[_building, _label, _cluster] spawn {
    params ["_buildings", "_label", "_cluster"];

    // we'll scale encounter size by number of buildings
    // want log base 3, so use change of bases formula with natural log
    private _scale = ceil ((ln (count _buildings)) / (ln 3));
    ["Setting scale to " + (str _scale)] call pcb_fnc_debug;

    // -----------------------------------------
    // if it is military, do some cargo crates
    // -----------------------------------------
    if (_label isEqualTo "mil") then {
        private _crates = types_hash get "resupply crates";
        { // forEach _buildings
            private _building = _x; 
            private _positions = [_building] call BIS_fnc_buildingPositions;
            for [{_i = 0 }, {_i < (ceil (random ((count _positions)/2)))}, {_i = _i + 1}] do {
                private _pos = selectRandom _positions;
                if ([_pos] call pcb_fnc_is_valid_position) then {
                    private _object_type = selectRandom _crates;
                    _target = _object_type createVehicle [0, 0, 0];
                    _target setPos _pos;
["Spawning loot crate in mil building"] call pcb_fnc_debug;
                }; // if
            }; // for
        } forEach _buildings;
    } else {
        // spawn some civilians
        private _types = types_hash get "civilians";
        for [{_i = 0 }, {_i < _scale}, {_i = _i + 1}] do {
            if ((random 100) < 50) then {
                private _n = 1 + (floor (random 4));
                private _ctypes = [];
                for [{}, {_n > -1}, {_n = _n - 1}] do {
                    _ctypes pushBack (selectRandom _ctypes);
                }; 
                [_ctypes, getPosATL (selectRandom _buildings), civilian] call pcb_fnc_spawn_squad;
["Spawning civilian squad in city of size " + (str _n)] call pcb_fnc_debug;
            };
        };
    };
  
    // -----------------------------------------
    //  Looters
    // -----------------------------------------
    if ((random 100) < 10) then {
        private _types = types_hash get "looters";
        private _n = 1 + (ceil (random _scale));
        private _ctypes = [];
        for [{}, {_n > -1}, {_n = _n - 1}] do {
            _ctypes pushBack (selectRandom _ctypes);
        }; 
        [_ctypes, getPosATL (selectRandom _buildings), east] call pcb_fnc_spawn_squad;
        ["Spawning city looters of size " + (str _n)] call pcb_fnc_debug;
    } else {
        ["Not spawning looters for this city"] call pcb_fnc_debug;
    }; // if random looters at all
};

