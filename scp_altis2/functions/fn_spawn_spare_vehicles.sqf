// ---------------------------------------------------------
//                    spawn spare vehicles
//
// spawn this so if it dies, our monitor doesn't die too ...
//
//  _buildings (list of building objects)
//  _chance (number between 0 and 1) : probability of spawn (not used randomly ...)
//  _label (string) : either "mil" or "civ"
// ---------------------------------------------------------
params ["_buildings", "_chance", "_label"];

[_buildings, _chance, _label] spawn {
    params ["_buildings", "_chance", "_label"];
    private _civ = true;
    if (_label isEqualTo "mil") then { _civ = false; }; 

    private _n_buildings = count _buildings;
    private _n = ceil (_n_buildings * _chance);
    ["There are <" + (str _n_buildings) + "> buildings in this cluster, will spawn <" + (str _n) + ">"] call pcb_fnc_debug;
    while { _n > 0 } do {
        private _veh = [[], _buildings, true, _civ] call pcb_fnc_spawn_random_vehicle;

        if (! (isNull _veh)) then {
            _n = _n - 1;
            [_veh, 1 + (ceil (random 5))] call pcb_fnc_loot_crate;

            if (pcb_DEBUG) then {
                // add a marker for reference
                private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
                private _m = createMarker [_mn, getPosATL _veh];
                _mn setMarkerShapeLocal "ELLIPSE";
                _mn setMarkerColorLocal "ColorBLACK";
                _mn setMarkerSizeLocal [50, 50];
                _mn setMarkerAlpha 0.9;
            };
        }; // if (! (isNull
    };  // while
};  // spawn
