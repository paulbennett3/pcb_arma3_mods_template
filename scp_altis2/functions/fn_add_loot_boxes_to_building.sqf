/* ***********************************************************************
                add loot box to building

Params:
   _building (object, "house", must have paths) : place to put the box
   _chance (number, 0 to 100) : (optional, defaults to 10) chance of loot
         for each position in building.
*********************************************************************** */
params ["_building", ["_chance", 10], ["_max_boxes", 3]];

private _count = 0;
private _positions = [_building] call BIS_fnc_buildingPositions;
{
    if (_count < _max_boxes) then {
        if ((random 100) < _chance) then {
            private _pos = _x;
            if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { };

            private _box_type = selectRandom (types_hash get "boxes");
            private _box = _box_type createVehicle _pos;
            if (not isNull _box) then {
                [_box, 1 + (ceil (random 6))] call pcb_fnc_loot_crate;
                _count = _count + 1;
            };
        };
    };
} forEach _positions;

if (_count < 1) then {
    private _pos = selectRandom _positions;
    if ((isNil "_pos") || (! ([_pos] call pcb_fnc_is_valid_position))) exitWith { };
    private _box_type = selectRandom (types_hash get "boxes");
    private _box = _box_type createVehicle _pos;
    [_box, 1 + (ceil (random 6))] call pcb_fnc_loot_crate;
};
