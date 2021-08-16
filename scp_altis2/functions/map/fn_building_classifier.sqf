/* ***********************************************************************
                      building_classifier

Params:
    _building (object) : a building object

Returns:
    classified type (string) : "military", "city", "unk"
*********************************************************************** */
params ["_building"];

private _classes = [
    "MILITARY", "MIL", "USARMY", 
    "INDUSTRIAL", "IND", "CULTURAL", "CEMETERIES", "DOMINANTS",
    "CIVILIAN", "CIV", "COMMERCIAL", "HOUSEHOLDS", "HOUSE", "RUINS"
];
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
if (_class isEqualTo "HOU") then { _class = "CIV"; };
if (_class isEqualTo "RUI") then { _class = "CIV"; };
if (_class isEqualTo "COM") then { _class = "CIV"; };
if (_class isEqualTo "CUL") then { _class = "IND"; };
if (_class isEqualTo "CEM") then { _class = "IND"; };
if (_class isEqualTo "DOM") then { _class = "IND"; };


_class
