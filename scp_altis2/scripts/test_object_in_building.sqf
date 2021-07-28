hint "test object in building called";

// spawn a building near the start position
//private _building = "Land_Medevac_HQ_V1_F" createVehicle start_pos;
private _building = createVehicle ["Land_Medevac_HQ_V1_F" , (playableUnits select 0) getRelPos [100, 180], [], 0, "NONE"];
private _positions = [_building] call BIS_fnc_buildingPositions;
temp = [];
{
    temp pushBack (_x select 2);
} forEach _positions;
sleep 1;
hint ("posns (" + (str (count _positions)) + ") " + (str temp));

{
    //private _pos = _x vectorAdd [0, 0, 0.25];
    private _pos = _x;
    _object_type = selectRandom (types_hash get "small items");
    _target = _object_type createVehicle [0,0,0];
    _target setPos _pos;
    sleep 1;
} forEach _positions;

