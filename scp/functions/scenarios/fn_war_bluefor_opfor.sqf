/* ***********************************************************************
                     _war_bluefor_opfor

Scenario -- war between Bluefor and Opfor

Args:
    _active_area (string) : marker indicating active area of play
*********************************************************************** */

if (! isNil "background_init") exitWith {};
background_init = 1;
publicVariable "background_init";

params ["_active_area", "_buildings"];

sleep 1;

// don't put stuff in water or right at start position
private _blacklist = ["water", [start_pos, 500]];

// ---------------------------------------------------------
// Test Section
// ---------------------------------------------------------
/*
private _types_lists = [
    [
        "Bandit 1", 
        [
            "I_L_Looter_Pistol_F",
            "I_L_Looter_Pistol_F",
            "I_L_Looter_Pistol_F",
            "I_L_Looter_SG_F",
            "I_L_Looter_SG_F",
            "I_L_Looter_Rifle_F" 
        ]
    ],
    [
        "MIB 1", 
        [
            "C_Man_formal_1_F",
            "C_Man_formal_2_F",
            "C_Man_formal_3_F",
            "C_Man_formal_1_F",
            "C_Man_formal_1_F"
        ]
    ]
];

[_types_lists] call pcb_fnc_spawn_support_units;


// spawn a  tank with crew
[
    getPosATL (playableUnits select 0), 
    getDir (playableUnits select 0), 
    "B_T_MBT_01_cannon_F",
    group (playableUnits select 0)   // side (playableUnits select 0)
] call BIS_fnc_spawnVehicle;

*/

// ---------------------------------------------------------
// generate a random number of "sites" / "scenes" to place
// ---------------------------------------------------------
[_active_area, _buildings] spawn {
    params ["_active_area", "_buildings"];
    [_active_area, _buildings] call pcb_fnc_background_war_bluefor_opfor;
};

private _min_n_sites = 10;
private _max_n_sites = 30;
private _n_sites = _min_n_sites + (ceil ((_max_n_sites - _min_n_sites)* (random 1)));
private _placed = 0;
while {_placed < _n_sites} do {
    sleep 1;
    _rpos = [["mACTIVE"], _blacklist] call BIS_fnc_randomPos;
    private _is_valid = (((_rpos select 0) > 0) or ((_rpos select 1) > 0)); 

    if (_is_valid) then {
        _placed = _placed + 1;

        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // !!!!!! add the true location of the site to our blacklist !!!!!
        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        if (pcb_DEBUG) then {
            // add a marker for reference
            private _mn = "M" + str ([] call pcb_fnc_get_next_UID); 
            private _m = createMarker [_mn, _rpos];
            _mn setMarkerShapeLocal "ELLIPSE";
            _mn setMarkerColorLocal "ColorGREEN";
            // _mn setMarkerBrushLocal "BORDER";
            _mn setMarkerSizeLocal [50, 50];
            _mn setMarkerAlpha 0.9;
        };
    };
};

if (pcb_DEBUG) then { hint "all sites placed"; };
