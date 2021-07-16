/* ****************************************************************************
                          do director spawn
**************************************************************************** */
private _did_spawn = false;

// pick the player to spawn on
private _player = player;
if ((count playableUnits) > 0) then {
    _player = selectRandom playableUnits;
};

// limit the number of units in the area
if ((count (_player nearEntities 2000)) > 100) exitWith { false };

// randomly select which encounter to spawn, then call its setup script
private _options = [
    "ambulance",
    "bandit_foot",
    "bandit_car",
    "civ",
    "police",
    "civ_air"
];

private _option = selectRandom _options;
switch (_option) do {
    case "ambulance": {
            _did_spawn = [_player, "C_Van_02_medevac_F", civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ": {
            _did_spawn = [_player] call pcb_fnc_enc_civ;
        };
    case "bandit_foot": {
            _did_spawn = [_player] call pcb_fnc_enc_bandits;
        };
    case "bandit_car": {
            private _type = selectRandom [
                "C_Truck_02_transport_F",
                "C_Quadbike_01_F",
                "C_Offroad_01_F",
                "C_Offroad_02_unarmed_F"
            ];
            _did_spawn = [_player, _type, east] call pcb_fnc_enc_vehicle_patrol;
        };
    case "police": {
            private _type = selectRandom [
                "B_GEN_Offroad_01_gen_F",
                "B_GEN_Van_02_vehicle_F",
                "B_GEN_Van_02_transport_F",
                "B_GEN_Offroad_01_comms_F"
            ];
            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
    case "civ_air": {
            private _type = selectRandom [
                "C_Plane_Civil_01_F",
                "C_Heli_Light_01_civil_F",
                "C_Heli_Light_01_civil_F",
                "C_Heli_Light_01_civil_F",
                "C_Heli_Light_01_civil_F"
            ];
            _did_spawn = [_player, _type, civilian] call pcb_fnc_enc_vehicle_patrol;
        };
};

_did_spawn;
