/* ------------------------------------------------------------
                     handle resupply

Does processing of resupply requests via chat message

format "resupply XXX at YYY"
  where XXX is in ["medical", "ammo", "support"]
        YYY is grid reference
  example:
      resupply ammo at 120101

Parameters:
    _name (string) : display name of caller
    _text (string) : the chat text to process
    _owner (???) : owner ID of caller
------------------------------------------------------------ */
if (! isServer) exitWith {};

params ["_name", "_text", "_owner"];

// Set up a handler for chat messages (resupply et al)
//addMissionEventHandler ["HandleChatMessage", _handler ];

private _mode = "UNKNOWN";
private _temp = toLowerANSI _text;
if ("resupply ammo" in _temp) then { _mode = "ammo"; };
if ("resupply support" in _temp) then { _mode = "support"; };
if ("resupply medical" in _temp) then { _mode = "medical"; };
if ("resupply there" in _temp) then { _mode = "squad_resupply"; };

if (_mode in ["ammo", "support", "medical"]) then {
    private _fields = _temp splitString " ";
    private _grid = _fields select 3;
    // returns [[x, y], [width, height]]
    private _pos_gsize = _grid call BIS_fnc_gridToPos;  
    private _pos = _pos_gsize select 0;
    private _gsize = _pos_gsize select 1;

    // if there isn't smoke, we use the center of the grid as a target, and large dispersion
    private _pos = [(_pos select 0) + ((_gsize select 0)/2), 
                    (_pos select 1) + ((_gsize select 1)/2)]; 
    // figure out who is calling for it, and what their position is
    private _units = playableUnits select { ((owner _x) == _owner) && { isPlayer _x} };
    if ((count _units) == 1) then {
        private _unit = _units select 0;
        private _pos = getPosATL _unit;
        private _delay = selectRandom [30, 60, 60, 60, 90]; 
        private _str = "Roger that, " + _name + ", sending " + _mode + " to " + 
                       _grid + ", pop smoke in " + (str _delay) + " seconds";
        [_str] remoteExec ["systemChat", 0];
        _delay = _delay + 10;

        private _crate = objNull;
        switch (_mode) do {
            case "ammo": { 
                _crate = "B_supplyCrate_F" createVehicle [0, 0, 0];
            };
            case "medical": { 
                _crate = "ACE_medicalSupplyCrate_advanced" createVehicle [0, 0, 0];
            };
            case "support": { 
                _crate = "ACE_Box_Misc" createVehicle [0, 0, 0];
            };
        };

        private _dispersion = 300;
        [_unit, _pos, _crate, _dispersion, _name, _mode, _delay] spawn {
            params ["_unit", "_pos", "_crate", "_dispersion", "_name", "_mode", "_delay"];
            sleep _delay;
            // is there smoke in the grid reference?
            private _objects = (_pos nearObjects 300) select { "smoke" in (toLowerANSI (typeOf _x)) };
            if ((! (isNil "_objects")) && ((count _objects > 0))) then {
                [_name + " pilot sees your smoke and " + _mode + " inbound on target"] remoteExec ["systemChat", 0];
                _pos = getPosATL (_objects select 0);
                _dispersion = 5 + (random 10);
            } else {
                [_name + " pilot reports no smoke seen, but " + _mode + " dropping"] remoteExec ["systemChat", 0];
            };

            [_unit, _pos, _crate, _dispersion] call pcb_fnc_paradrop_stuff;       
        };
    };
};
    
// Used to command squad to resupply at object pointed to
if (_mode in ["squad_resupply"]) then {
    hint ("squad resupply requested");
    [] remoteExec ["pcb_fnc_force_squad_resupply", _owner];
};
