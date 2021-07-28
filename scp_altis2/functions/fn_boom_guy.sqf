/* **********************************************************************
                     boom guy

Create an entity that moves towards a random man / vehicle within 100m.
The entity has a smoke/flame emitter, and a mine attached to it ...
********************************************************************** */
params ["_pos", ["_range", 1500]];

private _type = "O_Survivor_F";

private _group = createGroup east;
private _entity = _group createUnit [_type, _pos, [], 5, 'NONE']; 
[_entity] joinSilent _group;
_entity triggerDynamicSimulation false;
_group deleteGroupWhenEmpty true;
_group enableDynamicSimulation true;
_entity disableAI "AUTOCOMBAT";
_entity disableAI "COVER";
_entity disableAI "FSM";
_entity forceWalk true;

removeAllWeapons _entity;
removeAllItems _entity;
removeAllAssignedItems _entity;
removeUniform _entity;
removeVest _entity;
removeBackpack _entity;
removeHeadgear _entity;
removeGoggles _entity;
//_entity forceAddUniform "U_O_R_Gorka_01_black_F";
_entity forceAddUniform "U_C_FormalSuit_01_black_F";
_entity addHeadgear "NWTS_Human_simple_glow";
_entity addGoggles "G_Sport_Blackred";
_entity addGoggles "NWTS_goggle_human_simple_glow";




private _mine = createMine ["DemoCharge_F", [0,0,0], [], 0];
_mine attachTo [_entity, [0, 0, 0]];
_entity setVariable ["mine", _mine];

private _emitter1 = "#particlesource" createVehicle [0,0,0];
_emitter1 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard",
	1, 1, [0, 0, 0], [0, 0, 0.5], 0, 1, 1, 3, [0.5,1.5],
	[[1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.25,1], 1, 1, "", "", _emitter1];
_emitter1 setParticleRandom [0.2, [0.5, 0.5, 0.25], [0.125, 0.125, 0.125], 0.2, 0.2, [0, 0, 0, 0], 0, 0];
_emitter1 setDropInterval 0.05;
_emitter1 attachTo [_entity, [0, 0, 0]];
_entity setVariable ["emitter1", _emitter1];

// Smoke
private _emitter2 = "#particlesource" createVehicle [0,0,0];
_emitter2 setParticleParams [
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 1, 1], "", "Billboard",
	1, 5, [0, 0, 1], [0, 0, 1.5], 0, 1, 1, 0.5, [1.75,2,3,4.5], // timerPeriod → size
	[[1,1,1,0], [1,1,1,0.5], [1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
	[0.5,0.5], 0, 0, "", "", _emitter2];
_emitter2 setParticleRandom [0.5, [1, 1, 0.4], [0, 0, 0.5], 0, 0.125, [0, 0, 0, 0], rad 30, 0];
_emitter2 setDropInterval 0.1;
_emitter2 attachTo [_entity, [0, 0, 0]];
_entity setVariable ["emitter2", _emitter2];

[
    _entity,
    [
        "MPKilled",
        {
            params ["_unit", "_killer", "_instigator", "_useEffect"];
            (_unit getVariable "mine") setDamage 1;
            deleteVehicle (_unit getVariable "emitter1");
            deleteVehicle (_unit getVariable "emitter2");
            deleteVehicle _unit;
        }
    ]
] remoteExec ["addMPEventHandler", 0, true];
[
    _entity,
    [
        "Explosion",
        {
            params ["_vehicle", "_damage"];
            (_vehicle getVariable "mine") setDamage 1;
            deleteVehicle (_vehicle getVariable "emitter1");
            deleteVehicle (_vehicle getVariable "emitter2");
            deleteVehicle _vehicle;
        }
    ]
] remoteExec ["addEventHandler", 0, true];
[ 
    _entity,
    [
        "HandleDamage",
        {
            params ["_unit", "_selection", "_damage", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
            private _mod = .5;
            private _save = 25;
            if (_selection in ["face_hub","head"]) then {
                // _mod=.3;
                _save=0;
            };
            _damage = _damage * _mod;
            if ((random 100) < _save) then {
                _damage = 0;
            };
            _damage
        }
    ]
] remoteExec ["addEventHandler", 0, true];


[_entity, _range, _group] spawn {
    params ["_entity", "_range", "_group"];

    private _code = {
        params ["_self", "_range"];
       
        private _goal = selectRandom (_self nearEntities [["Man", "Car"], _range]);
        while {(_goal distance _self) < 5} do {
            sleep .1;
            _goal = selectRandom (_self nearEntities [["Man", "Car"], _range]);
        };
        _goal
    };
    private _goal = [_entity, _range] call _code;
    private _wp = _group addWaypoint [_goal, -1];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";
    _wp setWaypointCombatMode "BLUE";
    _wp setWaypointSpeed "NORMAL";
 
    while { sleep 1; alive _entity } do {
        private _dist = _goal distance _entity;
        if ((_dist > _range) || (_dist < 5)) then {
            (_entity getVariable "mine") setDamage 1;
        };
        _wp setWaypointPosition [_goal, 5];
    };
};

sleep 2;
private _ok = false;
if (alive _entity) then { _ok = true; };

private _result = [_ok, _entity];
_result;
