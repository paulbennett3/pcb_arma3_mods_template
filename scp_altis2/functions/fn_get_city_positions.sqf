/* ******************************************************************
                      get city positions

Return the *positions* of all cities (towns, villages, named areas, etc)
within area

****************************************************************** */
params ["_pos", ["_radius", worldSize]];

private _types = types_hash get "city types";
private _positions = [];

{
    _positions pushBack (locationPosition _x);
systemChat ((str _x) + " :: " + (str (size _x)));
} forEach nearestLocations [_pos, _types, _radius];
_positions
