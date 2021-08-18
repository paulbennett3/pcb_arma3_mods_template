/* -----------------------------------------------------------
                     make destroyable

Call this function with a target to make destroyable (preferably
   something that won't already respond to an event handler!),
as this is fairly expensive to run ...
----------------------------------------------------------- */
params ["_target"];

if (isNil "destroyable_list") then {
    destroyable_list = [];
};
destroyable_list pushBackUnique _target;

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


if ((count destroyable_list) == 1) then {
    [_smoke_cloud] spawn {
        params ["_smoke_cloud"];
        ["make destroyable monitor started"] call pcb_fnc_debug;

        while { sleep 15; (count destroyable_list) > 0 } do {
            // remove anything already destroyed ...
            destroyable_list = destroyable_list select { alive _x };
            private _list = allMissionObjects "#crater";
            private _dldx = 0;
            private _target = objNull;
            private _destroyed = [];
            for [{_dldx = 0}, {_dldx < (count destroyable_list)}, {_dldx = _dldx + 1}] do {
                _target = destroyable_list select _dldx;
                private _filtered_list = _list select {
                    if ((_x distance2D _target) < 2) then { true } else { false };
                };
                if ((count _filtered_list) > 0) then {
                    _destroyed pushBackUnique _target;
                };
            };
            destroyable_list = destroyable_list - _destroyed;
            for [{_dldx = 0}, {_dldx < (count _destroyed)}, {_dldx = _dldx + 1}] do {
                private _target = _destroyed select _dldx;
                private _pos = getPosATL _target;
                [_target] call _smoke_cloud;
            };
        };

        ["make destroyable monitor exiting"] call pcb_fnc_debug;
    };
};

