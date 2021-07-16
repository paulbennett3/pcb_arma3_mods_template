/* --------------------------------------------------------------------
                        spawn spare vehicles

Given the area of operation (ellipse), place random ground vehicles
for "background color" and for spares for the players.
-------------------------------------------------------------------- */

params 
[
    "_active_area", 
    "_buildings", 
    ["_min_n_vehicles", 30], 
    ["_max_n_vehicles", 80]
];

if (! isServer) exitWith {};

// don't put stuff in water or right at start position
private _blacklist = ["water", [start_pos, 500]];

// -----------------------------------------------
// generate a random number of "spare" vehicles 
// -----------------------------------------------
private _n_vehicles = _min_n_vehicles + (ceil ((_max_n_vehicles - _min_n_vehicles)* (random 1)));
// we scale this number based on "scale" (distance from start to epicenter)
_n_vehicles = _n_vehicles * density_scale;

private _placed = 0;
    
while {_placed < _n_vehicles} do {
    sleep 1;
    _veh = [_active_area, _buildings] call pcb_fnc_spawn_random_vehicle;

    if (! (isNull _veh)) then {
        _placed = _placed + 1;

        // note that we don't add the placed vehicle to our blacklist since
        //  there should be a chance (no matter how small!) that more than
        //  one vehicle is at a location
        
        if (pcb_DEBUG) then {
            // add a marker for reference
            private _mn = "M" + str ([] call pcb_fnc_get_next_UID); 
            private _m = createMarker [_mn, getPosATL _veh];
            _mn setMarkerShapeLocal "ELLIPSE";
            _mn setMarkerColorLocal "ColorBLACK";
            _mn setMarkerSizeLocal [50, 50];
            _mn setMarkerAlpha 0.9;
        };
    };
};

if (pcb_DEBUG) then { hint "all spare vehicles placed"; };
