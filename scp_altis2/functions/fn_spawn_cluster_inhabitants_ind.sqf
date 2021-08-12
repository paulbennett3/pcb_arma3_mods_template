/* ********************************************************
                     spawn inhabitants ind

Given a "cluster" of buildings (industrial, cultural, cemetery), spawn appropriate inhabitants

_buildings (list of building objects)
_label (string)   either "mil" or "civ"
_cluster (hashmap) cluster info blob
******************************************************** */
params ["_building", "_label", "_cluster"];

[_building, _label, _cluster] spawn {
    params ["_buildings", "_label", "_cluster"];

    // we'll scale encounter size by number of buildings
    // want log base 2, so use change of bases formula with natural log
    private _scale = ceil ((ln (count _buildings)) / (ln 2));
    ["Setting scale to " + (str _scale)] call pcb_fnc_debug;

    private _bdx = 0;
    for [{_bdx = 0}, {_bdx < _scale}, {_bdx = _bdx + 1}] do {
        private _building = selectRandom _buildings;

        // add some decorations
        [getPosATL _building, _building] call pcb_fnc_occult_decorate;

        // spooks
        if ((random 100) < 20) then {
            private _types = [selectRandom (types_hash get "spooks")];
            for [{_i = 0 }, {_i < _scale}, {_i = _i + 1}] do {
                private _n = 1 + (floor (random 4));
                private _pos = (getPosATL _building) getPos [random 30, random 360];
                [_types, _n, _pos, east, false] call pcb_fnc_spawn_squad;
 ["Spawning spooks <" + (str _types) + "> squad in Ind/Cult of size " + (str _n)] call pcb_fnc_debug;
            };
        };

        // anomalies
        if ((random 100) < 20) then {
            private _pos = (getPosATL _building) getPos [random 30, random 360];
            [_pos, _scale, 3 * _scale] call pcb_fnc_add_anomalies;
            ["Spawning anomalies ..."] call pcb_fnc_debug;
        };

    };
};
