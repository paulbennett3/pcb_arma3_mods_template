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
    // want log base 3, so use change of bases formula with natural log
    private _scale = ceil ((ln (count _buildings)) / (ln 3));
    ["Setting scale to " + (str _scale)] call pcb_fnc_debug;

    private _bdx = 0;
    for [{_bdx = 0}, {_bdx < _scale}, {_bdx = _bdx + 1}] do {
        // spooks
        private _building = selectRandom _buildings;
        if ((random 100) < 20) then {

            // add some decorations
            [getPosATL _building, _building] call (scenario_object get "Decorate"); 

            private _n = 1 + (floor (random _scale));
            private _pos = (getPosATL _building) getPos [random 30, random 360];
            [_pos, 101, 1 + _scale] call (scenario_object get "Mission Encounter");
        };

        // anomalies
        if ((random 100) < 20) then {
            private _pos = (getPosATL _building) getPos [random 30, random 360];
            [_pos, _scale, 3 * _scale] call (scenario_object get "Add Anomalies");
            ["Spawning anomalies ..."] call pcb_fnc_debug;
        };

    };
};
