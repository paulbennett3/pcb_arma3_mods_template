/* ******************************************************************
                      get city positions

Return the *positions* of all cities (towns, villages, named areas, etc)
within area

****************************************************************** */
params ["_pos", ["_radius", worldSize]];

// "Name",
//    "NameLocal",
//    "NameMarine",
private _types = [
    "NameCity",
    "NameCityCapital",
    "NameVillage"
];

private _positions = [];

{
    _positions pushBack (locationPosition _x);
} forEach nearestLocations [_pos, _types, _radius];
_positions
