/* ****************************************************************************
                        will fit in hangar

Test if the given object type will fit in the given hangar

Parameters:
    _hangar (object) : building to try to fit object into
    _obj (object) : thing (object) to fit in _hangar
    _type (string) : type string of object, for debug

Returns:
   bool :  true if it seems like it will fit, false else
**************************************************************************** */
params ["_hangar", "_obj", "_type"];

private _will_fit = true;

// ----------------------------
// ----------------------------
private _hangar_type = typeOf _hangar;

// gets the X, Y, and Z dimensions of the bounding boxes
private _hdims = _hangar call BIS_fnc_boundingBoxDimensions;

if (_hangar_type isEqualTo "Land_Airport_01_hangar_F") then {
    private _temp = "Land_TentHangar_V1_F" createVehicle [0, 0, 0];
    _hdims = _temp call BIS_fnc_boundingBoxDimensions;
    deleteVehicle _temp;
};

private _odims = _obj call BIS_fnc_boundingBoxDimensions;

// add some margins
private _margin = 2;
_odims = _odims vectorAdd [_margin, _margin, _margin];
private _too_big = (_hdims vectorDiff _odims) select { _x < 0 };
if ((count _too_big) > 0) then {
    _will_fit = false;
};

_will_fit
