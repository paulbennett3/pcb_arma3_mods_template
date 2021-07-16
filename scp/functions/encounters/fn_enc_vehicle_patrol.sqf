/* ******************************************************************
                   fn_enc_vehicle_patrol

Spawn a single vehicle (with crew) to patrol
   patrol (can be anywhere on road)
****************************************************************** */
params ["_player", "_type", "_side"];
private _did_spawn = false;

private _whitelist = [ [_player getRelPos [1000, 0], 250] ];
private _blacklist = [ "water" ];
private _code = { (count (_this nearRoads 5) > 0) };
private _pos = [_whitelist, _blacklist, _code] call BIS_fnc_randomPos;

// did we get a valid position?
if (((_pos select 0) == 0) and ((_pos select 1) == 0)) exitWith { false };

// are there any players in the area?
if ([_pos, 500] call pcb_fnc_players_in_area) exitWith { false };

private _entry = objNull;

if (true) then {
    // get a UID to identify the encounter
    private _UID = "SA" + str ([] call pcb_fnc_get_next_UID);

    // make a list of all the stuff we spawn
    private _obj_list = [];

    // create a group
    //private _group = createGroup _side;
    private _group = createGroup civilian;
    private _res = [
        _pos,
        random 360,
        _type,  
        _group 
    ] call BIS_fnc_spawnVehicle;
    // Note of result -> _res = [created vehicle, [crew]], group]

    _obj_list pushBack (_res select 0);
    [_res select 0] joinSilent _group;
    {
        _obj_list pushBack _x;
    } forEach (_res select 1);
    [(_res select 1)] joinSilent _group;

    sleep .1;

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;

    // create a patrol
    [_group, _pos, 1000] call BIS_fnc_taskPatrol; 
    
    // mark if it is a "static" (just a building, rock, ...) or not encounter
    //   if it is "static", we won't bother to delete it later
    _entry = [false, _pos, false, _obj_list, false, objNull, objNull];

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // [_UID, "vehicle patrol", _res select 0, 10] call pcb_fnc_objective_locate_object;

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
