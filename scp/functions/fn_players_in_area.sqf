// Test if there are any players in the area specified by [pos, radius]
//  returns true if there are any playable units (not necessarily just players!)
//
// _center is position or object

params ["_center", ["_radius", 2000]];

private _area = [_center, _radius, _radius];
private _inArea = playableUnits inAreaArray _area;
private _result = (count _inArea) > 0;

_result
