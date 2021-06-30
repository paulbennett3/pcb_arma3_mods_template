// #################################################
// pick an area to put our stargate in
// should be well away from SGC and other stargates ...

private _loc_assigned = false;
private _loops = 0;
private _loc = [0, 0];

while {!_loc_assigned } do {
    // Pick an initial spot well away from the SGC and other gates
    // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
    _loc = [[], 2000, -1, 10, 0, 0.1, 0, pcb_gate_blacklist] call BIS_fnc_findSafePos;

    // now that we have an initial random position, find a suitable spot near it
    private _filter = "5*hills + 2*forest - 5*houses - 5*sea";
    private _nsources = 1;
    private _arr = selectBestPlaces [_loc, 1000, _filter, 50, _nsources];

    // returns array of sources -- pick the "best"
    private _best = _arr select 0;
    _loc = _best select 0;

    // find an "area" centered on our location we just picked
    //   Acceptance code:
    //      flattish for 5 meters from position, no object within minDistance meters of position
    _area = [_loc, 100] call BIS_fnc_getArea; // get an "area" from object
    _loc = [
               [_area], 
               pcb_gate_blacklist, 
               { count (_this isFlatEmpty [20, -1, 0.1, 5, 0, false, objNull]) > 0 }
           ] call BIS_fnc_randomPos;

    _loc_assigned =  ((_loc select 0) > 0) && ((_loc select 1) > 0);

    _loops = _loops + 1;
    if (! _loc_assigned) then {
        if (_loops > 30) then {
            _loc_assigned = true;
            hint "FAILED TO GET GOOD LOC";
        };
    };
};

// add our gate to the blacklist for later
pcb_gate_blacklist pushBack [_loc, 2000];
publicVariable "pcb_gate_blacklist";


private _dir = random 360;

[_loc, _dir]
