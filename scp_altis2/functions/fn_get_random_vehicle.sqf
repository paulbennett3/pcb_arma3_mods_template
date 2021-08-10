/* --------------------------------------------------------------------------
                              get random vehicle

given a type (car, heli) and other qualifiers, return random type string
-------------------------------------------------------------------------- */

params ["_class", "_size", ["_civ", true]];
private _result = objNull;

private _chance_mil = 10;

if (_class isEqualTo "car") then {
    switch {_size} do {
        case "small": {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (types_hash get "car small mil");
            } else {
                _result = selectRandom (types_hash get "car small civ");
            };
        };
        case "medium": {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (types_hash get "car medium mil");
            } else {
                _result = selectRandom (types_hash get "car medium civ");
            };
        };
        case "large": {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (types_hash get "car large mil");
            } else {
                _result = selectRandom (types_hash get "car large civ");
            };
        };
        default {
            if ( (! _civ) || ((random 100) < _chance_mil)) then {
                _result = selectRandom (
                   (types_hash get "car small mil") +
                   (types_hash get "car medium mil") +
                   (types_hash get "car large mil") 
                );
            } else {
                _result = selectRandom (
                   (types_hash get "car small civ") +
                   (types_hash get "car medium civ") +
                   (types_hash get "car large civ") 
                );
            };
        };
    };
};


_result;
