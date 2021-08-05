/* --------------------------------------------------------------------
                         mark active area 

Generate the "bounding ellipse" marker for use in population, 
background, etc.

Requires epicenter (created preinit in fn_preinit) and start_pos (fn_random_start_position)
to be defined!
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
