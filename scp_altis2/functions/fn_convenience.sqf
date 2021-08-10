[] spawn {
    while { sleep 30; true } do {
        {
            if (isPlayer _x) then {
                [] remoteExec ["pcb_fnc_convenience_remote", owner _x];
            };
        } forEach playableUnits;
    };
};

