/* ********************************************************
                   show cities
******************************************************** */


[] spawn {
    // https://community.bistudio.com/wiki/Arma_3:_CfgPatches_CfgVehicles#A3_Structures_F_Mil_Cargo

    // -------------------------
    // find all "military bases"
    // -------------------------
    ["finding clusters of military buildings"] call pcb_fnc_debug;

    private _types = types_hash get "military buildings"; 
    private _mil_result = [
        _types, 
        world_center, 
        worldSize, 
        200, 
        3
    ] call pcb_fnc_find_object_clusters;


    {
        private _cluster = _mil_result get _x;
        private _center = _cluster get "center";
        private _marker = createMarker ["MILCLUST" + (str _x), _center];
        _marker setMarkerType "b_motor_inf";
        _marker = createMarker ["MILCLUSTB" + (str _x), _center];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerSizeLocal [_cluster get "a", _cluster get "b"];
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorRED";
    } forEach (keys _mil_result);

    ["done finding clusters of military buildings"] call pcb_fnc_debug;

    // -------------------------
    // Find all "towns"
    // -------------------------
    ["finding clusters of civ buildings"] call pcb_fnc_debug;
    _types = types_hash get "city buildings";
    _civ_result = [
        _types, 
        world_center, 
        worldSize, 
        200, 
        12 
    ] call pcb_fnc_find_object_clusters;

    {
        private _cluster = _civ_result get _x;
        private _center = _cluster get "center";
        private _marker = createMarker ["CIVCLUST" + (str _x), _center];
        _marker setMarkerType "hd_end";
        _marker = createMarker ["CIVCLUSTB" + (str _x), _center];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerSizeLocal [_cluster get "a", _cluster get "b"];
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorBLUE";
    } forEach _civ_result;

    ["done finding clusters of civ buildings"] call pcb_fnc_debug;

 };


