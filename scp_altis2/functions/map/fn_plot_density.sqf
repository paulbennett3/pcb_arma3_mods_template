/* ********************************************************
                 plot density

Params:
   _density_map (hashmap) : keys [_x, _y] 
                           values (number) density (count of positions)
   _size (number) : size of density cell
   _symbol (string) : marker symbol to put in cell
******************************************************** */
params ["_density_map", "_size", "_threshold", "_color"];


{
    private _xx = _x select 0;
    private _yy = _x select 1;
    private _val = (_density_map get _x) select 0;

    if (_val >= _threshold) then {
        private _x0 = (_xx * _size); 
        private _cx = _x0 + (_size / 2); 
        private _y0 = (_yy * _size); 
        private _cy = _y0 + (_size / 2); 

        private _marker = createMarker ["M" + (str _x), [_cx, _cy]];
        _marker setMarkerShape "RECTANGLE";
        _marker setMarkerSize [_size / 2, _size / 2];
        _marker setMarkerAlpha 0.5;
        _marker setMarkerColor _color; 
    };
} forEach keys _density_map;
