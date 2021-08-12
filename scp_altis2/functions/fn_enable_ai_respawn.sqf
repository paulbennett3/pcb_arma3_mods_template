/* *************************************************************
                    enable ai respawn

Given an existing (AI) unit (non-playable), add an MPKilled
event handler that will respawn it, requip it, etc etc
************************************************************* */
params ["_unit", "_id"];

if (_unit in playableUnits) exitWith {};
_unit setVariable ["id", _id, true];

_unit addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    if (isPlayer _unit) exitWith {};
    private _type = typeOf _unit;
    if (isNil "_type") then { _type = "B_Soldier_F"; };
    _id = _unit getVariable "id";
    if (isNil "_id") then { _id = -1; };
    private _msg = ["respawn_ai", _type, _id];
    [_msg] call pcb_fnc_send_mail;
}];
