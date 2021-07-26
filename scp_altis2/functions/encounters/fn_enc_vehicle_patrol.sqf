/* ******************************************************************
                   fn_enc_vehicle_patrol

Spawn a single vehicle (with crew) to patrol
   patrol (can be anywhere on road)
****************************************************************** */
params ["_player", "_type", "_side"];
private _did_spawn = false;

hint ("<" + (str _type) + ">");

private _vobj = _player;
private _vtemp = [_player] call pcb_fnc_player_in_vehicle;
if (_vtemp select 0) then { _vobj = (_vtemp select 1) select 0; };
private _whitelist = [ [_vobj getRelPos [ENC_DIST, 0], ENC_RADIUS] ];
private _blacklist = [ "water" ];
private _code = { (count (_this nearRoads 5) > 0) };
private _pos = [0, 0];

// did we get a valid position?
private _tries = 10;
while { _tries > 0 } do {
    _pos = [_whitelist, _blacklist, _code] call BIS_fnc_randomPos;
    if (((_pos select 0) == 0) and ((_pos select 1) == 0)) then {
        _tries = _tries - 1;
    } else {
        _tries = 0;
    };
};

if (((_pos select 0) == 0) and ((_pos select 1) == 0)) exitWith { diag_log "fn_enc_vehicle_patrol - invalid position"; false };

// are there any players in the area?
if ([ [_pos, ENC_MIN_PLAYER_DIST_CREATE] ] call pcb_fnc_players_in_area) exitWith { diag_log "fn_enc_vehicle_patrol - players to close"; false };

private _entry = objNull;

if (true) then {
    // get a UID to identify the encounter
    private _UID = "SA" + str ([] call pcb_fnc_get_next_UID);

    // make a list of all the stuff we spawn
    private _obj_list = [];

    // create a group
    private _group = createGroup _side;
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
        _x triggerDynamicSimulation false;
    } forEach (_res select 1);
    [(_res select 1)] joinSilent _group;

    sleep .1;

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // create a trigger on the first object in the list (so it will track patrols, for example)
    // we use it to detect if there are players "near"
    _trg = createTrigger ["EmptyDetector", _obj_list select 0, true];
    _trg setTriggerArea [ENC_MIN_PLAYER_DIST_DELETE, ENC_MIN_PLAYER_DIST_DELETE, 0, false];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["this", "", ""];
    _obj_list pushBack _trg;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;

    // create a patrol
    [_group, _pos, 1000] call BIS_fnc_taskPatrol; 
    
    _entry = [false, _trg, _obj_list, false, objNull, objNull];

    if (pcb_DEBUG) then {
        private _m = createMarker [_UID, _obj_list select 0];
        _m setMarkerShapeLocal "ELLIPSE";
        _m setMarkerColorLocal "ColorRED";
        _m setMarkerSizeLocal [50, 50];
        _m setMarkerAlpha 0.9;
    };

    // record our encounter in the list so we can delete it later
    spawned_encounters set [_UID, _entry];
    publicVariable "spawned_encounters";

    // report to our caller that we were successful
    _did_spawn = true;
};

// report if we succeeded in spawn or not
_did_spawn
