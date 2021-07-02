private _pos_sgc = getPosATL sgc_briefing;
_pos_sgc set [2, (_pos_sgc select 2) + 500];
//_pos_sgc = [21600, 19000, 500];
_sgc = createVehicle ["sga_sgc_base", _pos_sgc, [], 0, 'CAN_COLLIDE'];
_sgc setDir 0;
_pos_sgc = getPosATL _sgc;

_temp = _pos_sgc vectorAdd [-11.937, -10.36, 1.0];
_stairs = createVehicle ["sga_ironstairs", _temp, [], 0, 'NONE'];
_stairs setDir 180; 
_gate = createVehicle ["sga_gate_orbital", _temp, [], 0, 'NONE'];
_gate setDir 180; 
_stairs attachTo [_gate, [0, 0, -0.75]];
_gate setVariable ["customname", "P3X123", true]; 

// create DHD
private _dhd_loc = _pos_sgc vectorAdd [-12.268, 9.246, 1.0]; 
private _dhd = createVehicle ["sga_sgc_gate_computer", _dhd_loc, [], 0, 'NONE']; 
_dhd setDir 180;

// synch gate and DHD
_gate synchronizeObjectsAdd [_dhd];
