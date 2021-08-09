/* *******************************************************************
                      find building density 

Using the path in the "model" name of buildings, return the
density of clusters of buildings

Parameters:
    _size (number) : size of "cells" to use, in meters
******************************************************************* */
params ["_size"];

private _building_type_class = createHashMap;

private _density_map = createHashMap;
_density_map set ["MIL", createHashMap];
_density_map set ["CIV", createHashMap];
_density_map set ["IND", createHashMap];
_density_map set ["UNK", createHashMap];

private _center = [worldSize / 2, worldSize / 2];

private _buildings = (_center nearObjects ["House", worldSize]) +
                     (_center nearObjects ["Building", worldSize]);

// make sure we only have unique entries
_buildings = _buildings arrayIntersect _buildings;

if (! isNil "_buildings") then {
    {
        private _pos = getPosATL _x;
        if (((_pos select 0) > 0) || ((_pos select 1) > 0)) then {
            private _n_pos = count (_x buildingPos -1);    
            if ((isNil "_n_pos") || (_n_pos < 1)) then {
            } else { 
                private _type = typeOf _x;

                private _my_class = _building_type_class get _type;
                if (isNil "_my_class") then {
                    _my_class = [_x] call pcb_fnc_building_classifier;
                    _building_type_class set [_type, _my_class];
                };

                private _xx = floor ((_pos select 0) / _size); 
                private _yy = floor ((_pos select 1) / _size); 
                private _map = _density_map get _my_class;
                private _key = [_xx, _yy];
                private _val = _map getOrDefault [_key, 0];
                //_map set [_key, _val + _n_pos];
                _map set [_key, _val + 1];
            };
        };
    } forEach _buildings;
};
_density_map
