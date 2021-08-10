[] spawn {
    private _size = 200;
    private _density_map = [_size] call pcb_fnc_find_building_density;
    if (isNil "_density_map") then {
        ["Failed to generate density map"] remoteExec ["systemChat", 0];
    } else {
        private _map = _density_map get "CIV";
        private _values = values _map;
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        [_map, _size, _uq, "colorBLUE"] call pcb_fnc_plot_density;

        _map = _density_map get "MIL";
        _values = values _map;
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        [_map, _size, _uq, "colorRED"] call pcb_fnc_plot_density;

        _map = _density_map get "IND";
        _values = values _map;
        _values sort true;
        private _uq = _values select (floor (3* (count _values) / 4));
        [_map, _size, _uq, "colorGREEN"] call pcb_fnc_plot_density;
    };
};
