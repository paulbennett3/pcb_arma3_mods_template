/* -----------------------------------------------------------
                        group garbage collect

For each group in the list, see if there are any "alive" units.
If not, delete all the units and drop the group from the list
If so, then find the distance to the nearest player.  If greater
than range, delete the units

!!!!! mutex protext this !!!!

Parameters
   group_list (list of groups): the groups to check

Returns
   revised group_list 
----------------------------------------------------------- */
params ["_group_list", ["_range", 5000]];

private _keep_list = [];
private _idx = 0;
for [{_idx = 0}, {_idx < (count _group_list)}, {_idx = _idx + 1}] do {
    private _group = _group_list select _idx;

    private _alive = (units _group) select { alive _x };
    if ((count _alive) > 0) then {
        private _pos = getPosATL (_alive select 0);
        private _min_dist = selectMin (playableUnits apply { _pos distance2D _x }); 
        if (_min_dist > _range) then {
             (units _group) apply { deleteVehicle _x }; 
        } else {
            _keep_list pushBackUnique _group;
        };
    }; 
};

_keep_list
