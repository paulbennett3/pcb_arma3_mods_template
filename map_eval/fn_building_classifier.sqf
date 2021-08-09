/* ***********************************************************************
                      building_classifier

Params:
    _building (object) : a building object

Returns:
    classified type (string) : "military", "city", "unk"
*********************************************************************** */
params ["_building"];

private _classes = ["MILITARY", "CIVILIAN", "INDUSTRIAL", "MIL", "CIV", "IND", "USARMY"];
private _type = typeOf _building;
private _config = configOf _building;
private _model = [_config >> "model"] call BIS_fnc_getCfgData;

private _fields = (_model splitString "\") apply { toUpper _x };
private _class = _fields arrayIntersect _classes;
if ((count _class) == 0) then {
    _class = "UNK";
} else {
    _class = (_class select 0) select [0, 3];
};
if (_class isEqualTo "USA") then { _class = "MIL"; };


_class
