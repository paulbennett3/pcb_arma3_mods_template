/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */

if (! isServer) exitWith {};

start_pos = getPosATL (playableUnits select 0);

// spawn our crate
private _start_crate = "Land_Pallet_MilBoxes_F" createVehicle start_pos;
// add a magic cargo section ...
_cargo = "Supply500" createVehicle [0,0,0];
_cargo attachTo [_start_crate, [0,0,0.85]];
// add our actual loadout ...
[_cargo] call compile preprocessFileLineNumbers "fn_crate_loadout.sqf";

private _code_range = {
    private _range_bands = [
                               10, 
                               20, 
                               30, 
                               40, 
                               50, 
                               75, 75, 75, 
                               100, 100, 100, 100, 100, 100, 100, 100, 
                               150, 150, 150, 150, 150, 150, 150, 150, 
                               200, 200, 200, 200, 200, 200, 200, 
                               250, 250, 250, 
                               300, 
                               350, 
                               400
    ];

    private _range_band = (selectRandom _range_bands);
    private _delta = ceil (_range_band / 2);
    private _range = _range_band + (random _delta) - (random _delta);
    _range
};
private _code_bearing = {
    private _bearing = ceil ((random 45) - (random 45));
    _bearing
};

private _state = createHashMap;
_state set ["type", "RyanZombieC_man_1slow"];
_state set ["group", createGroup east];
//_state set ["type", "C_man_polo_1_F"];
//_state set ["group", createGroup civilian];

private _bearing = 0;
{
    private _trg = "TargetP_Zom_F" createVehicle ((playableUnits select 0) getRelPos [_x, _bearing]);
    _bearing = _bearing + 5;
} forEach [50, 75, 100, 125, 150, 175, 200, 250, 300];

[_state, _code_range, _code_bearing] spawn {
    params ["_state", "_code_range", "_code_bearing"];
    hint "10 minutes ..."; sleep (8*60);
    hint "2 minutes ..."; sleep 60;
    hint "1 minute ..."; sleep 30;
    hint "30 seconds  ..."; sleep 10;
    hint "20 seconds  ..."; sleep 10;
    hint "10 seconds  ..."; sleep 5;
    hint "5 seconds  ..."; sleep 5;
    hint "Starting!";
    systemChat "Starting!";

    private _count = 0;
    while {sleep 1; true} do {
 
        private _range = [] call _code_range;
        private _bearing = [] call _code_bearing;
        private _pos = (playableUnits select 0) getRelPos [_range, _bearing];
        private _target = (_state get "group") createUnit [_state get "type", _pos, [], 0, "NONE"];
        [_target] joinSilent (_state get "group");
        sleep .1;
        if (alive _target) then {
            sleep (15 + (ceil (random 10)));
            _count = _count + 1;
            systemChat ("spawned " + (str _count) + " !");
        };
    };
};


