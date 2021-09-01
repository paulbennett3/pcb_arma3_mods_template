/* ----------------------------------------------------------------------------------
                           force squad resupply

Called on local machine to force squad to resupply from object pointed to
---------------------------------------------------------------------------------- */

private _target = cursorObject;
systemChat ("object is <" + (str _target) + ">");

{
    if ((! isPlayer _x) && { ! stopped _x} ) then {
        [_x, _target] spawn {
            params ["_unit", "_crate"];
            _unit doMove (getPosATL _crate);
            private _tries = 12;
            while { sleep 5; ((_tries > -1) && { alive _unit }) } do {
                _tries = _tries - 1;
                if ((_unit distance2D _crate) > 5) then {
                    _unit doMove (getPosATL _crate);
                } else {
                    _tries = -10;
                    _unit action ["rearm", _crate];
                };
            };
        };
    };
} forEach (units player_group);
