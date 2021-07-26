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

// Following loop
[_animal, _type_info, _player] spawn {
    params ["_animal", "_type_info", "_player"];
    private _state = (_type_info select 3);
    // Force to sprint
    _animal playMove _state;

    while { sleep 1; alive _animal } do {
        private _pos_player = getPosATL _player;
        private _dist = _pos_player distance (getPosATL _animal);

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
private _result = [_animal, _did_spawn];
_result
