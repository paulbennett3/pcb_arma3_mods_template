/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */

if (! isServer) exitWith {};

[] spawn {
    private _radius = 750;
    private _count = 0;
    while {true} do {
        _count = _count + 1;
        private _pos = getPosATL (playableUnits select 0);
        private _marker = createMarker ["TRACKER" + (str _count), _pos];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerSizeLocal [_radius, _radius];
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorRED";        
        sleep 10;
    };
};
start_pos = getPosATL (playableUnits select 0);


[] spawn {
    private _crate2 = "Land_PlasticCase_01_large_olive_CBRN_F" createVehicle ((playableUnits select 0) getRelPos [25, 90]);
    _crate2 addaction ["Open Virtual Arsenal", { ["Open",true] call BIS_fnc_arsenal; }];

};

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
//_state set ["type", "RyanZombieC_man_1slow"];
//_state set ["group", createGroup east];
_state set ["type", "C_man_polo_1_F"];
//_state set ["group", createGroup civilian];
_state set ["group", createGroup east];

[_state, _code_range, _code_bearing] spawn {
    params ["_state", "_code_range", "_code_bearing"];
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
        _target setUnitPos (selectRandom ["DOWN", "UP", "MIDDLE"]);
        sleep .1;
        _target disableAI "all";

        sleep .1;
        if (alive _target) then {
            sleep (15 + (ceil (random 10)));
            _count = _count + 1;
            systemChat ("spawned " + (str _count) + " !");
        };
    };
};


