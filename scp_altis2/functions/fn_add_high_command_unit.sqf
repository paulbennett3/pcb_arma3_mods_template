/* ********************************************************
               add high command unit

Given a player and a list of types, generate a group and
add them to the player's high command bar

_pos (position) : where to spawn the group at
_leader (unit) : the player to assign the group to
_types (list of type strings) : the types to create for the group
_groupName (string) : name of the group (anything)
_team (string) : must be one of:
    "teamMain", "teamRed", "teamGreen", "teamBlue", "teamYellow"
******************************************************** */
params ["_pos", "_leader", "_types", "_groupName", "_team", "_mode"];

// -----------------------------------------------
// create the group, and instantiate the soldiers
// -----------------------------------------------
private _group = createGroup west;
private _obj_list = [];
if (_mode isEqualTo "infantry") then {
    for [{_i = 0 }, {_i < (count _types)}, {_i = _i + 1}] do {
        private _type = _types select _i;
        private _veh = _group createUnit [_type, _pos, [], 5, 'NONE'];
        [_veh] joinSilent _group;
        _obj_list pushBack _veh;
    };
} else {
    // figure out vehicles -- have to spawn in crew ...
};

(_obj_list select 0) setUnitRank "SERGEANT";
[_group, (_obj_list select 0)] remoteExec ["selectLeader", owner _leader, true];

// -----------------------------------------------
// there is a limit to the number of groups, so we will mark this to delete
//  when empty
// -----------------------------------------------
_group deleteGroupWhenEmpty true;


// -----------------------------------------------
// Make the group local to _leader
// -----------------------------------------------
_group setGroupOwner (owner _leader);

/*
// -----------------------------------------------
// Check if the HC commander already has an HC command module assigned
// -----------------------------------------------
private _has_hc = false;
{
    if (typeOf _x == "HighCommand") then {
        _has_hc = true;
    }
} forEach (synchronizedObjects _leader);

// if they don't have a HC command module, add one
if (! _has_hc) then {
    private _group_logic = createGroup sideLogic;
    [
        "HighCommand", 
        start_pos, 
        _group_logic,
        "this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; HC = this; publicVariable 'HC';"
    ] remoteExec ["createUnit", owner _leader, true];
    waitUntil { sleep 1; ! isNil "HC" };
    _leader synchronizeObjectsAdd [HC];

//    "HighCommand" createUnit [
//        start_pos,
//        _group_logic,
//        "this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; HC = this; publicVariable 'HC';"
//    ];
//    waitUntil { sleep 1; ! isNil "HC" };
    //_leader synchronizeObjectsAdd [HC];
//    HC synchronizeObjectsAdd [_leader];
};

// make an HC Subordinate module for the group
private _group_logic = createGroup sideLogic;
HCS = objNull;
publicVariable "HCS";
[
    "HighCommandSubordinate", 
    start_pos, 
    _group_logic,
    "this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; HCS = this; publicVariable 'HCS';"
] remoteExec ["createUnit", owner _leader, true];
waitUntil { sleep 1; ! isNull HCS };
HCS synchronizeObjectsAdd [_group];
*/


// -----------------------------------------------
// Unlikely that the player would already be
//   the leader, but why not ...
// -----------------------------------------------
if (_leader != hcLeader _group) then {
    hcLeader _group hcRemoveGroup _group;
    _leader hcSetGroup [_group, _groupName, _team];
};

