/* ---------------------------------------------------------------------
                     animal follower 

Spawn an animal and have it follow given player
_type_num must be in 0 to 8

--------------------------------------------------------------------- */

params ["_player", ["_type_num", 0]];

private _did_spawn = false;

// type string, stop, walk, run
private _types_info = [
    ["Fin_random_F", "Dog_Sit", "Dog_Walk", "Dog_Sprint"],
    ["Alsatian_Random_F", "Dog_Sit", "Dog_Walk", "Dog_Sprint"],
    ["Alsatian_Black_F", "Dog_Sit", "Dog_Walk", "Dog_Sprint"],
    ["Sheep_random_F", "Sheep_Idle_Stop", "Sheep_Walk", "Sheep_Run"],
    ["Goat_random_F", "Goat_Idle_Stop", "Goat_Walk", "Goat_Run"],
    ["Rabbit_F", "Rabbit_Idle_Stop", "Rabbit_Hop", "Rabbit_Hop"],
    ["Cock_random_F", "Cock_Idle_Stop", "Cock_Walk", "Cock_Run"],
    ["Hen_random_f", "Hen_Idle_Stop", "Hen_Walk", "Hen_Walk"],
    ["Snake_vipera_random_F", "Snake_Idle_Stop", "Snake_Move", "Snake_Move"]
];

if (! isServer) exitWith { [objNull, false]};

private _pos = _player getRelPos [(30 + random 50), (random 360)];
if (((_pos select 0) == 0) and ((_pos select 1) == 0)) exitWith { [objNull, false] };

private _type_info = _types_info select _type_num;


_animal = createAgent [_type_info select 0, _pos, [], 5, "NONE"];

_did_spawn = true;

// Disable animal behaviour
_animal setVariable ["BIS_fnc_animalBehaviour_disable", true];
_animal setVariable ["master", _player, true];
_animal setVariable ["ride", false, true];

// add the animal to the player object (and allow for more than one follower ...)
private _animals = _player getVariable "animals";
if (isNil "_animals") then {
    _player setVariable ["animals", [], true];
};
(_player getVariable "animals") pushBackUnique _animal;

// Following loop
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

_animal addEventHandler ["Killed",  // sad ...
    {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _player = _unit getVariable "master";
        _player setVariable ["animals", (_player getVariable "animals") - [_animal]];
    }
];

// add event handlers to move the animal "into" and "out of" vehicle
[
    _player,
    [
        "GetInMan",
        {
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
        }
    ]
] remoteExec ["addEventHandler", 0, true];
[
    _player,
    [
        "GetOutMan",
        {
            params ["_unit", "_role", "_vehicle", "_turret"];
            private _animals = _unit getVariable "animals";
            if (! (isNil "_animals")) then {
                [("We're there. Hop out! <" + (str (_unit getVariable "animals")) + ">")] remoteExec ["systemChat", 0];
                private _pos = getPosATL _unit;
                {
                    if (alive _x) then {
                        _x setVehiclePosition [_pos, [], 3, "NONE"];
                        [ _x, false ] remoteExec ["hideObject", 0, true];    
                        _x setVariable ["ride", false];
                    };
                } forEach _animals;
            };
        }
    ]
] remoteExec ["addEventHandler", 0, true];
_animal setOwner (owner _player);

private _result = [_animal, _did_spawn];
_result
