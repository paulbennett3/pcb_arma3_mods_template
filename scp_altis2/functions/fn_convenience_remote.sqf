
if (! local player) exitWith {};

private _paradrop = player getVariable "paradrop";
if (isNil "_paradrop") then { player setVariable ["paradrop", -1]; };

private _lsave = player getVariable "lsave";
if (isNil "_lsave") then { player setVariable ["lsave", -1]; };

private _lrestore = player getVariable "lrestore";
if (isNil "_lrestore") then { player setVariable ["lrestore", -1]; };

// -------------------------------------------
// if near respawn point, enable some extra options
// -------------------------------------------
//if ((((getPosATL player) distance2D (markerPos "respawn_west")) < 50) || pcb_DEBUG) then {
if (((getPosATL player) distance2D (markerPos "respawn_west")) < 50) then {
    // ---- near, enable ---

    // Para-infil
    private _item = player getVariable "paradrop";
    if ((isNil "_item") || (_item < 0)) then {
        player setVariable ["paradrop", [player, "myParaInfil", nil, nil, ""]  call BIS_fnc_addCommMenuItem ];
    };
    // Save loadout
    _item = player getVariable "lsave";
    if ((isNil "_item") || (_item < 0)) then {
        player setVariable [ "lsave", [player, "mySaveLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem ];
    };
    // Restore loadout
    _item = player getVariable "lrestore";
    if ((isNil "_item") || (_item < 0)) then {
        player setVariable ["lrestore", [player, "myRestoreLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem ];
    };
} else {
    // ---- not near, disable ---
    // Para-infil
    private _item = player getVariable "paradrop"; 
    if ((! isNil "_item") && (_item > 0)) then {
        [player, _item] call BIS_fnc_removeCommMenuItem;
        player setVariable ["paradrop", -1];
    };
    // Save Loadout 
    _item = player getVariable "lsave";
    if ((! isNil "_item") && (_item > 0)) then {
        [player, _item] call BIS_fnc_removeCommMenuItem;
        player setVariable ["lsave", -1];
    };
    // Restore Loadout 
    _item = player getVariable "lrestore";
    if ((! isNil "_item") && (_item > 0)) then {
        [player, _item] call BIS_fnc_removeCommMenuItem;
        player setVariable ["lrestore", -1];
    };
};
