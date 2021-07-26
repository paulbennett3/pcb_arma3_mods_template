/* ******************************************************************
                          set rating

Given a "rating" value and a unit, set the units rating to that
value.  Used to reward for completed mission, or possibly punish?
****************************************************************** */
params ["_new_rating", "_unit"];

private _cur_rating = rating _unit;
private _delta = _new_rating - _cur_rating;
_unit addRating _delta;
