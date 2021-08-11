/* -----------------------------------------------------------
                        group garbage collect

For each group in the list, see if there are any "alive" units.
If not, delete all the units and drop the group from the list
If so, then find the distance to the nearest player.  If greater
than range, delete the units

!!!!! put back in Description.ext !!!!
!!!!! mutex protext this !!!!

Keep criteria
   At least one unit alive
   Closer than X to players
   No farther than mission_radius (is that the constant?) from epicenter

Input and output is via the global variable "group_stack"
----------------------------------------------------------- */

private _min_range_to_pc = 5000;

// ----------------------------------
// mutex stuff
// ----------------------------------
private _my_mutex_id = "group_gc_id";

if (isNil "group_mutex") then {
    group_mutex = ["create", _my_mutex_id] call pcb_fnc_mutex;
    publicVariable "group_mutex";
};
waitUntil { ! isNil "group_mutex"; };

// now take the mutex -- will pend until taken
["get", _my_mutex_id, group_mutex] call pcb_fnc_mutex;
// ----------------------------------

// get the distribution of ages of the groups
private _time_now = serverTime;
private _ages = group_stack apply { _time_now - (_x select 1) }; 

sleep .1;

// get the distribution of distances from nearest pc of the groups
private _distances = group_stack apply {
    private _distance = worldSize;
    private _g = _x select 0;
    private _alive = (units _g) select { alive _x };
    if ((count _alive) > 0) then {
        private _pos = getPosATL (_alive select 0);
        _distance = selectMin (playableUnits apply { _pos distance2D _x }); 
    };
    _distance
};
sleep .1;
private _temp_ages = +_ages;
private _temp_distances = +_distances;
_temp_ages sort true;
_temp_distances sort true;

// we'll use the median as our threshold for old and far
private _old = _temp_ages select (floor ((count _temp_ages) / 2));
private _far = _temp_distances select (floor ((count _temp_distances) / 2));
["Old is <" + (str _old) + ">, far is <" + (str _far) + ">"] call pcb_fnc_debug;
["Age Range: " + (str (selectMin _temp_ages)) + " " + (str (selectMax _temp_ages))] call pcb_fnc_debug;
["Distance Range: " + (str (selectMin _temp_distances)) + " " + (str (selectMax _temp_distances))] call pcb_fnc_debug;
sleep .1;

private _original_count = count group_stack;

private _keep_list = [];
private _idx = 0;
for [{_idx = 0}, {_idx < (count group_stack)}, {_idx = _idx + 1}] do {
    private _group = (group_stack select _idx) select 0;
    private _age = _ages select _idx;
    private _distance = _distances select _idx;

    private _alive = (units _group) select { alive _x };
    if ((count _alive) > 0) then {
        private _keep = false;
        // if it is older and farther than the median, delete them
        if ((_age > _old) && (_distance > _far)) then {
             (units _group) apply { deleteVehicle _x }; 
        } else {
            _keep_list pushBackUnique [_group, _age];
        };
    }; 
};

// update our stack 
group_stack = +_keep_list;

private _final_count = count group_stack;
["Group Garbage Collection: <" + (str _original_count) + "> -> <" + (str _final_count) + ">"] call pcb_fnc_debug;

// ------------------------
// release our mutex
// ------------------------
["release", _my_mutex_id, group_mutex] call pcb_fnc_mutex;

