params ["_id"];

private _pos = markerPos "respawn_west";
if (isNil "_pos") then {
    _pos = start_pos;
};

// add some random dispersion so troops don't get tangled on each other
//  after mass casualty incident(s)
_pos = _pos getPos [1 + (random 10), random 360];

private _role = scp_support_units select _id;
private _base_loadout = scp_specialists get "base loadout";
private _type = (scp_specialists get _role) select 0;
private _loadout = (scp_specialists get _role) select 1;
private _nu = player_group createUnit [_type, _pos, [], 2, "NONE"];
_nu setVariable ["id", _id];
[_nu] call _base_loadout;
[_nu] call _loadout;
[_nu] join player_group;
[_nu] call pcb_fnc_enable_ai_respawn;

// tell the unit to "stop" so they don't wander the countryside
commandStop _nu;

scp_support_unit_tracker set [_id, _nu];
publicVariable "scp_support_unit_tracker";
 
