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
        _trg setTriggerArea [_a, _b, 0, true, -1];
        private _area = [_center] + (triggerArea _trg);
        //if ( ! ([_area] call pcb_fnc_players_in_area)) then {
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
            _marker setMarkerShapeLocal "RECTANGLE";
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
        _trg setTriggerArea [_a, _b, 0, true, -1];
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
            _marker setMarkerShapeLocal "RECTANGLE";
            _marker setMarkerSizeLocal [_a, _b];
            _marker setMarkerBrushLocal "BORDER";
            _marker setMarkerAlphaLocal 0.9;
            _marker setMarkerColor "ColorRED";
        };
    } forEach _civ_result;

    ["done finding clusters of civ buildings"] call pcb_fnc_debug;

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
            for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
                private _type = selectRandom _types;
                private _veh = _group createUnit [_type, _pos, [], 50, 'NONE'];
                _veh triggerDynamicSimulation false; // won't wake up enemy units:wq
                [_veh] joinSilent _group;
            };

            // there is a limit to the number of groups, so we will mark this to delete
            //  when empty
            _group deleteGroupWhenEmpty true;

            _group enableDynamicSimulation true;
            [_group, _pos] call BIS_fnc_taskDefend;
            sleep .1;
        };

        waitUntil { (count bck_trg_fired) > 0 };
       
        // we know one of our triggers fired, and we have its label and
        // cluster id.
        private _cid = bck_trg_fired select 0;
        bck_trg_fired deleteAt 0;
        publicVariable "bck_trg_fired";

        ["Background trigger <" + (str _cid) + "> fired"] call pcb_fnc_debug;
        private _label = _cid select 0;
        private _cluster_num = _cid select 1;
        private _cluster = objNull;
        if (_label isEqualTo "mil") then {
            _cluster = _mil_result get _cluster_num;
        } else {
            _cluster = _civ_result get _cluster_num;
        };

        // ---------------------------------------------------------
        //                    spawn spare vehicles
        //
        // spawn this so if it dies, our monitor doesn't die too ...
        // ---------------------------------------------------------
        [_cluster get "obj_list", 0.10, _label] spawn {
            params ["_buildings", "_chance", "_label"];
            private _civ = true;
            if (_label isEqualTo "mil") then { _civ = false; }; 

            private _n_buildings = count _buildings;
            private _n = ceil (_n_buildings * _chance);
            ["There are <" + (str _n_buildings) + "> buildings in this cluster, will spawn <" + (str _n) + ">"] call pcb_fnc_debug;
            while { _n > 0 } do {
                private _veh = [[], _buildings, true, _civ] call pcb_fnc_spawn_random_vehicle;

                if (! (isNull _veh)) then {
                    _n = _n - 1;
                    [_veh, 1 + (ceil (random 5))] call pcb_fnc_loot_crate;

                    if (pcb_DEBUG) then {
                        // add a marker for reference
                        private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
                        private _m = createMarker [_mn, getPosATL _veh];
                        _mn setMarkerShapeLocal "ELLIPSE";
                        _mn setMarkerColorLocal "ColorBLACK";
                        _mn setMarkerSizeLocal [50, 50];
                        _mn setMarkerAlpha 0.9;
                    };
                }; // if (! (isNull
            };  // while
        };  // spawn

        // ---------------------------------------------------------
        //                     spawn inhabitants
        //
        // ---------------------------------------------------------
        [_cluster get "obj_list", _code, _label, _cluster] spawn {
            params ["_buildings", "_spawn_code", "_label", "_cluster"];

            // we'll scale encounter size by number of buildings
            private _scale = ceil ((count _buildings) / 10);
            // but cap it for sanity ...
            if (_scale > 20) then { _scale = 20; };

            // -----------------------------------------
            // if it is military, do some cargo crates
            // -----------------------------------------
            if (_label isEqualTo "mil") then {
                private _crates = types_hash get "resupply crates";
                {
                    private _building = _x; 
                    private _positions = [_building] call BIS_fnc_buildingPositions;
                    for [{_i = 0 }, {_i < (ceil (random ((count _positions)/2)))}, {_i = _i + 1}] do {
                        private _pos = selectRandom _positions;
                        if ([_pos] call pcb_fnc_is_valid_position) then {
                            private _object_type = selectRandom _crates;
                            _target = _object_type createVehicle [0, 0, 0];
                            _target setPos _pos;
                        };
                    };
                } forEach _buildings;
            } else {
                // spawn some civilians
                if ((random 100) < 50) then {
                    private _types = types_hash get "civilians";
                    for [{_i = 0 }, {_i < (ceil (random (_scale / 2)))}, {_i = _i + 1}] do {
                        private _n = 2 + (ceil (random 3));
                        [_types, _n, getPosATL (selectRandom _buildings), civilian] call _spawn_code;
                    };
                };
            };
          
            // -----------------------------------------
            //  Looters
            // -----------------------------------------
            if ((random 100) < 25) then {
                // so we have looters.  Is this a major or minor infestation?
                if ((random 100) < 20) then {
                    private _types = types_hash get "insurgents";
                    private _n_squads = 2 + (ceil (random _scale));

                    // major -- mark on map
                    ["Warning! Significant insurgent activity in area. Caution advised"] remoteExec ["systemChat", 0];

                    private _marker = createMarker ["ML" + (str ([] call pcb_fnc_get_next_UID)), _cluster get "center"];
                    _marker setMarkerShapeLocal "ELLIPSE";
                    _marker setMarkerSizeLocal [_cluster get "a", _cluster get "b"];
                    _marker setMarkerAlphaLocal 0.5;
                    _marker setMarkerColor "ColorRED";                    

                    for [{_i = 0 }, {_i < _n_squads}, {_i = _i + 1}] do {
                        private _n = 3 + (ceil (random 5));
                        [_types, _n, getPosATL (selectRandom _buildings), east] call _spawn_code;
                    };

                    // if in city, spawn IEDs
                    for [{_i = 0 }, {_i < (ceil (_scale / 2))}, {_i = _i + 1}] do {
                        [getPosATL (selectRandom _buildings), 20, 2 + (ceil (random 5))] call pcb_fnc_mine_road;
                    };

                } else {
                    private _types = types_hash get "looters";
                    private _n = 1 + (ceil ((random _scale) / 2));
                    [_types, _n, getPosATL (selectRandom _buildings), east] call _spawn_code;
                }; // else
            }; // if random looters at all
        }; // while tick ...
    };
}; // spawn

