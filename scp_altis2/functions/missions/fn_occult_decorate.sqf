/* **************************************************************
               occult decorate 
************************************************************** */
params ["_pos", ["_building", objNull]];

private _blood = (types_hash get "blood");
private _bones = (types_hash get "bones");
private _detritus = (types_hash get "detritus");

private _stuff = _blood + _blood + _bones + _bones + _bones + _bones + _bones + _detritus;
private _n = 5 + (ceil (random 10));
for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
    private _type = selectRandom _stuff;
    private _veh = createVehicle [_type, _pos, [], 5, 'CAN_COLLIDE'];
    _veh setDir (random 360); 
    _veh setPos getPos _veh;
}

