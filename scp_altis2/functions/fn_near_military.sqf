/* *************************************************************************
                         near military

Given a position, checks the buildings in a 200m radius.  If at least a few
of them are military, this function returns true. 

Params:
   _pos (position) : area in which to check
   _radius (number) : (Optional) search region to check for
   _min_military_buildings (number) : (Optional) minimum number of military
                     buildings in search region to call "true"

Returns:
   boolean : true if near military buildings, false else
************************************************************************* */
params ["_pos", ["_radius", 200], ["_min_military_buildings", 2]];

private _mil_buildings = types_hash get "military buildings";

private _buildings = nearestObjects [_pos, _mil_buildings, _radius];

private _result = (count _buildings) >= _min_military_buildings;

_result
