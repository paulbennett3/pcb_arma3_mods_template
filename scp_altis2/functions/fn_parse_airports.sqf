/* --------------------------------------------------------------------------------------
                                parse airports

Read the airport information for this map from the config file
Also calculates the direction of the runway

No inputs (uses config info).

Outputs are via the public variable "All_airfields", which is a list
   for every airfield on the map (primary and secondary) of:
      [position, ilsDirection (vector), direction (actual x-y angle)]
-------------------------------------------------------------------------------------- */

if (! isServer) exitWith {};

// Get location of all Airports, primary and secondary
// makes array of [ [[loc1], [dir1]], [[loc2], [dir2]], ...
All_airfields = [];
if (count allAirports > 0) then {
    private _first = [getArray (configfile >> "CfgWorlds" >> worldname >> "ilsPosition"),
                      getArray (configfile >> "CfgWorlds" >> worldname >> "ilsDirection")];
    All_airfields pushbackunique _first;
    private _sec = (configfile >> "CfgWorlds" >> worldname >> "SecondaryAirports");
    for "_i" from 0 to (count _sec - 1) do {
        private _ils_position = getarray ((_sec select _i) >> "ilsPosition");
        private _ils_direction = getarray ((_sec select _i) >> "ilsDirection");

        // calculate runway direction (as opposed to ilsDirection, which is a direction vector [x, z, y]
        private _dir_x = _ils_direction select 0;
        private _dir_y = _ils_direction select 2; // yes, it is (x, z, y). WTF?!?
        private _dir = 180 + (_dir_x atan2 _dir_y); 
        if (_dir > 360) then { _dir = start_dir - 360; };

        All_airfields pushbackunique [_ils_position, _ils_direction, _dir];
    };
} else {
   ["ERROR! No airports returned by <allAirports>?!?"] call pcb_fnc_debug;
};
publicVariable "ALL_airfields";

