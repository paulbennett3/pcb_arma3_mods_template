// given a position, teleport all playable units that
//  aren't players to the position
params ["_pos"];

// sometimes have units in vehicle ...
playableUnits orderGetIn false;

// might also want to test if unit within X distance of player ...
{ 
    if (not (isPlayer _x)) then {
        _x setVehiclePosition [_pos, [], 0, "NONE"];
    };
} forEach playableUnits;
