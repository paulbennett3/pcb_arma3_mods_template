hint "test goblins running";

private _pos = (playableUnits select 0) getRelPos [12, 90];
private _range = 500;

private _types = ["I_UGV_02_Demining_F", "I_UAV_01_F"];

private _obj_list = [];
private _goblins = [];
private _group = createGroup civilian;
private _n = 2;
//for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
{
    //private _type = _types select _i;
    private _type = _x;

    private _veh = [_pos, random 360, _type, _group] call BIS_fnc_spawnVehicle;
    private _entity = _veh select 0;

    _entity triggerDynamicSimulation false;
//    _entity disableAI "AUTOCOMBAT";
//    _entity disableAI "COVER";
//    _entity disableAI "FSM";

    _obj_list pushBack _entity;
    _goblins pushBack _entity;
    _obj_list = _obj_list + (_veh select 1);

   // make it invisible
    private _ii = 0;
    while {true} do {
        _entity setObjectTextureGlobal [_ii, ""];
        _ii = _ii + 1;
        if (_ii > 15) exitWith {};
        sleep .1;
    };
// Example: make current uniform persistently blue
//private _texture = "#(rgb,8,8,3)color(0,0,1,1)"; // blue texture
//player setObjectTextureGlobal [0, _texture]; // set it on player
//uniformContainer player setVariable ["texture", _texture, true]; // store it on uniform

    private _lightpoint = "#lightpoint" createVehicle [0,0,0];
    _lightpoint attachTo [_entity, [0, 0, 0.5]];
    _lightpoint setLightColor [1,0,0.75]; 
    _lightpoint setLightUseFlare true;
    _lightpoint setLightFlareSize 1;
    _lightpoint setLightFlareMaxDistance 100;
    _lightpoint setLightAmbient [1, 0, 0.75];
    _lightpoint setLightIntensity 4; // units ?!?
    _lightpoint setLightDayLight true;

    _entity flyInHeight 2;
    sleep 1;
} forEach _types;

[_obj_list] joinSilent _group;
_group deleteGroupWhenEmpty true;
_group enableDynamicSimulation true;

["GOBLINS", "Goblins", getPosATL (_goblins select 0), 1] call pcb_fnc_objective_locate_object;

[_goblins, _range, _group] spawn {
    params ["_obj_list", "_range", "_group"];

    private _code = {
        params ["_self", "_range"];
       
        private _goal = selectRandom (_self nearEntities [["Man", "Car"], _range]);
        while {(_goal distance _self) < 5} do {
            sleep .1;
            _goal = selectRandom (_self nearEntities [["Man", "Car"], _range]);
        };
        _goal
    };
    //private _goal = [_obj_list select 0, _range] call _code;
    private _goal = playableUnits select 0;
    private _wp = _group addWaypoint [_goal, -1];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "CARELESS";
    _wp setWaypointCombatMode "BLUE";
    _wp setWaypointSpeed "NORMAL";
 
    while { sleep 1; alive (_obj_list select 0) } do {
        private _dist = _goal distance (_entities select 0);
        _wp setWaypointPosition [_goal, 5];
    };
};

{
    //private _texture = "#(rgb,8,8,3)color(1,1,1,1)"; // white texture
    private _texture = "#(rgb,8,8,3)color(0,0,0,1)"; // black texture
    _x setObjectTextureGlobal [0, _texture]; // set it on player
    uniformContainer _x setVariable ["texture", _texture, true]; // store it on uniform
} forEach playableUnits;

sleep 2;
private _ok = false;
if (alive (_obj_list select 0)) then { _ok = true; };

private _result = [_ok, _obj_list select 0];
_result;

