// Given a player, a position, and a angle in degrees, return true
//  if the position is within +/- (angle/2) directly in front of player
params ["_player", "_pos", ["_angle", 90]]; 
private _relDir = _player getRelDir _pos; 
private _half_angle = _angle / 2;
private _result = (_relDir > (360 - _half_angle)) or (_relDir < _half_angle); 
_result
