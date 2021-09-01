
if (! local player) exitWith {};

private _paradrop = player getVariable "paradrop";
if (isNil "_paradrop") then { player setVariable ["paradrop", -1]; };


private _lsave = player getVariable "lsave";
if (isNil "_lsave") then { player setVariable ["lsave", -1]; };

private _lrestore = player getVariable "lrestore";
if (isNil "_lrestore") then { player setVariable ["lrestore", -1]; };

private _lclone = player getVariable "lclone";
if (isNil "_lclone") then { player setVariable ["lclone", -1]; };


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
    // Clone loadout
    _item = player getVariable "lclone";
    if ((isNil "_item") || (_item < 0)) then {
        player setVariable ["lclone", [player, "myCloneLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem ];
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
    // Clone Loadout 
    _item = player getVariable "lclone";
    if ((! isNil "_item") && (_item > 0)) then {
        [player, _item] call BIS_fnc_removeCommMenuItem;
        player setVariable ["lclone", -1];
    };
};


// -------------------------------------------
//    Leader check
//
//  If your role says you are the leader, then
//   make sure you are the leader (for respawn, mostly)
// -------------------------------------------
//if ((roleDescription player) isEqualTo "SCP Operative (Leader)") then {
if ("LEADER" in (toUpper (roleDescription player))) then {
    if (! isNil "player_group") then {
        if ((leader player_group) != player) then {
            player_group selectLeader player;
            [player_group, player] remoteExec ["selectLeader", 0, true];
            player setUnitRank "CAPTAIN";
        };
    };
};


// -------------------------------------------
//   Run a local process to check on 
//    destroyable objects
//
//  entry format:
//    [target object, position, destroyed flag]
// -------------------------------------------
if (isNil "destroyable_monitor") then {

    destroyable_monitor = true;

    [] spawn {
        while { sleep 5; true } do {
//            hint "running monitor ...";
//            systemChat (str destroyable_list);
            {
                private _pos = _x select 1;
                _pos = [_pos select 0, _pos select 1];
                private _found = nearestObject [_pos, "#crater"];
                if (! isNull _found) then {
                    if ((_found distance2D _pos) < 4) then {
                        _x set [2, true];
                        publicVariable "destroyable_list";
                        destroyable_flag = true;
                        publicVariable "destroyable_flag";
                    };
                };    
            } forEach destroyable_list;
        };
    };
};
