/* ******************************************************************
                  spawn spare helicopters

Put helicopters on all the helipads on the map
****************************************************************** */
// only let this run once!!!!
if (! isNil "spare_heli_spawner") exitWith {};
spare_heli_spawner = true; publicVariable "spare_heli_spawner";

{
    private _pos = getPosATL _x;
    private _type = selectRandom [
        "vn_b_air_uh1d_01_04",
        "vn_b_air_uh1d_01_06",
        "vn_b_air_uh1d_01_07",
        "vn_o_air_mi2_01_01",
        "vn_o_air_mi2_01_02",
        "vn_i_air_ch34_02_02",
        "B_Heli_Transport_03_unarmed_F",
        "O_Heli_Transport_04_covered_F",
        "O_Heli_Light_02_unarmed_F",
        "I_Heli_light_03_unarmed_F",
        "B_Heli_Light_01_F",
        "B_Heli_Light_01_F",
        "B_Heli_Light_01_F",
        "C_Heli_Light_01_civil_F",
        "C_Heli_Light_01_civil_F",
        "C_Heli_Light_01_civil_F",
        "C_Heli_Light_01_civil_F",
        "C_Heli_Light_01_civil_F"
    ]; 

    _veh = createVehicle [_type, _pos, [], 0, "NONE"];
    _veh setVariable ["BIS_enableRandomization", false];
    _veh setDir (random 360);
    sleep .1;

    // add a repair facility
    private _repair = types_hash get "static repair";
    _type = selectRandom _repair;
    _veh = createVehicle [_type, _x getRelPos [7, 90], [], 0, "NONE"];

    // add a "cargo" pod
    private _cargo = types_hash get "static cargo";
    _type = selectRandom _cargo;
    _veh = createVehicle [_type, _x getRelPos [7, 180], [], 0, "NONE"];



    if (pcb_DEBUG) then {
        private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
        private _m = createMarker [_mn, _pos];
        _mn setMarkerShapeLocal "ELLIPSE";
        _mn setMarkerColorLocal "ColorBLUE";
        _mn setMarkerSizeLocal [150, 150];
        _mn setMarkerAlpha 0.9;
    };

    sleep .1;
} forEach ((playableUnits select 0) nearObjects ["Helipad_Base_F", worldSize]);
// } forEach (nearestObjects [playableUnits select 0, ["HeliH"], worldSize]);
