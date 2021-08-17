// Returns true if player is in a vehicle
params ["_player"];
private _vehicle = objectParent _player;
private _in_vehicle = ! (isNull _vehicle);

private _result = [_in_vehicle, [_vehicle]];
_result
