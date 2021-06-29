

// function for placing random stargate
private _gate = [] call compile preprocessFile "scripts\pcb_get_gate.sqf"; 
private _gate_name = _gate getVariable "customname";
hint ("running explore mission - gate" + _gate_name);

