/* ********************************************************
                 plot density

Params:
   _density_map (hashmap) : keys [_x, _y] 
                           values (number) density (count of positions)
   _size (number) : size of density cell
   _symbol (string) : marker symbol to put in cell
******************************************************** */
params ["_density_map", "_size", "_symbol"];

private _values = values _density_map;
_values sort true;
private _n = count _values;
private _med_index = ceil (_n / 2);
private _qindex = ceil (_n / 4);
private _min = _values select 0;
private _max = _values select (_n - 1);
private _bq = _values select _qindex;
private _mq = _values select _med_index;
private _uq = _values select (_med_index + _qindex - 1);

private _quartiles = [_min, _bq, _mq, _uq, _max];

{
    private _xx = _x select 0;
    private _yy = _x select 1;
    private _val = _density_map get _x;

    private _x0 = (_xx * _size); 
    private _cx = _x0 + (_size / 2); 
    private _y0 = (_yy * _size); 
    private _cy = _y0 + (_size / 2); 

    private _markerColor = "";

    if (_val <= _min) then { 
        _markerColor = "";
    } else {
        if (_val < _bq) then { 
            _markerColor = "colorGREEN"; 
        } else {
            if (_val < _mq) then { 
            _markerColor = "colorYELLOW"; 
            } else {
                if (_val < _uq) then { 
                    _markerColor = "colorORANGE"; 
                } else {
                    _markerColor = "colorRED"; 
               };
            };
        };
    };
    if (! (_markerColor isEqualTo "")) then {
        private _marker = createMarker ["M" + (str _x), [_cx, _cy]];
        _marker setMarkerShape "RECTANGLE";
        _marker setMarkerSize [_size / 2, _size / 2];
        _marker setMarkerAlpha 0.5;
        _marker setMarkerColor _markerColor;
    };
} forEach keys _density_map;

_quartiles
