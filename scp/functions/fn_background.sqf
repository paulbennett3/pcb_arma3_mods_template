/* --------------------------------------------------------------------
                          background

Setup (and spawn if needed) the "background" -- what is going on
besides / in addition to the mission(s)
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

// --------------------------------------------------------
// set up "situation"
// --------------------------------------------------------

// create our "Active" area where sites will be
if (true) then {
    private _temp = createVehicle ["Chemlight_green", start_pos, [], 0, "NONE"];
    // draw the mission "ellipse"
    private _dir = _temp getRelDir epicenter;
    private _dist = start_pos distance epicenter;
    private _half_dist = _dist / 2;
    private _midpoint = _temp getRelPos [_half_dist, _dir];
    private _a = 5000;
    private _b = 5000 + _dist;

    private _marker = createMarker ["mACTIVE", _midpoint];
    "mACTIVE" setMarkerShapeLocal "ELLIPSE";
    "mACTIVE" setMarkerSizeLocal [_a, _b]; 
    "mACTIVE" setMarkerDirLocal _dir;
    "mACTIVE" setMarkerAlpha 0;

    if (pcb_DEBUG) then {
        "mACTIVE" setMarkerColorLocal "ColorRED";
        "mACTIVE" setMarkerBrushLocal "BORDER";
        "mACTIVE" setMarkerAlpha 0.9;
    };

    active_area = ["mACTIVE"] call BIS_fnc_getArea;
    publicVariable "active_area";

// get a random position in area
//  _rpos = [["mACTIVE"], ["water"]] call BIS_fnc_randomPos;
// position inArea "mACTIVE";  // returns bool
// position inArea active_area;  // returns bool
};

/* ########################################################
                    Background 

######################################################## */
[active_area] spawn {
    params ["_active_area"];

    // generate a random number of "sites" / "scenes" to place
    private _min_n_sites = 10;
    private _max_n_sites = 30;
    private _n_sites = _min_n_sites + (ceil ((_max_n_sites - _min_n_sites)* (random 1)));
    private _placed = 0;
    private _blacklist = ["water", [start_pos, 500]];
    while {_placed < _n_sites} do {
        sleep 1;
        _rpos = [["mACTIVE"], _blacklist] call BIS_fnc_randomPos;
        private _is_valid = (((_rpos select 0) > 0) or ((_rpos select 1) > 0)); 

        if (_is_valid) then {
            _placed = _placed + 1;

            if (pcb_DEBUG) then {
                // add a marker for reference
                private _mn = "M" + str ([] call pcb_fnc_get_next_UID); 
                private _m = createMarker [_mn, _rpos];
                _mn setMarkerShapeLocal "ELLIPSE";
                _mn setMarkerColorLocal "ColorGREEN";
                _mn setMarkerBrushLocal "BORDER";
                _mn setMarkerSizeLocal [50, 50];
                _mn setMarkerAlpha 0.9;
            };
        };
    };

    if (pcb_DEBUG) then { hint "all placed"; };
};


/*
[] spawn {

        private _blacklist_near_players = [];
        {
            _blacklist_near_players pushBack [getPosATL _x, _min_dist];
        } forEach _players;

        {
            // see if there are any vehicles within range of the player
            private _pos = getPosATL _x;
            private _objs = nearestObjects [_pos, ["Car", "Truck"] , _max_dist];
            if ((count _objs) < 1) then {
                // find a good position.  Assume near a building and road
                // first find the nearest buildings, and use those as white lists for the 
                //  isOnRoads call
                //private _houses = nearestObjects [_pos, ["house"], _max_dist];
                private _houses = nearestTerrainObjects [
                    _pos, 
                    ["House", "Fuelstation", "Lighthouse", "Transmitter", "Church", "Hospital", "Transmitter"], 
                    _max_dist
                ];
                private _whitelist = [];
                private _blacklist = ["water"] + _blacklist_near_players;
                {
                    _whitelist pushBack [_x, 50];
                } forEach _houses;
                
                private _rpos = [
                    _whitelist, 
                    ["water"], 
                    { (isOnRoad _this) and ([_x, _this] call in_front_quadrant) }
                ] call BIS_fnc_randomPos;

                // _rpos = [0,0] means no position found ...
                if (((_rpos select 0) != 0) or ((_rpos select 1) != 0)) then {
                    private _type = ["car", "any"] call pcb_fnc_get_random_vehicle;
                    _veh = createVehicle [_type, _rpos, [], 5, "NONE"];
                    hint ("spawned " + _type);
                    [
                        "T" + str ([] call pcb_fnc_get_next_UID), 
                        "spawned car", 
                        _rpos, 
                        15
                    ] call pcb_fnc_objective_locate_object;  
                };
            };
        } forEach _players;

        sleep 10;
    };
};
*/


// BIS_fnc_nearestHelipad
// nearestObjects
