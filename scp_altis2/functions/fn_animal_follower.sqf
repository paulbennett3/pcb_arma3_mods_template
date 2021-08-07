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


private _pos = _player getRelPos [(30 + random 50), (random 360)];
if (! ([_pos] call pcb_fnc_is_valid_position)) exitWith { [objNull, false] };

private _type_info = _types_info select _type_num;

_animal = createAgent [_type_info select 0, _pos, [], 5, "NONE"];

_did_spawn = true;
["Spawned animal follower!"] call pcb_fnc_debug;

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

_animal setOwner (owner _player);
sleep .1;

[_animal, ["Killed",  // sad ...
    {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _player = _unit getVariable "master";
        _player setVariable ["animals", (_player getVariable "animals") - [_animal]];
    }
]] remoteExec ["addEventHandler", 0, true];

// Following loop
[_animal, _type_info, _player] remoteExec ["pcb_fnc_animal_follower_loop", owner _player];

private _result = [_animal, _did_spawn];
_result
