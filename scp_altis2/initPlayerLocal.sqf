params ["_player", "_didJIP"];

[_player] spawn {
    params ["_player"];

    menu_item_paradrop = -1;
    menu_item_save_loadout = -1;
    menu_item_restore_loadout = -1;

    while { sleep 5; true } do {
        // monitor some player status variables

        // -------------------------------------------
        // if near respawn point, enable some extra options
        // -------------------------------------------
        if ((((getPosATL _player) distance2D (markerPos "respawn_west")) < 50) || pcb_DEBUG) then {
        // ---- near, enable ---

            // Para-infil
            if (menu_item_paradrop == -1) then {
                menu_item_paradrop = [_player, "myParaInfil", nil, nil, ""] call BIS_fnc_addCommMenuItem;
            };
            // Save loadout
            if (menu_item_save_loadout == -1) then {
                menu_item_save_loadout = [_player, "mySaveLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem;
            };
            // Restore loadout
            if (menu_item_restore_loadout == -1) then {
                menu_item_restore_loadout = [_player, "myRestoreLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem;
            };
        } else {
            // ---- not near, disable ---
/*
            // Para-infil
            if (menu_item_paradrop != -1) then {
                [_player, menu_item_paradrop] call BIS_fnc_removeCommMenuItem;
                menu_item_paradrop = -1;
            };
            // Save Loadout 
            if (menu_item_save_loadout != -1) then {
                [_player, menu_item_save_loadout] call BIS_fnc_removeCommMenuItem;
                menu_item_save_loadout = -1;
            };
            // Restore Loadout 
            if (menu_item_restore_loadout != -1) then {
                [_player, menu_item_restore_loadout] call BIS_fnc_removeCommMenuItem;
                menu_item_restore_loadout = -1;
            };
*/
        };

        // -------------------------------------------
        //    Leader check
        //
        //  If your role says you are the leader, then
        //   make sure you are the leader (for respawn, mostly)
        // -------------------------------------------
        if ((roleDescription _player) isEqualTo "SCP Operative (Leader)") then {
            if (! isNil "player_group") then {
                if ((leader player_group) != _player) then {
                    player_group selectLeader _player;
                    [player_group, _player] remoteExec ["selectLeader", 0, true];
                    _player setUnitRank "SERGEANT";
                };
            };
        };
    };
};

