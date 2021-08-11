/* ********************************************************************
                       merge clusters

Given a density map, merge neighboring clusters into a single cluster.

Parameters:
   _map (hashmap) : a density map for a single class (ie, "MIL", "CIV", ...)
          keys are [_xx, _yy], where the corner of the _size x _size cell
            is (_xx * _size, _yy * _size), and the opposite corner is
               (_xx * _size + _size, _yy * _size + _size)
          values are [ cluster value, [ building objects ]]
   _label (string) : the label to attach to the clusters ("MIL", "CIV", "IND", "UNK")
   _threshold (number) : only consider clusters with this density level or higher

Returns:
   clusters (hashmap)
       keys are the cluster index ("MIL" + (str index)), for example
       values are another hashmap, with:
           center (the barycenter of the cluster)
           a,b (the a and be elipse values)
           rot (rotation of the ellipse)
           obj_list (list of buildings in the cluster)
           label ("MIL", "CIV", "IND", "UNK") 
******************************************************************** */
params ["_map", "_class", "_threshold"];

// get a list of all our cells ([x, y])
//    filtered by if the density is at or above the threshold
private _cells = (keys _map) select { ((_map get _x) select 0) >= _threshold };

// list of "visited" cells
private _visited = createHashMap;

// indices of the 8 surrounding "neighbor" cells
private _neighbors = [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0], [1, 0],
    [-1, 1], [0, 1], [1, 1]
];

// we'll accumulate our "clusters" (here they will be lists of cell indices)
private _clusters = [];

// until we'v processed them all ...
while { sleep .1; (count _cells) > 0 } do {

    // remove the first cell in our list, and start a new cluster
    private _cell = _cells deleteAt 0;
    if (! (_cell in _visited)) then {
        private _stack = [ _cell ];
        private _cluster = [];
 
        while { sleep .1; (count _stack) > 0 } do {
            // pop the first entry
            private _current = (_stack deleteAt 0);
            if (! (_current in _visited)) then {
                private _cx = _current select 0;
                private _cy = _current select 1;

                // add it to our cluster
                _cluster pushBackUnique _current;

                // remember that we've seen it
                _visited set [_current, true];
    
                // find all neighbors
                private _ndx = 0;
                for [{_ndx = 0}, {_ndx < (count _neighbors)}, {_ndx = _ndx + 1}] do {
                    private _x = _neighbors select _ndx;
                    private _key = [_cx + (_x select 0), _cy + (_x select 1)];
                    private _index = _cells find _key;
                    if (_index > -1) then {
                        // remove from _cells
                        private _temp = _cells deleteAt _index;
    
                        // add to _stack
                        if (! (_temp in _visited)) then {
                            _stack pushBackUnique _temp;
                        };
                    };   
                 }; // forEach _neighbors;
            }; // check the current inner cell for if we've seen it already
        };  // inner while as we process this cluster

        _clusters pushBack _cluster;
    };  // test for if we've seen this cell already
};  // outer while on all cells in density map

// turn our list of cluster indices into our "clusters" structure
private _cluster_map = createHashMap;

private _cluster_count = 0;
for [{_cluster_count = 0 }, {_cluster_count < (count _clusters)}, {_cluster_count = _cluster_count + 1}] do {
    private _key_list = _clusters select _cluster_count;
    private _cid = _class + (str _cluster_count);

    // accumulate all the buildings across the cluster
    private _obj_list = [];
    private _odx = 0;
    for [{_odx = 0}, {_odx < (count _key_list)}, {_odx = _odx + 1}] do {
        if ((_odx % 100) < 1) then { sleep .1; };
        private _x = _key_list select _odx; 
        _obj_list = _obj_list + ((_map get _x) select 1);
    }; // forEach _key_list;

    // make sure we only have unique items in the list!
    _obj_list = _obj_list arrayIntersect _obj_list;

    // find the center and bounds
    private _xacc = 0;  
    private _yacc = 0;  
    private _xs = [];
    private _ys = [];

    private _n = 0;

    private _jdx = 0;
    for [{_jdx = 0}, {_jdx < (count _obj_list) }, {_jdx = _jdx + 1}] do {
        if ((_jdx % 100) < 1) then { sleep .1; };
        private _x = _obj_list select _jdx;
        private _pos = getPosATL _x;
        if ([_pos] call pcb_fnc_is_valid_position) then {
            _n = _n + 1;
            private _xval = (_pos select 0);
            private _yval = (_pos select 1);
            _xacc = _xacc + _xval; _xs pushBackUnique _xval;
            _yacc = _yacc + _yval; _ys pushBackUnique _yval;
        }; 
    }; // forEach _obj_list;

    private _center = [_xacc / _n, _yacc / _n];
    // only use clusters in our active area
    if (_center inArea "mActive") then {
        private _minx = selectMin _xs;
        private _maxx = selectMax _xs;
        private _miny = selectMin _ys;
        private _maxy = selectMax _ys;
        private _a = (_maxx - _minx) / 2;
        private _b = (_maxy - _miny) / 2;

        private _cluster = createHashMapFromArray [
            ["center", _center],
            ["a", _a],
            ["b", _b],
            ["obj_list", _obj_list],
            ["label", _class]
        ];
   
        _cluster_map set [_cid, _cluster]; 
    };
};

_cluster_map
