/* ---------------------------------------------------------------------
                     animal follower loop

Behaviour loop for animal follower (for remoteExec'ing)
--------------------------------------------------------------------- */
params ["_animal", "_type_info", "_player"];

[_animal, _type_info, _player] spawn {
    params ["_animal", "_type_info", "_player"];

    private _state = (_type_info select 3);
    // Force to sprint
    _animal playMove _state;

    while { sleep 1; alive _animal } do {
        if (! (_animal getVariable "ride")) then {
            private _pos_player = getPosATL _player;
            private _dist = _pos_player distance (getPosATL _animal);

            // far, far away, so head off to the farm in the country
            if (_dist > 2000) exitWith {
                deleteVehicle _animal; true    // sad ...
            };

            // far away, so run
            if (_dist > 10) then {
                if (! (_state isEqualTo (_type_info select 3))) then {
                   _state = (_type_info select 3);
                   _animal playMove _state;
                };
    	        _animal moveTo _pos_player;
            };
            if ((_dist <= 10) and (_dist > 2)) then {
                // close, so just walk
                if (! (_state isEqualTo (_type_info select 2))) then {
                   _state = (_type_info select 2);
                   _animal playMove _state;
                };
	        _animal moveTo _pos_player;
            };
            if (_dist <= 2) then {
                if (! (_state isEqualTo (_type_info select 1))) then {
                   _state = (_type_info select 1);
                   _animal playMove _state;
                };
            };

        };
    };
};
