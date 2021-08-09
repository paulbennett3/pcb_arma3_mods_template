[] spawn {

    building_type_hash = CreateHashMap;
    building_npos_hash = CreateHashMap;
    building_type_config_hash = CreateHashMap;

    private _center = [worldSize / 2, worldSize / 2];

    private _buildings = _center nearObjects ["Building", worldSize];
    if (! isNil "_buildings") then {
        ["Found " + (str (count _buildings)) + " buildings"] remoteExec ["systemChat", 0];
        {
            private _n_pos = count (_x buildingPos -1);    
            if (isNil "_n_pos") then { _n_pos = -1; };
            private _type = typeOf _x;
            private _type_list = building_type_hash getOrDefault [_n_pos, []];
            _type_list pushBackUnique _type;
            building_type_hash set [_n_pos, _type_list];
            building_npos_hash set [_n_pos, (building_npos_hash getOrDefault [_n_pos, 0]) + 1];

            private _config = configOf _x;
            if (! isNil "_config") then {
                building_type_config_hash set [_type, _config];
            };
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
            [_type + " " + (str ([building_type_config_hash get _type, true] call BIS_fnc_returnParents))] remoteExec ["systemChat", 0];
        } forEach [0, 1, 2]; // top n sizes
    } else {
        ["No buildings found" + (str _sizes)] remoteExec ["systemChat", 0];
    };
};
