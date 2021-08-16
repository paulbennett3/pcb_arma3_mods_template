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
waitUntil { ! isNil "group_stack" };


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


    // get density of clustered buildings by "class" (MIL, CIV, IND, UNK)
    map_inspector_done = false;
    [] call pcb_fnc_map_inspector;
    waitUntil { sleep 1; map_inspector_done };

    bck_trg_fired = [];
    publicVariable "bck_trg_fired";

    // let other modules know we are ready to roll!
    background_clustering_done = true;
    publicVariable "background_clustering_done";

    // pick a few clusters to be insurgent / zombie / ... areas
    private _n_special_clusters = 5;
    private _special_clusters = createHashMap;
    private _scdx = 0;
    for [{_scdx = 0}, {_scdx < _n_special_clusters}, {_scdx = _scdx + 1}] do {
        private _map_type = selectRandom [
            [mil_clusters, "MIL"],
            [civ_clusters, "CIV"],
            [ind_clusters, "IND"]
        ];
        private _map = _map_type select 0;
        private _label = _map_type select 1;

        [_special_clusters, _map, _label] call pcb_fnc_make_special_cluster;
    };

    // -----------------------------------------------
    // Now that we have the location information,
    // we'll start monitoring the player positions
    // and only spawn when they are close to them
    // -----------------------------------------------
    ["Starting 'background' loop"] call pcb_fnc_debug;
    private _done = false;
    while {! _done} do {
        waitUntil { sleep 1; (count bck_trg_fired) > 0 };
       
        // we know one of our triggers fired, and we have its label and
        // cluster id.
        private _cid = bck_trg_fired select 0;
        bck_trg_fired deleteAt 0;
        publicVariable "bck_trg_fired";

        ["Background trigger <" + (str _cid) + "> fired"] call pcb_fnc_debug;
        private _label = _cid select 0;
        if (_cid in _special_clusters) then {
            ["Special Cluster fired"] call pcb_fnc_debug;
        } else {
            private _cluster_num = _cid select 1;
            private _cluster = objNull;
            private _chance = .10;
            if (_label isEqualTo "MIL") then {
                _chance = .15;
                _cluster = mil_clusters get _cluster_num;
            } else {
                if (_label isEqualTo "IND") then {
                    _cluster = ind_clusters get _cluster_num;
                } else {
                    _cluster = civ_clusters get _cluster_num;
                };
            };

            if ((_label isEqualTo "MIL") || (_label isEqualTo "CIV")) then {
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
                [_cluster get "obj_list", _label, _cluster] call pcb_fnc_spawn_cluster_inhabitants;
            } else { // IND
                [_cluster get "obj_list", _label, _cluster] call pcb_fnc_spawn_cluster_inhabitants_ind;
            };
        };
    }; // while
}; // spawn

