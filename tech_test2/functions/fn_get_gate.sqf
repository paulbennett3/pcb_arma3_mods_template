params ["_marker"];

private _loc = [];
private _dir = 0;

if (isNil "_marker") then {
   // no marker passed, so find a suitable area
   private _pos = getPosATL sgc_briefing;  // some reference location ...
   private _radius = 5000;
   private _n_sources = 1;
   private _expression = "5*hills + 2*forest - 2*houses - sea - waterDepth";
   private _my_places = selectBestPlaces [_pos, _radius, _expression, 25, _n_sources];
   private _best = _my_places select 0;
   _loc = _best select 0;
   _dir = 360 * (random 1);
} else {
   _loc = markerPos _marker;
   _dir = markerDir _marker;
};

private _gate = [_loc, _dir] call pcb_fnc_place_stargate;
_gate;
