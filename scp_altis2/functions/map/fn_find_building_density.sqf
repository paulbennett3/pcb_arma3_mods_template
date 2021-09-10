/* *******************************************************************
                      find building density 

Using the path in the "model" name of buildings, return the
density of clusters of buildings

Parameters:
    _size (number) : size of "cells" to use, in meters
******************************************************************* */
params ["_size"];


// temporary, local mapping
private _building_type_class = createHashMap;

// more long term info -- for use by other functions
building_info_map = createHashMap;

private _density_map = createHashMap;
_density_map set ["MIL", createHashMap];
_density_map set ["CIV", createHashMap];
_density_map set ["IND", createHashMap];
_density_map set ["UNK", createHashMap];

private _center = [worldSize / 2, worldSize / 2];

private _buildings = (_center nearObjects ["House", worldSize]);
sleep .1;
_buildings = _buildings + (_center nearObjects ["Building", worldSize]);
sleep .1;

// make sure we only have unique entries
_buildings = _buildings arrayIntersect _buildings;
sleep .1;

// use this to keep lists of specific buildings / types of buildings
private _hangar_types = (types_hash get "hangars") apply { toLowerANSI _x };
hangar_list = [];

if (! isNil "_buildings") then {
    private _bidx = 0;
    for [{_bidx = 0}, { _bidx < (count _buildings) }, { _bidx = _bidx + 1 }] do {
        if ((_bidx % 100) < 1) then { sleep .1; };
        private _x = _buildings select _bidx;
        private _pos = getPosATL _x;
        if (((_pos select 0) > 0) || ((_pos select 1) > 0)) then {
            private _n_pos = count (_x buildingPos -1);    
            if ((isNil "_n_pos") || (_n_pos < 1)) then {
            } else { 
                private _type = typeOf _x;
 
                // track certain types of buildings so we don't have to look for them later ...
                if ((toLowerANSI _type) in _hangar_types) then {
                    hangar_list pushBackUnique _x;
                };

                private _my_class = _building_type_class get _type;
                // have we seen this class of building before? If not, make a note of it
                if (isNil "_my_class") then {
                    _my_class = [_x] call pcb_fnc_building_classifier;
                    _building_type_class set [_type, _my_class];

                    private _positions = _x buildingPos -1;
                    private _zlevels = _positions apply { _x select 2 };
                    _zlevels = _zlevels arrayIntersect _zlevels;
                    private _n = 0;
                    if (_x inArea active_area) then { _n = 1; };
                    
                    building_info_map set [_type, createHashMapFromArray [ 
                        ["type", _type],
                        ["class", _my_class],
                        ["npositions", count _positions],
                        ["zlevels", _zlevels],
                        ["n", _n]
                    ]];
                } else {
                    if (_x inArea active_area) then {
                        // keep track of the number of this type of building we've seen
                        private _temp = building_info_map get _type;
                        private _n = _temp get "n";
                        _temp set ["n", _n + 1];
                    };
                };

                private _xx = floor ((_pos select 0) / _size); 
                private _yy = floor ((_pos select 1) / _size); 
                private _map = _density_map get _my_class;
                private _key = [_xx, _yy];
                private _val = _map getOrDefault [_key, [0, []]];
                private _v = (_val select 0) + 1;
                private _obj_list = _val select 1;
                _obj_list pushBackUnique _x;
                _map set [_key, [_v, _obj_list]];
            };
        };
    }; // forEach _buildings;
};

// let the helicopter thread know we have gathered all the hangars
hangar_list_done = true;

_density_map
