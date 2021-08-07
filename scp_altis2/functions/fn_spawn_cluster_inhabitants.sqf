/* ********************************************************
                     spawn inhabitants

Given a "cluster" of buildings, spawn appropriate inhabitants

_buildings (list of building objects)
_code
_label (string)   either "mil" or "civ"
_cluster (hashmap) cluster info blob
******************************************************** */
params ["_building", "_code", "_label", "_cluster"];

[_building, _code, _label, _cluster] spawn {
    params ["_buildings", "_spawn_code", "_label", "_cluster"];

    // we'll scale encounter size by number of buildings
    private _scale = ceil ((count _buildings) / 10);
    // but cap it for sanity ...
    if (_scale > 20) then { _scale = 20; };

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
                }; // if
            }; // for
        } forEach _buildings;
    } else {
        // spawn some civilians
        if ((random 100) < 50) then {
            private _types = types_hash get "civilians";
            for [{_i = 0 }, {_i < (ceil (random (_scale / 2)))}, {_i = _i + 1}] do {
                private _n = 2 + (ceil (random 3));
                [_types, _n, getPosATL (selectRandom _buildings), civilian] call _spawn_code;
            };
        };
    };
  
    // -----------------------------------------
    //  Looters
    // -----------------------------------------
    if ((random 100) < 25) then {
        // so we have looters.  Is this a major or minor infestation?
        if ((random 100) < 20) then {
            private _types = types_hash get "insurgents";
            private _n_squads = 2 + (ceil (random _scale));

            // major -- mark on map
            [[west, "HQ"], "Warning! Significant insurgent activity in area. Caution advised."] remoteExec ["commandChat", 0];

            private _marker = createMarker ["ML" + (str ([] call pcb_fnc_get_next_UID)), _cluster get "center"];
            _marker setMarkerShapeLocal "ELLIPSE";
            _marker setMarkerSizeLocal [_cluster get "a", _cluster get "b"];
            _marker setMarkerAlphaLocal 0.5;
            _marker setMarkerColor "ColorRED";                    

            for [{_i = 0 }, {_i < _n_squads}, {_i = _i + 1}] do {
                private _n = 3 + (ceil (random 5));
                [_types, _n, getPosATL (selectRandom _buildings), east] call _spawn_code;
            };

            // if in city, spawn IEDs
            for [{_i = 0 }, {_i < (ceil (_scale / 2))}, {_i = _i + 1}] do {
                [getPosATL (selectRandom _buildings), 20, 2 + (ceil (random 5))] call pcb_fnc_mine_road;
            };

        } else {
            private _types = types_hash get "looters";
            private _n = 1 + (ceil ((random _scale) / 2));
            [_types, _n, getPosATL (selectRandom _buildings), east] call _spawn_code;
        }; // else
    }; // if random looters at all
};

