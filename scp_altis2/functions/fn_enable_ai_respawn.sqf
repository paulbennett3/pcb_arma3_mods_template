/* *************************************************************
                    enable ai respawn

Given an existing (AI) unit (non-playable), add an MPKilled
event handler that will respawn it, requip it, etc etc
************************************************************* */
params ["_unit"];

if (_unit in playableUnits) exitWith {};

_unit addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    if (isPlayer _unit) exitWith {};
    private _id = _unit getVariable "id";
    if (isNil "_id") then {
       ["AI Respawn attempted with no unit id"] remoteExec ["pcb_fnc_debug", 0];
    } else {
        private _msg = ["respawn_ai", _id];
        [_msg] call pcb_fnc_send_mail;
    };
}];
