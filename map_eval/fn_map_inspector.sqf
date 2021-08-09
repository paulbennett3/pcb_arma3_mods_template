[] spawn {

    private _to_model = compile preprocessFileLineNumbers "fn_building_classifier.sqf";

    building_type_hash = CreateHashMap;
    building_npos_hash = CreateHashMap;
    building_type_fields_hash = CreateHashMap;

    //private _size = 1000;
    private _size = 300;
    private _gs = ceil (worldSize / _size);
    density_map = createHashMap;
    density_map set ["MIL", createHashMap];
    density_map set ["CIV", createHashMap];
    density_map set ["IND", createHashMap];
    density_map set ["UNK", createHashMap];

    private _center = [worldSize / 2, worldSize / 2];

    private _buildings = _center nearObjects ["Building", worldSize];
    if (! isNil "_buildings") then {
        ["Found " + (str (count _buildings)) + " buildings"] remoteExec ["systemChat", 0];
        {
            private _n_pos = count (_x buildingPos -1);    
            if (isNil "_n_pos") then { _n_pos = 0; };
            private _type = typeOf _x;
            private _type_list = building_type_hash getOrDefault [_n_pos, []];
            _type_list pushBackUnique _type;
            building_type_hash set [_n_pos, _type_list];
            building_npos_hash set [_n_pos, (building_npos_hash getOrDefault [_n_pos, 0]) + 1];

            private _my_class = [_x] call _to_model;
            building_type_fields_hash set [_type, _my_class];

         
            private _pos = getPosATL _x;
            private _xx = floor ((_pos select 0) / _size); 
            private _yy = floor ((_pos select 1) / _size); 
            private _map = density_map get _my_class;
            private _val = _map getOrDefault [[_xx, _yy], 0];
            _map set [[_xx, _yy], _val + _n_pos + 1];
        } forEach _buildings;
        private _sizes = keys building_npos_hash;
        _sizes sort false;

        ["Building sizes: " + (str _sizes)] remoteExec ["systemChat", 0];
        private _results = [];
        {
            private _size = _sizes select _x;
            private _count = building_npos_hash get _size;
            private _type_list = building_type_hash get _size;
            ["   " + (str _size) + " :: " + (str _count) + " " + (str _type_list)] remoteExec ["systemChat", 0];
            private _type = _type_list select 0; 
            [_type + " " + (str (building_type_fields_hash get _type))] remoteExec ["systemChat", 0];
        } forEach [0, 1, 2]; // top n sizes
    } else {
        ["No buildings found" + (str _sizes)] remoteExec ["systemChat", 0];
    };

    private _map = density_map get "MIL";
    [_map, _size, ""] call compile preprocessFileLineNumbers "fn_plot_density.sqf";
};
