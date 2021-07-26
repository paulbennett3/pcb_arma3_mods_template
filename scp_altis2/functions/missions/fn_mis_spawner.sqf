/* *******************************************************************
                      mis_spawner

This mission generates a "spawner" object that must be destroyed
   to complete the mission.  It spawns units (with a delay in 
   between) until there is a fixed number active, or is destroyed.

   It uses the "destroy" mission type.

Parameters:
   _UID (string) : the UID assigned by the mission generator

Returns:
   _result (array) : [ _ok, _state ]
           where:
              _ok (bool) : true if mission generated ok, false if
                   any errors or failures happened (and we should try again)
              _state (hashmap) : any state needed to cleanup after this mission
                 Keys:
                    "obj_list" (array) : list of "vehicles" to delete
                    "marker_list" (array) : list of "markers" to delete
                    ???

******************************************************************* */
params ["_UID"];

private _ok = false;
private _state = createHashMapFromArray [
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];
private _result = [_ok, _state];



private _possible_objects = [
//    ["eye_of_ra_wl", "occult"],
    ["Catacomb_Stone_casket", "occult"],
//    ["vn_dragon_01", "occult"],
//    ["vn_dragon_02", "occult"],
    ["Land_vn_shrine_01", "occult"],
    ["Land_vn_vase_loam_3_ep1", "occult"],
    ["sga_skull_post", "occult"]
];
private _target = objNull;
private _object_genre = selectRandom _possible_objects;
private _object_type = _object_genre select 0;
private _genre = _object_genre select 1;
private _building = objNull;
private _pos = [0,0,0];
private _tries = 100;
while {_tries > 0} do {
    _tries = _tries - 1;

    _building = [epicenter, 5000] call pcb_fnc_get_cool_building_location;

    private _positions = [_building] call BIS_fnc_buildingPositions; 
    if ((count _positions) > 5) then {
        _pos = selectRandom _positions;
        if ([_pos] call pcb_fnc_is_valid_position) then {
            //_target = _object_type createVehicle _pos; 
            _target = createVehicle [_object_type,_pos, [], 0, "NONE"]; 
            sleep 1;
            if ((! (isNull _target)) and (alive _target)) then {
                _tries = -10;
            };
        };
    };
}; 

// test if we have utterly failed ... 
if ((_tries > -10) or (isNull _target)) exitWith { _result };

private _desc = objNull;
if (_genre isEqualTo "occult") then {
    _desc = [ "Destroy the infernal artifact causing the dead to rise. [Occult Tech]", "Destroy artifact", ""];
} else {
    _desc = [ "Disable or destroy the machine causing the dead to rise. [Occult Tech]", "Destroy machine", ""];
};
_destroyable = false;
_state = createHashMapFromArray [
    ["target", _target],
    ["targetpos", _pos],
    ["taskdesc", _desc],
    ["taskpid", objNull],
    ["is_destroyable", _destroyable],
    ["UID", _UID],
    ["obj_list", []],
    ["marker_list", []]
];

private _temp = [_state] call pcb_fnc_mis_destroy;

// add some "environment"
[_pos, 50, 50 ] remoteExec ["BIS_fnc_crows", 0];

// save our state in our target "for later"
_target setVariable ["_state", _state, true];

// ---------------------------------------
// spawn a welcoming comittee ...
// ---------------------------------------
private _welcome_comittee = true;
//private _welcome_comittee = false;

// needs _pos and _building defined
if (_welcome_comittee) then {
    private _types = [
                "RyanZombieC_man_1", "RyanZombieC_man_hunter_1_F", "RyanZombie19", "RyanZombie23",
                "RyanZombie29", "RyanZombieC_man_polo_4_F", "RyanZombieC_scientist_F", "RyanZombieB_Soldier_lite_F",
                "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_02_fmediumOpfor", "RyanZombieB_Soldier_02_f_1mediumOpfor",
                "RyanZombieB_Soldier_02_f_1_1mediumOpfor", "RyanZombieB_Soldier_03_fmediumOpfor",
                "RyanZombieB_Soldier_03_f_1mediumOpfor", "RyanZombieB_Soldier_03_f_1_1mediumOpfor",
                "RyanZombieB_Soldier_04_fmediumOpfor", "RyanZombieB_Soldier_04_f_1mediumOpfor",
                "RyanZombieB_Soldier_04_f_1_1mediumOpfor", "RyanZombieB_Soldier_lite_FmediumOpfor",
                "RyanZombieB_Soldier_lite_F_1mediumOpfor", "RyanZombieB_Soldier_02_fmediumOpfor",
                "RyanZombieB_Soldier_02_f_1mediumOpfor", "RyanZombieB_Soldier_02_f_1_1mediumOpfor"
    ];

    // make a list of all the stuff we spawn
    private _obj_list = [];

    private _group_size = 10 + (random 20);

    // create a group
    private _group = createGroup east;
    for [{_i = 0 }, {_i < _group_size}, {_i = _i + 1}] do {
        private _type = objNull;
        _type = selectRandom _types;

        private _veh = _group createUnit [_type, _pos, [], 10, 'NONE'];
        [_veh] joinSilent _group;
        _veh triggerDynamicSimulation false;
        _obj_list pushBack _veh;
        sleep .1;
    };

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;

    // create a garrison waypoint
    [_group, getPosATL _building] call BIS_fnc_taskDefend;
};


// -------------------------------------
_ok = true;
_result = [_ok, _state];
_result
