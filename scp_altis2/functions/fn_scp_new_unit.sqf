params ["_type", "_id"];

["New Unit called for type <" + (str _type) + "> and ID <" + (str _id) + ">"] call pcb_fnc_debug;
private _pos = markerPos "respawn_west";
private _nu = player_group createUnit [_type, _pos, [], 5, "NONE"];
_nu setVariable ["id", _id];
[_nu] call pcb_fnc_set_scp_loadout;
[_nu] join player_group;
[_nu, 1] call pcb_fnc_enable_ai_respawn;
