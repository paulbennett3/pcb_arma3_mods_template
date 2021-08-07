/* ******************************************************************
                   fn_enc_compound

Spawn 2 or more encounters and have them interact:
    1x Garrison, 1x seek and destroy
    2x seek and destroy

_player (obj) : playable unit to spawn near
_g1 (list) : [
               _types (list of strings) : types to select from for spawn
               _side (side obj) : which side to spawn on
               _min (number) : minimum number to spawn
               _max (number) : maximum number to spawn
             ]
_g2 (list) : see above
****************************************************************** */
params ["_label", "_player", "_g1", "_g2"];

private _did_spawn = false;

// get the parameters for our first group
private _g1_types = _g1 select 0;
private _g1_side = _g1 select 1;
private _g1_min = _g1 select 2;
private _g1_max = _g1 select 3;

// get the parameters for our second group
private _g2_types = _g2 select 0;
private _g2_side = _g2 select 1;
private _g2_min = _g2 select 2;
private _g2_max = _g2 select 3;

// select random location 
private _vobj = _player;
private _vtemp = [_player] call pcb_fnc_player_in_vehicle;
if (_vtemp select 0) then { _vobj = (_vtemp select 1) select 0; };
private _whitelist = [ [_vobj getRelPos [ENC_DIST, 0], ENC_RADIUS] ];
private _blacklist = [ "water" ];
private _pos = [0, 0];
private _tries = 10;

// did we get a valid position?
while { _tries > 0 } do {
    _pos = [_whitelist, _blacklist] call BIS_fnc_randomPos;
    if (!([_pos] call pcb_fnc_is_valid_position)) then {
        _tries = _tries - 1;
    } else {
        _tries = 0;
    };
};

if (!([_pos] call pcb_fnc_is_valid_position)) exitWith { diag_log "fn_enc_compound- not valid position"; false };

// are there any players in the area?
if ([ [_pos, ENC_MIN_PLAYER_DIST_CREATE] ] call pcb_fnc_players_in_area) exitWith { diag_log "fn_enc_compound - players in range"; false };

private _action = objNull;
private _entry = objNull;
private _building = objNull;


// make a list of all the stuff we spawn
private _obj_list = [];

// ----------------
// build group 1
// ----------------
private _group1_size = _g1_min + (ceil (random (_g1_max - _g1_min)));
private _group1 = createGroup _g1_side;
group_stack pushBackUnique _group1; publicVariable "group_stack";
for [{_i = 0 }, {_i < _group1_size}, {_i = _i + 1}] do {
    private _type = selectRandom _g1_types;
    private _veh = _group1 createUnit [_type, _pos, [], 5, 'NONE'];
    [_veh] joinSilent _group1;
    _veh triggerDynamicSimulation false;
    _obj_list pushBack _veh;
    sleep .1;
};
_group1 deleteGroupWhenEmpty true;
_group1 enableDynamicSimulation true;

// ----------------
// build group 2
// ----------------
private _pos2 = (_obj_list select 0) getRelPos [random 200, random 360];
private _group2_size = _g2_min + (ceil (random (_g2_max - _g2_min)));
private _group2 = createGroup _g2_side;
group_stack pushBackUnique _group2; publicVariable "group_stack";
for [{_i = 0 }, {_i < _group2_size}, {_i = _i + 1}] do {
    private _type = selectRandom _g2_types;
    private _veh = _group2 createUnit [_type, _pos2, [], 5, 'NONE'];
    [_veh] joinSilent _group2;
    _veh triggerDynamicSimulation false;
    _obj_list pushBack _veh;
    sleep .1;
};
_group2 deleteGroupWhenEmpty true;
_group2 enableDynamicSimulation true;

// -----------------------------------
// set up the hot group on group action
// -----------------------------------
private _roll = random 1;
if (_roll < 0.50) then {
   // SAD on SAD
   private _wp1 = _group1 addWaypoint [_pos2, 200];
   _wp1 setWaypointType "SAD";
   private _wp2 = _group2 addWaypoint [_pos, 200];
   _wp2 setWaypointType "SAD";
} else {
   // SandD on Garrison / Defend
    _building = nearestBuilding _pos;
    _posb = getPosATL _building;
    [_group1, _posb] call BIS_fnc_taskDefend;
    private _wp2 = _group2 addWaypoint [_posb, 50];
    _wp2 setWaypointType "SAD";
};

private _UID = "S" + str ([] call pcb_fnc_get_next_UID);
_entry = [false, objNull, _obj_list, false, objNull, objNull, _label];

// record our encounter in the list so we can delete it later
spawned_encounters set [_UID, _entry];
publicVariable "spawned_encounters";

// report to our caller that we were successful
_did_spawn = true;

// report if we succeeded in spawn or not
_did_spawn
