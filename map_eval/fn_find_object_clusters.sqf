/* ********************************************************
                  find object clusters

Given a list of classes (not types!), find clusters
of those clases and return them.

!!!!! not thread safe !!!!!! Use at own risk ...
(uses globals for flags and return value -- running more than 
one search at a time will cause havoc ...)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Params:
    _types (list of strings) : classes to search for
    _target (position) : center to search from
    _search_radius (number) : (optional) distance to search for
            defaults to worldSize
    _cluster_radius (number) : (optional) initial distance inside cluster search (might expand) 
            defaults to 200m
    _min_cluster_size (number) : (optional) minimum number of items in cluster to be considered
            a cluster.  Defaults to 3.

Returns:
   Since this could take awhile, it sets the publicVariable "cluster_search_done" to false,
    then when finished sets it to true, and puts results in publicVariable "cluster_search_results".

    The search results are a HashMap, keyed by the cluster number (simple 1 up count).
        The values are also a HashMap, with the following keys:
            cluster_number (number) : same as the 1 up count used to access this
            center (pos 2d): position of barycenter of cluster
            obj_list (list of objects) : list of all objects included in the cluster

        Example:
            [ ["Land_Dome_Small_F", "Land_Dome_Big_F"], getPosATL player] call pcb_fnc_find_object_clusters;
            sleep 5;
            waitUntil { sleep 1; not (isNil "cluster_search_done") };
            waitUntil { sleep 1; cluster_search_done };
            private _results = cluster_search_results;

See the following pages for groups of class types (ie, military cargo bases, cemetary items, ...)
 https://community.bistudio.com/wiki/Arma_3:_CfgPatches_CfgVehicles#A3_Structures_F_Mil_Cargo
******************************************************** */

params ["_types", "_target", ["_search_radius", worldSize], ["_cluster_radius", 200], ["_min_cluster_size", 3]];

cluster_search_done = false;
publicVariable "cluster_search_done";

[_types, _target, _search_radius, _cluster_radius, _min_cluster_size] spawn {
    params ["_types", "_target", "_search_radius", "_cluster_radius", "_min_cluster_size"];

    cluster_search_results = createHashMap;

    private _exclude = createHashMap;
    private _clusters = createHashMap;
    private _RADIUS = _cluster_radius;
    private _MIN_CLUSTER_SIZE = _min_cluster_size;
    private _cluster_count = -1;

    {
        private _pos = getPosATL _x;

        // does it have a valid position?
        if (((_pos select 0) > 0) || ((_pos select 1) > 0)) then {
            // only process if we haven't seen it before
            if (! ((str _x) in _exclude)) then {
                // make a list of all the objects in the cluster-in-potentia
                private _cluster_objs = [];
                private _cnum = -1;

                private _objects = nearestObjects [_pos, _types, _RADIUS];
                private _bc_n = count _objects;
 
                for [{_i = 0 }, {_i < _bc_n}, {_i = _i + 1}] do { 
                    private _obj = _objects select _i;
                    _pos = getPosATL _obj;
                    if (((_pos select 0) > 0) || ((_pos select 1) > 0)) then {
                        if (! ((str _obj) in _exclude)) then {
                            _cluster_objs pushBackUnique _obj;
                            _exclude set [(str _obj), [_obj, _cluster_count]]; // mark which cluster it is in
                        } else {
                            _cnum = (_exclude get (str _obj)) select 1; 
                        };
                    };
                };
                // did we find a cluster to extend?
                if (_cnum > -1) then {
                    
                } else {
                    // this appears to be a new cluster, yay!
                    _cluster_count = _cluster_count + 1;
                    _clusters set [_cluster_count, _cluster_objs];  // key is cluster number, value is list of objs in cluster
                };

               sleep 0.1;
            };
        };
    } forEach nearestObjects [_target, _types, _search_radius];

    // if we found any clusters, evaluate them!
    if (_cluster_count > -1) then {
        {
            private _obj_list = _clusters get _x;

            private _bc_n = count _obj_list;
            private _bc_x = 0;
            private _bc_y = 0;
            if (_bc_n >= _MIN_CLUSTER_SIZE) then {
                // loop over all objects in cluster
                for [{_i = 0 }, {_i < _bc_n}, {_i = _i + 1}] do { 
                    private _obj = _obj_list select _i;
                    private _pos = getPosATL _obj;
                    _bc_x = _bc_x + (_pos select 0);
                    _bc_y = _bc_y + (_pos select 1);
                };

             
                private _barycenter = [(_bc_x / _bc_n), (_bc_y / _bc_n)];

                private _temp = createHashMap;
                _temp set ["cluster_number", _x]; 
                _temp set ["center", _barycenter]; 
                _temp set ["obj_list", _obj_list]; 
                cluster_search_results set [_x, _temp];
             };
        } forEach (keys _clusters);
    };

    publicVariable "cluster_search_results";
    sleep 0.1;

    cluster_search_done = true;
    publicVariable "cluster_search_done";
 };


