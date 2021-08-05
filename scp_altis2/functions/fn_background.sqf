/* --------------------------------------------------------------------
                          background

Setup (and spawn if needed) the "background" -- what is going on
besides / in addition to the mission(s)


!!! Uses start_pos, "mACTIVE"
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

waitUntil { ! isNil "random_start_ready" };
waitUntil { ! isNil "start_pos" };
waitUntil { ! isNil "start_dir" };

// ------------------------------------------------
// create our "Active" area where sites will be
// ------------------------------------------------
private _radius = mission_radius;  // mission radius

// need an object for getRelDir and getRelPos ...
start_chemlight = createVehicle ["Chemlight_green", start_pos, [], 0, "NONE"];
publicVariable "start_chemlight";

// create the active area "ellipse" -- we use this as an area later
private _dir = start_chemlight getRelDir epicenter;
private _dist = start_pos distance epicenter;
private _half_dist = _dist / 2;
private _midpoint = start_chemlight getRelPos [_half_dist, _dir];
private _a = _radius;
private _b = _radius + _dist;

density_scale = 1 + (_dist / _radius); 
publicVariable "density_scale";

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

//active_area = ["mACTIVE"] call BIS_fnc_getArea;
active_area = "mACTIVE";
publicVariable "active_area";
sleep .1;



/* ########################################################
                    Background 

######################################################## */
waitUntil { ! isNil "active_area" };
[active_area] spawn {
    params ["_active_area"];

    sleep 10;

    // -----------------------------------------------
    // get a list of all "buildings" -- using worldSize, so pretty much everything on map 
    // this generates a list of on the order of 18,000 objects on Altis!  SUBSAMPLE!!!!
    //
    // !!!! Currently just used for spawn_spare_vehicles -- move it in there if not used elsewhere !!!!!!!!
    // -----------------------------------------------
    private _buildings = nearestTerrainObjects [
        start_pos,
        types_hash get "svbuildings",
        worldSize
    ];

    // -----------------------------------------------
    // generate a random number of "spare" vehicles 
    // -----------------------------------------------
    [_active_area, _buildings] spawn {
        params ["_active_area", "_buildings"];
        [_active_area, _buildings] call pcb_fnc_spawn_spare_vehicles;
    };

    // -----------------------------------------------
    // generate "spare" helicopters
    // -----------------------------------------------
    [_active_area, _buildings] spawn {
        [] call pcb_fnc_spawn_spare_helicopters;
    };

    // -----------------------------------------------
    // "populate" cities
    // -----------------------------------------------
    [_active_area] spawn {
        params ["_active_area"];
        [_active_area] call pcb_fnc_populate_cities;
    };

};

