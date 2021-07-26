// Test if there are any players in the area specified by trigger _trg 
//  returns true if there are any playable units (not necessarily just players!)
//
// _area -- trigger (assumed to be with circle with radius 2000
//         OR [_center, _radius]

params ["_area"];
if ((count _area) < 6) then {
    // convert to [[x, y, z], a, b, dir, rect?, c]
    _area = [(_area select 0), (_area select 1), (_area select 1), 0, false, -1];
};
private _inArea = playableUnits inAreaArray _area;
private _result = (count _inArea) > 0;

_result
