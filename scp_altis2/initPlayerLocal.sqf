params ["_player", "_didJIP"];


[_player] spawn {
    params ["_player"];

    private _menu_item_paradrop = -1;
    private _menu_item_save_loadout = -1;
    private _menu_item_restore_loadout = -1;

    while { sleep 5; true } do {
        // monitor some player status variables
    
        // -------------------------------------------
        // if near respawn point, enable some extra options
        // -------------------------------------------
        if ((((getPosATL _player) distance2D (markerPos "respawn_west")) < 50) || pcb_DEBUG) then {
            // ---- near, enable ---


            // Para-infil
            if (_menu_item_paradrop == -1) then {
                _menu_item_paradrop = [_player, "myParaInfil", nil, nil, ""] call BIS_fnc_addCommMenuItem;
            };
            // Save loadout
            if (_menu_item_save_loadout == -1) then {
                _menu_item_save_loadout = [_player, "mySaveLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem;
            };
            // Restore loadout
            if (_menu_item_restore_loadout == -1) then {
                _menu_item_restore_loadout = [_player, "myRestoreLoadout", nil, nil, ""] call BIS_fnc_addCommMenuItem;
            };
        } else {
            // ---- not near, disable ---

            // Para-infil
            if (_menu_item_paradrop != -1) then {
                [_player, _menu_item_paradrop] call BIS_fnc_removeCommMenuItem;
                _menu_item_paradrop = -1;
            };
            // Save Loadout 
            if (_menu_item_save_loadout != -1) then {
                [_player, _menu_item_save_loadout] call BIS_fnc_removeCommMenuItem;
                _menu_item_save_loadout = -1;
            };
            // Restore Loadout 
            if (_menu_item_restore_loadout != -1) then {
                [_player, _menu_item_restore_loadout] call BIS_fnc_removeCommMenuItem;
                _menu_item_restore_loadout = -1;
            };
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


// --------------------------
// Add some event handlers
// --------------------------

// GetIn/Out Man -- for animal follower(s)
_player addEventHandler [ "GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    private _animals = _unit getVariable "animals";
    if (! (isNil "_animals")) then {
        private _pos = getPosATL _unit;
        {
            if (alive _x) then {
                private _dist = _pos distance (getPosATL _x);
                if (_dist < 100) then {
                    [ _x, true ] remoteExec ["hideObject", 0, true];
                    _x setVariable ["ride", true];
                };
            };
        } forEach _animals;
    };
}];


_player addEventHandler [ "GetOutMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    private _animals = _unit getVariable "animals";
    if (! (isNil "_animals")) then {
        private _pos = getPosATL _unit;
        {
            if (alive _x) then {
                _x setVehiclePosition [_pos, [], 3, "NONE"];
                [ _x, false ] remoteExec ["hideObject", 0, true];
                _x setVariable ["ride", false];
            };
        } forEach _animals;
    };
}];

