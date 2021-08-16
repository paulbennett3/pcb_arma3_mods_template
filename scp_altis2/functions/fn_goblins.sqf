/* ****************************************************************************
**************************************************************************** */

params ["_pos", ["_side", east], ["_n", 3]];

private _ground_goblin = {
    params ["_pos", "_type", ["_offset", [0, 0, 0]], ["_vectorDirAndUp", [[0, 1, 0], [0, 0, 1]]]];
    private _result = [_pos, 0, "O_UGV_02_Science_F", _side] call BIS_fnc_spawnVehicle;
    private _veh = _result select 0;
    private _crew_list = _result select 1;
    private _group = _result select 2;
    private _gdx = 0;
    for [{_gdx = 0}, {_gdx < 16}, {_gdx = _gdx + 1}] do { 
        _veh setObjectMaterial [_gdx, "\a3\data_f\default.rvmat"];
        _veh setObjectTextureGlobal [_gdx, ""]; 
    };

    private _thing = _type createVehicle (getPosATL _veh);
    _thing attachTo [_veh, _offset];
    _thing setVectorDirAndUp _vectorDirAndUp;

    _group
};

private _air_goblin = {
    params ["_pos", "_type", ["_offset", [0, 0, 0]], ["_vectorDirAndUp", [[0, 1, 0], [0, 0, 1]]], ["_alt", 1]];
    private _result = [_pos, 0, "O_UAV_01_F", _side] call BIS_fnc_spawnVehicle;
    private _veh = _result select 0;
    private _crew_list = _result select 1;
    private _group = _result select 2;
    for [{_gdx = 0}, {_gdx < 16}, {_gdx = _gdx + 1}] do { 
        _veh setObjectMaterial [_gdx, "\a3\data_f\default.rvmat"];
        _veh setObjectTextureGlobal [_gdx, ""]; 
    };

    private _thing = _type createVehicle (getPosATL _veh);
    _thing attachTo [_veh, _offset];
    _thing setVectorDirAndUp _vectorDirAndUp;

    _veh flyInHeight _alt;

    _group
};

private _set_behaviour = {
    params ["_group", "_pos"];
/*
    private _wp = _group addWaypoint [_pos, 10];
    _wp setWaypointType "SAD"; 
    _wp setWaypointBehaviour "COMBAT"; 
    _wp setWaypointSpeed "NORMAL";
*/
    [_group, _pos, 500] call BIS_fnc_taskPatrol;
};


private _goblins = [
    [_ground_goblin, "Land_RaiStone_01_F", [0, -.2, 0.7], [[1, 0, 0], [0, 0, 1]] ],
    [_air_goblin, "Land_RaiStone_01_F", [0, 0, 0.2], [[0, 0, -1], [0, 1, 0]] ],
    [_ground_goblin, "Land_AncientHead_01_F", [0,0,0], [[0,-1,0],[0, 0, 1]] ]
];

private _make_goblin = {
    params ["_pos", "_data"];
    private _g = [
        _pos, 
        _data select 1,
        _data select 2,
        _data select 3
    ] call (_data select 0); 
    _g deleteGroupWhenEmpty true;        
    (units _g) apply { _x triggerDynamicSimulation false; };
    _g
};

private _ngdx = 0;
private _g = [_pos, selectRandom _goblins] call _make_goblin;
private _offset = 2;
for [{_ngdx = 0}, {_ngdx < _n}, {_ngdx = _ngdx + 1}] do {
    private _gt = [_pos vectorAdd [0, _offset, 0], selectRandom _goblins] call _make_goblin;
    _offset = _offset + 2;
    (units _gt) joinSilent _g;
};

[_g, _pos] call _set_behaviour;
[_g] call pcb_fnc_log_group;
_g
