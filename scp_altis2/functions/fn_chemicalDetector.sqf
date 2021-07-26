// ------------------------
// chemicalDetector.sqf
// ------------------------
//  call locally for player with (say in initPlayerLocal.sqf);
//   
//  [object, maxDistance, minDistance, condition] execVM "chemicalDetector.sqf";
//
//     object -- the object the chemical detector is tracking
//     maxDistance -- the maximum distance the detector can sense the object -- will read 0 at or beyond this distance
//     minDistance -- default 0.  Closer than this distance maxes out the sensor
//     condition -- default true -- code to execute if the threat level should continue to be updated (ie, if threat "eliminated")    
//
//  from https://github.com/jshayes/arma3-chemical-detector
// ------------------------

if (!hasInterface) exitWith {};

params ["_object", "_maxDistance", ["_minDistance", 0], ["_condition", {true}]];

"ChemicalDetector" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];

private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
private _ctrl = _ui displayCtrl 101;

_maxDistance = _maxDistance - _minDistance;

while _condition do {
	private _distance = ((player distance _object) - _minDistance) max 0;

	private _threat = ((1 - (_distance/_maxDistance)) max 0) min 1;
	_ctrl ctrlAnimateModel ["Threat_Level_Source", [_threat, 2] call BIS_fnc_cutDecimals, true];

	sleep 1;
};
