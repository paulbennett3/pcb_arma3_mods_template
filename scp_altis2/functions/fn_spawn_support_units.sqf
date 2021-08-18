/* ******************************************************************
                         spawn support units

Build the data structure used to track our support squad, and
have the server state manager spawn the units

Called once at startup, on the server.
****************************************************************** */
params ["_pos", "_group"];

// Initialize our tracker data structure -- maps ID to unit object (objNull to start)
scp_support_unit_tracker = createHashMap;
private _id = 0;
for [{_id = 0 }, {_id < (count scp_support_units)}, {_id = _id + 1}] do {
    scp_support_unit_tracker set [_id, objNull];
};

// needs to be public since the server has the owner (leader) computer spawn the units
publicVariable "scp_support_unit_tracker";

// send a message to the server for each unit to be (re)spawned
for [{_id = 0 }, {_id < (count scp_support_units)}, {_id = _id + 1}] do {
    private _msg = ["respawn_ai", _id];
    [_msg] call pcb_fnc_send_mail;
    sleep 1.1;
};

