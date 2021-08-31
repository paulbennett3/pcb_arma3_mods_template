/* -----------------------------------------------------------
                     make destroyable

Call this function with a target to make destroyable (preferably
   something that won't already respond to an event handler!),
as this is fairly expensive to run ...
----------------------------------------------------------- */
params ["_target"];

if (! isServer) exitWith {};

if (isNil "destroyable_list") then {
    destroyable_list = [];
};

// [ object, position, destroyed flag]
destroyable_list pushBackUnique [_target, getPosATL _target, false];
publicVariable "destroyable_list";
destroyable_flag = false;
publicVariable "destroyable_flag";

private _smoke_cloud = {
    params ["_target"];
    [_target] spawn {
        params ["_target"];
        private _pos = getPosATL _target;
        private _ps1 = "#particlesource" createVehicleLocal _pos;
        _ps1 setParticleParams [
            ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 16, 1], "", "Billboard",
            1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [4, 12, 20],
            [
                [0, 0, 0, 0], 
                [0.05, 0.05, 0.05, 1], 
                [0.05, 0.05, 0.05, 1], 
                [0.05, 0.05, 0.05, 1], 
                [0.1, 0.1, 0.1, 0.5], 
                [0.125, 0.125, 0.125, 0]
            ],
            [0.25], 1, 0, "", "", _ps1
        ];
        _ps1 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _ps1 setDropInterval 0.2;
        sleep 1;
        private _ps2 = "#particlesource" createVehicleLocal _pos;
        _ps2 setParticleParams [
            ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 9, 16, 0], "", "Billboard",
            1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20],
            [
                [0.5, 0.5, 0.5, 0], 
                [0.5, 0.5, 0.5, 0.5], 
                [0.66, 0.66, 0.66, 0.33], 
                [0.75, 0.75, 0.75, 0.25], 
                [1, 1, 1, 0]
            ],
            [0.25], 1, 0, "", "", _ps1
        ];
        _ps2 setParticleRandom [0, [0.5, 0.5, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _ps2 setDropInterval 0.2;
        deleteVehicle _target;
        sleep 2;
        deleteVehicle _ps1;
        sleep 1;
        deleteVehicle _ps2;
    };
};


[_smoke_cloud] spawn {
    params ["_smoke_cloud"];
    ["make destroyable monitor started"] call pcb_fnc_debug;

    while { true } do {
        // we wait until a client tells us they saw a crater near one of our objects
        waitUntil { sleep 5; destroyable_flag };
        ["make destroyable monitor processing ..." + (str destroyable_list)] call pcb_fnc_debug;

        // note everything destroyed (dead or noted near a crater) ...
        private _destroyed = destroyable_list select { (! alive (_x select 0)) || { _x select 2} };
        ["  destroyed: " + (str _destroyed)] call pcb_fnc_debug;
       
        private _dldx = 0;
        for [{}, {_dldx < (count _destroyed)}, {_dldx = _dldx + 1}] do {
            private _entry = _destroyed select _dldx;
            private _target =  _entry select 0;
            ["make destroyable monitor destroying <" + (str _target) + "> ..."] call pcb_fnc_debug;
// should mutex protect this!
            destroyable_list  = destroyable_list - [ _entry ];

            ["      target <" + (str _target) + ">"] call pcb_fnc_debug;
            [_target] call _smoke_cloud;

        };
        
        ["make destroyable monitor done ..." + (str destroyable_list)] call pcb_fnc_debug;
// should mutex protect this!
        publicVariable "destroyable_list";
        destroyable_flag = false;
        publicVariable "destroyable_flag";
    };
};

