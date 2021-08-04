/* **********************************************************************
                     boom animal

Create an animal that moves towards a random man / vehicle within 100m.
The animal has a smoke/flame emitter, and a mine attached to it ...
********************************************************************** */
params ["_pos", ["_index", 1], ["_hide", true], ["_range", 1000]];
private _info = [
    ["Sheep_random_F", "Sheep_Run"],
    ["Cock_random_F", "Cock_Run"],
    ["Goat_random_F", "Goat_Run"]
];

private _type = (_info select _index) select 0; 
private _run = (_info select _index) select 1; 

private _target = createAgent [_type, _pos, [], 5, "NONE"];
_target setVariable ["BIS_fnc_animalBehaviour_disable", true];
// _target hideObject _hide;

private _mine = createMine ["APERSMine", [0,0,0], [], 0];
_mine attachTo [_target, [0, 0, 0]];
_target setVariable ["mine", _mine];

private _emitter = "#particlesource" createVehicle [0,0,0];
_emitter setParticleClass "MediumSmoke";
_emitter setParticleFire [0.3,1.0,0.1];
_emitter attachTo [_target, [0, 0, 0]];
_target setVariable ["emitter", _emitter];

[
    _target,
    [
        "MPKilled",
        {
            params ["_unit", "_killer", "_instigator", "_useEffect"];
            (_unit getVariable "mine") setDamage 1;
            deleteVehicle (_unit getVariable "emitter");
        }
    ]
] remoteExec ["addMPEventHandler", 0, true];
[
    _target,
    [
        "Explosion",
        {
            params ["_vehicle", "_damage"];
            (_vehicle getVariable "mine") setDamage 1;
            deleteVehicle (_vehicle getVariable "emitter");
        }
    ]
] remoteExec ["addEventHandler", 0, true];

[_target, _run, _range] spawn {
    params ["_animal", "_run"];
    // Force to sprint
    _animal playMove _run;

    private _goal = selectRandom (_animal nearEntities [["Man", "Car"], _range]);

    if (isNull _goal) then { (_animal getVariable "mine") setDamage 1; };

    while { sleep 1; alive _animal } do {
        if ((_goal distance _animal) > _range) then {
            _goal = selectRandom (_animal nearEntities [["Man", "Car"], _range]);
        };

        _animal moveTo (getPosATL _goal);
    };
};

sleep 2;
private _ok = false;
if (alive _target) then { _ok = true; };

private _result = [_ok, _target];
_result;
