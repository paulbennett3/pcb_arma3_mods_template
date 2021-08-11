[] spawn {
    map_inspector_done = false;

    private _size = 200;
["Building density map ..."] call pcb_fnc_debug;
    private _density_map = [_size] call pcb_fnc_find_building_density;
["... done building density map"] call pcb_fnc_debug;
    if (isNil "_density_map") then {
        ["Failed to generate density map"] remoteExec ["systemChat", 0];
    } else {
["Merging density clusters ..."] call pcb_fnc_debug;
        private _map = _density_map get "CIV";
        private _values = (values _map) apply { _x select 0 };
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        civ_clusters = [_map, "CIV", _uq] call pcb_fnc_merge_clusters;
        if (pcb_DEBUG) then { [_map, _size, _uq, "colorBLUE"] call pcb_fnc_plot_density; };
        [civ_clusters, "CIV"] call pcb_fnc_plot_clusters_and_create_triggers;

        _map = _density_map get "MIL";
        _values = (values _map) apply { _x select 0 };
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        mil_clusters = [_map, "MIL", _uq] call pcb_fnc_merge_clusters;
        if (pcb_DEBUG) then { [_map, _size, _uq, "colorRED"] call pcb_fnc_plot_density; };
        [mil_clusters, "MIL"] call pcb_fnc_plot_clusters_and_create_triggers;

        // skipping industrial sites for now ...
        if (false) then {
            _map = _density_map get "IND";
            _values = (values _map) apply { _x select 0 };
            _values sort true;
            private _uq = _values select (floor (3* (count _values) / 4));
            ind_clusters = [_map, "IND", _uq] call pcb_fnc_merge_clusters;
            if (pcb_DEBUG) then { [_map, _size, _uq, "colorGREEN"] call pcb_fnc_plot_density; };
            [ind_clusters, "IND"] call pcb_fnc_plot_clusters_and_create_triggers;
        };
[" ... done merging"] call pcb_fnc_debug;
    };

    sleep 1;
    map_inspector_done = true;
};
