/* ******************************************************************
                         make special cluster

Parameters:
    _special_clusters (hashmap) : used to record our info for use
           when trigger fires
    _map (hashmap) : cluster map for our selection from
    _label (string) : label of cluster map ("CIV", "MIL", "IND")
****************************************************************** */
params ["_special_clusters", "_map", "_label"];

["Making a special cluster ..."] call pcb_fnc_debug;

// select a cluster at random from our map
private _cluster_id = selectRandom (keys _map);
private _cluster = _map get _cluster_id;
["  " + (str _cluster_id) + "  " + (str _cluster)] call pcb_fnc_debug;
private _buildings = _cluster get "obj_list";

_special_clusters set [[_label, _cluster_id], true];

// insurgents
if (true) then {
    private _scale = ceil ((ln (count _buildings)) / (ln 2));
    private _types = types_hash get "insurgents";
    private _n_squads = 1 + (ceil (random _scale));

    // major -- mark on map
    [[west, "HQ"], "Warning! Significant insurgent activity in area. Caution advised."] remoteExec ["commandChat", 0];
    ["Warning! Significant insurgent activity in area. Caution advised."] remoteExec ["systemChat", 0];

    private _marker = createMarker ["MLI" + (str ([] call pcb_fnc_get_next_UID)), _cluster get "center"];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerSizeLocal [(_cluster get "a") + 100, (_cluster get "b") + 100];
    _marker setMarkerAlphaLocal 0.5;
    _marker setMarkerBrushLocal "SolidBorder";
    _marker setMarkerColor "ColorYELLOW";

    private _iidx = 0;
    for [{_iidx = 0 }, {_iidx < _n_squads}, {_iidx = _iidx + 1}] do {
        private _n = 3 + (ceil (random 5));
        private _building = selectRandom _buildings;

        if (pcb_DEBUG) then {
            private _marker = createMarker ["MLIB" + (str ([] call pcb_fnc_get_next_UID)), getPosATL _building];
            _marker setMarkerType "KIA";
        };

        [_types, _n, getPosATL _building, east] call pcb_fnc_spawn_squad;
["Spawning Insurgent squad " + (str (_iidx + 1)) + " of " + (str (_n_squads)) + " size " + (str _n)] call pcb_fnc_debug;
    };

    // if in city, spawn IEDs
    for [{_iidx = 0 }, {_iidx < _scale}, {_iidx = _iidx + 1}] do {
        [getPosATL (selectRandom _buildings), 30, 2 + (ceil (random 5))] call pcb_fnc_mine_road;
["Spawning mines"] call pcb_fnc_debug;
    };
};

_special_clusters

