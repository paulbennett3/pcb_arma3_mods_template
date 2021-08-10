[] spawn {
    private _size = 200;
    private _density_map = [_size] call pcb_fnc_find_building_density;
    if (isNil "_density_map") then {
        ["Failed to generate density map"] remoteExec ["systemChat", 0];
    } else {
        private _map = _density_map get "CIV";
        private _values = (values _map) apply { _x select 0 };
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        private _civ_clusters = [_map, "CIV", _uq] call pcb_fnc_merge_clusters;
        [_map, _size, _uq, "colorBLUE"] call pcb_fnc_plot_density;
        [_civ_clusters, "CIV"] call pcb_fnc_plot_clusters_and_create_triggers;

        _map = _density_map get "MIL";
        _values = (values _map) apply { _x select 0 };
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        private _mil_clusters = [_map, "MIL", _uq] call pcb_fnc_merge_clusters;
        [_map, _size, _uq, "colorRED"] call pcb_fnc_plot_density;
        [_mil_clusters, "MIL"] call pcb_fnc_plot_clusters_and_create_triggers;
/*
        _map = _density_map get "IND";
        _values = (values _map) apply { _x select 0 };
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        private _ind_clusters = [_map, "IND", _uq] call pcb_fnc_merge_clusters;
        [_map, _size, _uq, "colorGREEN"] call pcb_fnc_plot_density;
        [_ind_clusters, "IND"] call pcb_fnc_plot_clusters_and_create_triggers;
*/
    };
};
