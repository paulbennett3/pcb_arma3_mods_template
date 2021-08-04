params ["_pos"];

private _valid = false;
if ((count _pos) < 2) exitWith { false };

if (((_pos select 0) > 0) || ((_pos select 1) > 0)) then {
   _valid = true;
};

_valid
