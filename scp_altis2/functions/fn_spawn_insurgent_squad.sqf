/* *********************************************************
                  spawn insurgent squad

Spawn a squad and a vehicle, have 'em mount, then
   seek out a target
********************************************************* */
params ["_pos", "_target"];

[_pos, _target] spawn {
    params ["_pos", "_target"];
hint ("POS <" + (str _pos) + ">");
    private _veh_type = selectRandom [
        "CUP_I_MTLB_pk_SYNDIKAT",
        "O_APC_Wheeled_02_rcws_v2_F",
        "O_Truck_03_transport_F"
    ];
    private _types = [
        "I_C_Soldier_Para_2_F",
        "I_C_Soldier_Para_4_F",
        "I_C_Soldier_Para_6_F",
        "I_C_Soldier_Para_1_F",
        "I_C_Soldier_Para_7_F",
        "I_C_Soldier_Para_5_F",
        "I_C_Soldier_Para_8_F",
        "I_C_Soldier_Para_3_F"
    ];
    private _group = [_pos, independent, _types] call BIS_fnc_spawnGroup;
    _group deleteGroupWhenEmpty true;

    private _veh = createVehicle [_veh_type, _pos, [], 10, "NONE"];
    _group addVehicle _veh;
     
    [_group, _pos, "DRIVE_AND_DESTROY", _veh, _target] call pcb_fnc_set_behaviour;

    private _done = false;
    while { sleep 10; ! _done } do {
        private _alive = (units _group) select { alive _x };
        private _count = count _alive;
        private _distv = _veh distance2D _target; 
        private _dist = (_alive select 0) distance2D _target;
        private _mounted = count (_alive select { _x in _veh });
        ["Alive: " + (str _count) + " at distance " + (str _dist) + "  dist v: " + (str _distv) + "  mounted: " + (str _mounted)] call pcb_fnc_debug;
        if (_count < 1) then {
            _done = true;
        };
    };
};
