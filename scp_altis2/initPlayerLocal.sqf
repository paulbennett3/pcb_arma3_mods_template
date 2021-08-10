params ["_player", "_didJIP"];

[_player] spawn {
    params ["_player"];

    while { sleep 5; true } do {
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

