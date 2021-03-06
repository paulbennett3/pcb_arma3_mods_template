/* ********************************************************
                         mine road

Given a position, radius, and optional number of mines,
place mines on road sections
******************************************************** */
params ["_pos", "_radius", ["_n_mines", 5]];

private _type = selectRandom [
    "APERSMine", "APERSBoundingMine", "APERSTripMine", "ATMine"
];

for [{_i = 0 }, {_i < _n_mines}, {_i = _i + 1}] do {
    private _rpos = [
        [_pos, _radius],
        ["water"],
        { isOnRoad _this }
    ] call BIS_fnc_randomPos; 

    if ([_rpos] call pcb_fnc_is_valid_position) then {
        _rpos = [_rpos select 0, _rpos select 1];
        createMine [_type, _rpos, [], "NONE"];
    };
};
