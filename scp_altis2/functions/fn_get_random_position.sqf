/* ******************************************************************
                   fn_get_random_position

Select a random position near the specified player
****************************************************************** */

params ["_player"];
private _vobj = _player;
private _vtemp = [_player] call pcb_fnc_player_in_vehicle;
if (_vtemp select 0) then { _vobj = (_vtemp select 1) select 0; };
private _whitelist = [ [_vobj getRelPos [ENC_DIST, 0], ENC_RADIUS] ];
private _blacklist = [ "water" ];
private _pos = [0, 0];
private _tries = 10;

// did we get a valid position?
while { _tries > 0 } do {
    _pos = [_whitelist, _blacklist] call BIS_fnc_randomPos;
    if (! ([_pos] call pcb_fnc_is_valid_position)) then {
        _tries = _tries - 1;
    } else {
        _tries = 0;
    };
};

private _result = [false, [0, 0]];
if (! ([_pos] call pcb_fnc_is_valid_position)) exitWith { ["find random position - not valid position"] call pcb_fnc_debug; _result };

// are there any players in the area?
if ([ [_pos, ENC_MIN_PLAYER_DIST_CREATE] ] call pcb_fnc_players_in_area) exitWith { ["find random position - playerrs in range"] call pcb_fnc_debug; _result };

_result = [true, _pos];
_result
