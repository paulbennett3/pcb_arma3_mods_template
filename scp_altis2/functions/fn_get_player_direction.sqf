/* *********************************************************
                  get player direction
********************************************************* */
params ["_player"];

private _obj = _player;
private _result = [_player] call pcb_fnc_player_in_vehicle;

if (_result select 0) then {
    _obj = (_result select 1) select 0;
};

private _out = getDir _obj;
_out
