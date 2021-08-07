/* ********************************************************
               add high command unit

Given a player and a list of types, generate a group and
add them to the player's high command bar

!!!! add the "high command commander" module in the editor, or
else add it here.  Either way, run this from initPlayerLocal.  Also,
works with editor placed commander module.  Note that all spawed "west"
units will be assigned to the commander if they don't have an HC 
subordinate module attached.

_pos (position) : where to spawn the group at
_types (list of type strings) : the types to create for the group
_groupName (string) : name of the group (anything)
_team (string) : must be one of:
    "teamMain", "teamRed", "teamGreen", "teamBlue", "teamYellow"
******************************************************** */
params ["_pos", "_types", "_groupName", "_team", "_mode"];

["Adding high command unit with types <" + (str _types) + ">"] call pcb_fnc_debug;
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
    ["Add High Command -- only infantry mode supported"] call pcb_fnc_debug;
};

(_obj_list select 0) setUnitRank "SERGEANT";
_group selectLeader (_obj_list select 0);

// -----------------------------------------------
// there is a limit to the number of groups, so we will mark this to delete
//  when empty
// -----------------------------------------------
_group deleteGroupWhenEmpty true;

if (player != hcLeader _group) then {
    hcLeader _group hcRemoveGroup _group;
    player hcSetGroup [_group];
};

