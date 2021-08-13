/* -----------------------------------------------------------
                   initServer
----------------------------------------------------------- */

if (! isServer) exitWith {};
private _types = [ "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F", "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F" ];
private _group = [_types, 5, getPosATL (playableUnits select 0), east, false] call compile preprocessFileLineNumbers "fn_spawn_squad.sqf";
[_group] call compile preprocessFileLineNumbers "fn_spawn_cultists.sqf";
[getPosATL (playableUnits select 0)] call compile preprocessFileLineNumbers "fn_goblins.sqf";
