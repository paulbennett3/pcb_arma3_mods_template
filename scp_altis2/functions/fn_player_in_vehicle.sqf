// Returns true if player is in a vehicle
params ["_player"];
private _in_vehicle = false;
private _vehicles = [];

{
    if (_player in _x) then { _in_vehicle = true; _vehicles pushBack _x; };
} forEach ((getPosATL _player) nearObjects ["LandVehicle", 10]);

{
    if (_player in _x) then { _in_vehicle = true; _vehicles pushBack _x; };
} forEach ((getPosATL _player) nearObjects ["Helicopter", 10]);

private _result = [_in_vehicle, _vehicles];
_result
