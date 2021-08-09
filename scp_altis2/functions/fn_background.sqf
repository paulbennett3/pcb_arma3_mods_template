/* --------------------------------------------------------------------
                          background

Setup (and spawn if needed) the "background" -- what is going on
besides / in addition to the mission(s)


!!! Uses start_pos, "mACTIVE"
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

waitUntil { ! isNil "random_start_ready" };
waitUntil { ! isNil "start_pos" };
waitUntil { ! isNil "start_dir" };
waitUntil { ! isNil "active_area" };


/* ########################################################
                    Background 

This code generates a list of all the clusters of city
buildings and military buildings (by proxy, cities and
bases).  This takes a few minutes to run ...

Once that data is gathered, it runs in a loop every second,
checking if there are players in the area.  If so, it spawns
spare vehicles and encounters.
######################################################## */
[active_area] spawn {
    params ["_active_area"];
    private _buffer = 500;
    sleep 10;

    // flag to let other modules know we are done grinding ...
    background_clustering_done = false;
    publicVariable "background_clustering_done";

    // -----------------------------------------------
    // generate "spare" helicopters
    // -----------------------------------------------
    [] spawn {
        ["Spawning helicopters"] call pcb_fnc_debug;
        [] call pcb_fnc_spawn_spare_helicopters;
    };

    // -----------------------------------------------
    //   Find clusters of cities and military buildings
    // -----------------------------------------------
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
        3,
        "mil"
    ] call pcb_fnc_find_object_clusters;

    private _trigger_list = [];
    bck_trg_fired = [];
    publicVariable "bck_trg_fired";

    {
        private _cluster = _mil_result get _x;
        private _center = _cluster get "center";
        private _a = (_cluster get "a") + _buffer;
        private _b = (_cluster get "b") + _buffer;
        private _trg = createTrigger ["EmptyDetector", _center, false];    
        _trg setVariable ["cid", [_cluster get "label", _x]];
        _trg setTriggerArea [_a, _b, 0, false, -1];
        private _area = [_center] + (triggerArea _trg);


        if (true) then {
            _trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
            _trg setTriggerStatements [
                "this",
                "bck_trg_fired pushBackUnique (thisTrigger getVariable 'cid'); publicVariable 'bck_trg_fired';",
                ""
            ];
            _trg setTriggerInterval 2;
            _trigger_list pushBack _trg;
        } else {
            deleteVehicle _trg;
        };
        
        if (pcb_DEBUG) then {
            private _marker = createMarker ["MILCLUST" + (str _x), _center];
            _marker setMarkerType "b_motor_inf";
            _marker = createMarker ["MILCLUSTB" + (str _x), _center];
            _marker setMarkerShapeLocal "ELLIPSE";
            _marker setMarkerSizeLocal [_a, _b];
            _marker setMarkerBrushLocal "BORDER";
            _marker setMarkerAlphaLocal 0.9;
            _marker setMarkerColor "ColorRED";
        };

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
        12,
        "city" 
    ] call pcb_fnc_find_object_clusters;

    {
        private _cluster = _civ_result get _x;
        private _center = _cluster get "center";
        private _a = (_cluster get "a") + _buffer;
        private _b = (_cluster get "b") + _buffer;
        private _trg = createTrigger ["EmptyDetector", _center, false];    
        _trg setVariable ["cid", [_cluster get "label", _x]];
        _trg setTriggerArea [_a, _b, 0, false, -1];
        private _area = [_center] + (triggerArea _trg);

        if (true) then {
            _trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
            _trg setTriggerStatements [
                "this",
                "bck_trg_fired pushBackUnique (thisTrigger getVariable 'cid'); publicVariable 'bck_trg_fired';",
                ""
            ];
            _trg setTriggerInterval 2;
            _trigger_list pushBack _trg;
        } else {
            deleteVehicle _trg;
        };
        
        if (pcb_DEBUG) then {
            private _marker = createMarker ["CIVCLUST" + (str _x), _center];
            _marker setMarkerType "hd_end";
            _marker = createMarker ["CIVCLUSTB" + (str _x), _center];
            _marker setMarkerShapeLocal "ELLIPSE";
            _marker setMarkerSizeLocal [_a, _b];
            _marker setMarkerBrushLocal "BORDER";
            _marker setMarkerAlphaLocal 0.9;
            _marker setMarkerColor "ColorRED";
        };
    } forEach _civ_result;

    ["done finding clusters of civ buildings"] call pcb_fnc_debug;

    // let other modules know we are ready to roll!
    background_clustering_done = true;
    publicVariable "background_clustering_done";


    // -----------------------------------------------
    // Now that we have the location information,
    // we'll start monitoring the player positions
    // and only spawn when they are close to them
    // -----------------------------------------------
    ["Starting 'background' loop"] call pcb_fnc_debug;
    private _done = false;
    while {! _done} do {
        private _code = {
            params ["_types", "_n", "_pos", "_side"];
            private _group = createGroup _side;
            for [{_ij = 0 }, {_ij < _n}, {_ij = _ij + 1}] do {
                private _type = selectRandom _types;
                private _veh = _group createUnit [_type, _pos, [], 50, 'NONE'];
                _veh triggerDynamicSimulation false; // won't wake up enemy units:wq
                [_veh] joinSilent _group;
            };
            [_group] call pcb_fnc_log_group;

            [_group, _pos] call BIS_fnc_taskDefend;
            sleep .1;
        };

        waitUntil { sleep 1; (count bck_trg_fired) > 0 };
       
        // we know one of our triggers fired, and we have its label and
        // cluster id.
        private _cid = bck_trg_fired select 0;
        bck_trg_fired deleteAt 0;
        publicVariable "bck_trg_fired";

        ["Background trigger <" + (str _cid) + "> fired"] call pcb_fnc_debug;
        private _label = _cid select 0;
        private _cluster_num = _cid select 1;
        private _cluster = objNull;
        private _chance = .05;
        if (_label isEqualTo "mil") then {
            _chance = .15;
            _cluster = _mil_result get _cluster_num;
        } else {
            _cluster = _civ_result get _cluster_num;
        };

        // ---------------------------------------------------------
        //                    spawn spare vehicles
        //
        // spawn this so if it dies, our monitor doesn't die too ...
        // ---------------------------------------------------------
        [_cluster get "obj_list", _chance, _label] call pcb_fnc_spawn_spare_vehicles;

        // ---------------------------------------------------------
        //                     spawn inhabitants
        //
        // ---------------------------------------------------------
        [_cluster get "obj_list", _code, _label, _cluster] call pcb_fnc_spawn_cluster_inhabitants;
    }; // while
}; // spawn

