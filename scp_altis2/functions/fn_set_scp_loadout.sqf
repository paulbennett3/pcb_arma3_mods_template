params ["_this"];

// now all set in fn_types.sqf
waitUntil { ! isNil "scp_specialists" };

[_this] call (scp_specialists get "base loadout");

